import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct UserDefaultsMacro: AccessorMacro, PeerMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        let name = try declaration.name()
        let key = try node.attribute(withKey: "key") ?? "\"\(try declaration.name())\""
        let fallback = try declaration.initializer() ?? "nil"
        
        if let type = try declaration.type() {
            return [
                """
                    var $\(raw: name): UserDefaultsPropertyData<\(raw: type)> =
                        .init(
                            key: \(raw: key),
                            fallback: \(raw: fallback)
                        )
                """
            ]
        } else {
            return [
                """
                    var $\(raw: name): UserDefaultsPropertyData =
                        .init(
                            key: \(raw: key),
                            fallback: \(raw: fallback)
                        )
                """
            ]
        }
    }
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingAccessorsOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in _: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.AccessorDeclSyntax] {
        let key = try node.attribute(withKey: "key") ?? "\"\(try declaration.name())\""
        let fallback = try declaration.initializer() ?? "nil"
        
        return [
            """
            get {
                return _uf_get(
                    forKey: \(raw: key),
                    withFallback: \(raw: fallback)
                )
            }
            set {
                _uf_set(
                    value: newValue,
                    forKey: \(raw: key)
                )
            }
            """,
        ]
    }
}

extension SwiftSyntax.DeclSyntaxProtocol {
    func name() throws -> String {
        guard let variableDecl = self.as(VariableDeclSyntax.self) else {
            throw UserDefaultsMacroMacroError.error("not variableDecl")
        }
        guard let identifier = variableDecl.bindings.first?.pattern.as(IdentifierPatternSyntax.self) else {
            throw UserDefaultsMacroMacroError.error("not identifier")
        }
        let name = identifier.identifier.text
        return name
    }
    
    func type() throws -> String? {
        guard let variableDecl = self.as(VariableDeclSyntax.self) else {
            throw UserDefaultsMacroMacroError.error("not variableDecl")
        }
        guard let typeAnnotation = variableDecl.bindings.first?.typeAnnotation?.as(TypeAnnotationSyntax.self) else {
            return nil
        }
        return typeAnnotation.type.description
    }
    
    func initializer() throws -> String? {
        guard let variableDecl = self.as(VariableDeclSyntax.self) else {
            throw UserDefaultsMacroMacroError.error("not variableDecl")
        }
        guard let identifier = variableDecl.bindings.first?.initializer?.as(InitializerClauseSyntax.self) else {
            return nil
        }
        return identifier.value.description.trimmingCharacters(in: .whitespaces)
    }
}

extension SwiftSyntax.AttributeSyntax {
    func attribute(withKey key: String) -> String? {
        let macroKey = arguments?.as(LabeledExprListSyntax.self)?.first(where: { $0.label?.text == key })
        return macroKey?.expression.formatted().description.trimmingCharacters(in: .whitespaces)
    }
}

enum UserDefaultsMacroMacroError: Error {
    case error(String)
}
