// Generated from MODLLexer.g4 by ANTLR 4.7.2
import Antlr4

open class MODLLexer: Lexer {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = MODLLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(MODLLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let WS=1, NULL=2, TRUE=3, FALSE=4, COLON=5, EQUALS=6, STRUCT_SEP=7, 
            ARR_SEP=8, LBRAC=9, RBRAC=10, LSBRAC=11, RSBRAC=12, NUMBER=13, 
            COMMENT=14, STRING=15, HASH_PREFIX=16, QUOTED=17, GRAVED=18, 
            LCBRAC=19, CWS=20, QMARK=21, FSLASH=22, GTHAN=23, LTHAN=24, 
            ASTERISK=25, AMP=26, PIPE=27, EXCLAM=28, CCOMMENT=29, RCBRAC=30

	public
	static let CONDITIONAL=1
	public
	static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public
	static let modeNames: [String] = [
		"DEFAULT_MODE", "CONDITIONAL"
	]

	public
	static let ruleNames: [String] = [
		"WS", "NULL", "TRUE", "FALSE", "COLON", "EQUALS", "STRUCT_SEP", "ARR_SEP", 
		"LBRAC", "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "INT", "EXP", "COMMENT", 
		"INSIDE_COMMENT", "STRING", "UNRESERVED", "RESERVED_CHARS", "ESCAPED", 
		"UNICODE", "HEX", "HASH_PREFIX", "QUOTED", "INSIDE_QUOTES", "GRAVED", 
		"INSIDE_GRAVES", "LCBRAC", "CWS", "CNULL", "CTRUE", "CFALSE", "CCOLON", 
		"CEQUALS", "CSTRUCT_SEP", "CLBRAC", "CRBRAC", "CLSBRAC", "CRSBRAC", "CNUMBER", 
		"QMARK", "FSLASH", "GTHAN", "LTHAN", "ASTERISK", "AMP", "PIPE", "EXCLAM", 
		"CLCBRAC", "CSTRING", "CUNRESERVED", "CRESERVED_CHARS", "CESCAPED", "CCOMMENT", 
		"CQUOTED", "CGRAVED", "RCBRAC"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, nil, nil, nil, nil, nil, nil, "','", nil, nil, nil, nil, nil, 
		nil, nil, nil, nil, nil, "'{'", nil, "'?'", "'/'", "'>'", "'<'", "'*'", 
		"'&'", "'|'", "'!'", nil, "'}'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "WS", "NULL", "TRUE", "FALSE", "COLON", "EQUALS", "STRUCT_SEP", "ARR_SEP", 
		"LBRAC", "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "COMMENT", "STRING", "HASH_PREFIX", 
		"QUOTED", "GRAVED", "LCBRAC", "CWS", "QMARK", "FSLASH", "GTHAN", "LTHAN", 
		"ASTERISK", "AMP", "PIPE", "EXCLAM", "CCOMMENT", "RCBRAC"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)


	override open
	func getVocabulary() -> Vocabulary {
		return MODLLexer.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, MODLLexer._ATN, MODLLexer._decisionToDFA, MODLLexer._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "MODLLexer.g4" }

	override open
	func getRuleNames() -> [String] { return MODLLexer.ruleNames }

	override open
	func getSerializedATN() -> String { return MODLLexer._serializedATN }

	override open
	func getChannelNames() -> [String] { return MODLLexer.channelNames }

	override open
	func getModeNames() -> [String] { return MODLLexer.modeNames }

	override open
	func getATN() -> ATN { return MODLLexer._ATN }


	public
	static let _serializedATN: String = MODLLexerATN().jsonString

	public
	static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}