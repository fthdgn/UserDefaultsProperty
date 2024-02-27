import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct _CompilerPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        UserDefaultsMacro.self,
    ]
}
