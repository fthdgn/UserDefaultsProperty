@attached(accessor)
@attached(peer, names: prefixed(`$`))
public macro UserDefaultsProperty(key: String? = nil)
= #externalMacro(module: "UserDefaultsPropertyMacros", type: "UserDefaultsMacro")
