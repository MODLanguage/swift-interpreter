// Generated from MODLParser.g4 by ANTLR 4.7.2
import Antlr4

open class MODLParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = MODLParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(MODLParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, WS = 1, NULL = 2, TRUE = 3, FALSE = 4, COLON = 5, EQUALS = 6, 
                 STRUCT_SEP = 7, ARR_SEP = 8, LBRAC = 9, RBRAC = 10, LSBRAC = 11, 
                 RSBRAC = 12, NUMBER = 13, COMMENT = 14, STRING = 15, HASH_PREFIX = 16, 
                 QUOTED = 17, GRAVED = 18, LCBRAC = 19, CWS = 20, QMARK = 21, 
                 FSLASH = 22, GTHAN = 23, LTHAN = 24, ASTERISK = 25, AMP = 26, 
                 PIPE = 27, EXCLAM = 28, CCOMMENT = 29, RCBRAC = 30
	}

	public
	static let RULE_modl = 0, RULE_modl_structure = 1, RULE_modl_map = 2, RULE_modl_array = 3, 
            RULE_modl_nb_array = 4, RULE_modl_pair = 5, RULE_modl_value_item = 6, 
            RULE_modl_top_level_conditional = 7, RULE_modl_top_level_conditional_return = 8, 
            RULE_modl_map_conditional = 9, RULE_modl_map_conditional_return = 10, 
            RULE_modl_map_item = 11, RULE_modl_array_conditional = 12, RULE_modl_array_conditional_return = 13, 
            RULE_modl_array_item = 14, RULE_modl_value_conditional = 15, 
            RULE_modl_value_conditional_return = 16, RULE_modl_condition_test = 17, 
            RULE_modl_operator = 18, RULE_modl_condition = 19, RULE_modl_condition_group = 20, 
            RULE_modl_value = 21, RULE_modl_array_value_item = 22, RULE_modl_primitive = 23

	public
	static let ruleNames: [String] = [
		"modl", "modl_structure", "modl_map", "modl_array", "modl_nb_array", "modl_pair", 
		"modl_value_item", "modl_top_level_conditional", "modl_top_level_conditional_return", 
		"modl_map_conditional", "modl_map_conditional_return", "modl_map_item", 
		"modl_array_conditional", "modl_array_conditional_return", "modl_array_item", 
		"modl_value_conditional", "modl_value_conditional_return", "modl_condition_test", 
		"modl_operator", "modl_condition", "modl_condition_group", "modl_value", 
		"modl_array_value_item", "modl_primitive"
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
	func getGrammarFileName() -> String { return "MODLParser.g4" }

	override open
	func getRuleNames() -> [String] { return MODLParser.ruleNames }

	override open
	func getSerializedATN() -> String { return MODLParser._serializedATN }

	override open
	func getATN() -> ATN { return MODLParser._ATN }


	override open
	func getVocabulary() -> Vocabulary {
	    return MODLParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,MODLParser._ATN,MODLParser._decisionToDFA, MODLParser._sharedContextCache)
	}


	public class ModlContext: ParserRuleContext {
			open
			func modl_structure() -> [Modl_structureContext] {
				return getRuleContexts(Modl_structureContext.self)
			}
			open
			func modl_structure(_ i: Int) -> Modl_structureContext? {
				return getRuleContext(Modl_structureContext.self, i)
			}
			open
			func EOF() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EOF.rawValue, 0)
			}
			open
			func STRUCT_SEP() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.STRUCT_SEP.rawValue)
			}
			open
			func STRUCT_SEP(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRUCT_SEP.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl(self)
			}
		}
	}
	@discardableResult
	 open func modl() throws -> ModlContext {
		var _localctx: ModlContext = ModlContext(_ctx, getState())
		try enterRule(_localctx, 0, MODLParser.RULE_modl)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	setState(64)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,3, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(49)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }()) {
		 			setState(48)
		 			try modl_structure()

		 		}



		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(51)
		 		try modl_structure()
		 		setState(56)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(52)
		 				try match(MODLParser.Tokens.STRUCT_SEP.rawValue)
		 				setState(53)
		 				try modl_structure()

		 		 
		 			}
		 			setState(58)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
		 		}

		 		setState(60)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.STRUCT_SEP.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(59)
		 			try match(MODLParser.Tokens.STRUCT_SEP.rawValue)

		 		}

		 		setState(62)
		 		try match(MODLParser.Tokens.EOF.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_structureContext: ParserRuleContext {
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
			open
			func modl_top_level_conditional() -> Modl_top_level_conditionalContext? {
				return getRuleContext(Modl_top_level_conditionalContext.self, 0)
			}
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_structure
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_structure(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_structure(self)
			}
		}
	}
	@discardableResult
	 open func modl_structure() throws -> Modl_structureContext {
		var _localctx: Modl_structureContext = Modl_structureContext(_ctx, getState())
		try enterRule(_localctx, 2, MODLParser.RULE_modl_structure)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(70)
		 	try _errHandler.sync(self)
		 	switch (MODLParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .LBRAC:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(66)
		 		try modl_map()

		 		break

		 	case .LSBRAC:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(67)
		 		try modl_array()

		 		break

		 	case .LCBRAC:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(68)
		 		try modl_top_level_conditional()

		 		break
		 	case .NULL:fallthrough
		 	case .TRUE:fallthrough
		 	case .FALSE:fallthrough
		 	case .NUMBER:fallthrough
		 	case .STRING:fallthrough
		 	case .QUOTED:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(69)
		 		try modl_pair()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_mapContext: ParserRuleContext {
			open
			func LBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LBRAC.rawValue, 0)
			}
			open
			func RBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RBRAC.rawValue, 0)
			}
			open
			func modl_map_item() -> [Modl_map_itemContext] {
				return getRuleContexts(Modl_map_itemContext.self)
			}
			open
			func modl_map_item(_ i: Int) -> Modl_map_itemContext? {
				return getRuleContext(Modl_map_itemContext.self, i)
			}
			open
			func STRUCT_SEP() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.STRUCT_SEP.rawValue)
			}
			open
			func STRUCT_SEP(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRUCT_SEP.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map(self)
			}
		}
	}
	@discardableResult
	 open func modl_map() throws -> Modl_mapContext {
		var _localctx: Modl_mapContext = Modl_mapContext(_ctx, getState())
		try enterRule(_localctx, 4, MODLParser.RULE_modl_map)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(72)
		 	try match(MODLParser.Tokens.LBRAC.rawValue)
		 	setState(81)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(73)
		 		try modl_map_item()
		 		setState(78)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.STRUCT_SEP.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(74)
		 			try match(MODLParser.Tokens.STRUCT_SEP.rawValue)
		 			setState(75)
		 			try modl_map_item()


		 			setState(80)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}

		 	}

		 	setState(83)
		 	try match(MODLParser.Tokens.RBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_arrayContext: ParserRuleContext {
			open
			func LSBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LSBRAC.rawValue, 0)
			}
			open
			func RSBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RSBRAC.rawValue, 0)
			}
			open
			func modl_array_item() -> [Modl_array_itemContext] {
				return getRuleContexts(Modl_array_itemContext.self)
			}
			open
			func modl_array_item(_ i: Int) -> Modl_array_itemContext? {
				return getRuleContext(Modl_array_itemContext.self, i)
			}
			open
			func modl_nb_array() -> [Modl_nb_arrayContext] {
				return getRuleContexts(Modl_nb_arrayContext.self)
			}
			open
			func modl_nb_array(_ i: Int) -> Modl_nb_arrayContext? {
				return getRuleContext(Modl_nb_arrayContext.self, i)
			}
			open
			func STRUCT_SEP() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.STRUCT_SEP.rawValue)
			}
			open
			func STRUCT_SEP(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRUCT_SEP.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array(self)
			}
		}
	}
	@discardableResult
	 open func modl_array() throws -> Modl_arrayContext {
		var _localctx: Modl_arrayContext = Modl_arrayContext(_ctx, getState())
		try enterRule(_localctx, 6, MODLParser.RULE_modl_array)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(85)
		 	try match(MODLParser.Tokens.LSBRAC.rawValue)
		 	setState(110)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(88)
		 		try _errHandler.sync(self)
		 		switch(try getInterpreter().adaptivePredict(_input,7, _ctx)) {
		 		case 1:
		 			setState(86)
		 			try modl_array_item()

		 			break
		 		case 2:
		 			setState(87)
		 			try modl_nb_array()

		 			break
		 		default: break
		 		}
		 		setState(107)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.STRUCT_SEP.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(91) 
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 			repeat {
		 				setState(90)
		 				try match(MODLParser.Tokens.STRUCT_SEP.rawValue)


		 				setState(93); 
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 			} while (//closure
		 			 { () -> Bool in
		 			      let testSet: Bool = _la == MODLParser.Tokens.STRUCT_SEP.rawValue
		 			      return testSet
		 			 }())
		 			setState(97)
		 			try _errHandler.sync(self)
		 			switch(try getInterpreter().adaptivePredict(_input,9, _ctx)) {
		 			case 1:
		 				setState(95)
		 				try modl_array_item()

		 				break
		 			case 2:
		 				setState(96)
		 				try modl_nb_array()

		 				break
		 			default: break
		 			}
		 			setState(102)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,10,_ctx)
		 			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 				if ( _alt==1 ) {
		 					setState(99)
		 					try match(MODLParser.Tokens.STRUCT_SEP.rawValue)

		 			 
		 				}
		 				setState(104)
		 				try _errHandler.sync(self)
		 				_alt = try getInterpreter().adaptivePredict(_input,10,_ctx)
		 			}


		 			setState(109)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}

		 	}

		 	setState(112)
		 	try match(MODLParser.Tokens.RSBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_nb_arrayContext: ParserRuleContext {
			open
			func modl_array_item() -> [Modl_array_itemContext] {
				return getRuleContexts(Modl_array_itemContext.self)
			}
			open
			func modl_array_item(_ i: Int) -> Modl_array_itemContext? {
				return getRuleContext(Modl_array_itemContext.self, i)
			}
			open
			func COLON() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.COLON.rawValue)
			}
			open
			func COLON(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.COLON.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_nb_array
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_nb_array(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_nb_array(self)
			}
		}
	}
	@discardableResult
	 open func modl_nb_array() throws -> Modl_nb_arrayContext {
		var _localctx: Modl_nb_arrayContext = Modl_nb_arrayContext(_ctx, getState())
		try enterRule(_localctx, 8, MODLParser.RULE_modl_nb_array)
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(120); 
		 	try _errHandler.sync(self)
		 	_alt = 1;
		 	repeat {
		 		switch (_alt) {
		 		case 1:
		 			setState(114)
		 			try modl_array_item()
		 			setState(116); 
		 			try _errHandler.sync(self)
		 			_alt = 1;
		 			repeat {
		 				switch (_alt) {
		 				case 1:
		 					setState(115)
		 					try match(MODLParser.Tokens.COLON.rawValue)


		 					break
		 				default:
		 					throw ANTLRException.recognition(e: NoViableAltException(self))
		 				}
		 				setState(118); 
		 				try _errHandler.sync(self)
		 				_alt = try getInterpreter().adaptivePredict(_input,13,_ctx)
		 			} while (_alt != 2 && _alt !=  ATN.INVALID_ALT_NUMBER)


		 			break
		 		default:
		 			throw ANTLRException.recognition(e: NoViableAltException(self))
		 		}
		 		setState(122); 
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,14,_ctx)
		 	} while (_alt != 2 && _alt !=  ATN.INVALID_ALT_NUMBER)
		 	setState(127)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,15,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(124)
		 			try modl_array_item()

		 	 
		 		}
		 		setState(129)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,15,_ctx)
		 	}
		 	setState(131)
		 	try _errHandler.sync(self)
		 	switch (try getInterpreter().adaptivePredict(_input,16,_ctx)) {
		 	case 1:
		 		setState(130)
		 		try match(MODLParser.Tokens.COLON.rawValue)

		 		break
		 	default: break
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_pairContext: ParserRuleContext {
			open
			func EQUALS() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EQUALS.rawValue, 0)
			}
			open
			func modl_value_item() -> Modl_value_itemContext? {
				return getRuleContext(Modl_value_itemContext.self, 0)
			}
			open
			func STRING() -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRING.rawValue, 0)
			}
			open
			func QUOTED() -> TerminalNode? {
				return getToken(MODLParser.Tokens.QUOTED.rawValue, 0)
			}
			open
			func NUMBER() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NUMBER.rawValue, 0)
			}
			open
			func NULL() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NULL.rawValue, 0)
			}
			open
			func TRUE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.TRUE.rawValue, 0)
			}
			open
			func FALSE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.FALSE.rawValue, 0)
			}
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_pair
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_pair(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_pair(self)
			}
		}
	}
	@discardableResult
	 open func modl_pair() throws -> Modl_pairContext {
		var _localctx: Modl_pairContext = Modl_pairContext(_ctx, getState())
		try enterRule(_localctx, 10, MODLParser.RULE_modl_pair)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(140)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,17, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(133)
		 		_la = try _input.LA(1)
		 		if (!(//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }())) {
		 		try _errHandler.recoverInline(self)
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}
		 		setState(134)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)
		 		setState(135)
		 		try modl_value_item()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(136)
		 		try match(MODLParser.Tokens.STRING.rawValue)
		 		setState(137)
		 		try modl_map()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(138)
		 		try match(MODLParser.Tokens.STRING.rawValue)
		 		setState(139)
		 		try modl_array()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_value_itemContext: ParserRuleContext {
			open
			func modl_value() -> Modl_valueContext? {
				return getRuleContext(Modl_valueContext.self, 0)
			}
			open
			func modl_value_conditional() -> Modl_value_conditionalContext? {
				return getRuleContext(Modl_value_conditionalContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_value_item() throws -> Modl_value_itemContext {
		var _localctx: Modl_value_itemContext = Modl_value_itemContext(_ctx, getState())
		try enterRule(_localctx, 12, MODLParser.RULE_modl_value_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(144)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,18, _ctx)) {
		 	case 1:
		 		setState(142)
		 		try modl_value()

		 		break
		 	case 2:
		 		setState(143)
		 		try modl_value_conditional()

		 		break
		 	default: break
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_top_level_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func modl_top_level_conditional_return() -> [Modl_top_level_conditional_returnContext] {
				return getRuleContexts(Modl_top_level_conditional_returnContext.self)
			}
			open
			func modl_top_level_conditional_return(_ i: Int) -> Modl_top_level_conditional_returnContext? {
				return getRuleContext(Modl_top_level_conditional_returnContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_top_level_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_top_level_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_top_level_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_top_level_conditional() throws -> Modl_top_level_conditionalContext {
		var _localctx: Modl_top_level_conditionalContext = Modl_top_level_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 14, MODLParser.RULE_modl_top_level_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(146)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(147)
		 	try modl_condition_test()
		 	setState(148)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(149)
		 	try modl_top_level_conditional_return()
		 	setState(158)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.FSLASH.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(150)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(152)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }()) {
		 			setState(151)
		 			try modl_condition_test()

		 		}

		 		setState(154)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(155)
		 		try modl_top_level_conditional_return()


		 		setState(160)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(161)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_top_level_conditional_returnContext: ParserRuleContext {
			open
			func modl_structure() -> [Modl_structureContext] {
				return getRuleContexts(Modl_structureContext.self)
			}
			open
			func modl_structure(_ i: Int) -> Modl_structureContext? {
				return getRuleContext(Modl_structureContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_top_level_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_top_level_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_top_level_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_top_level_conditional_return() throws -> Modl_top_level_conditional_returnContext {
		var _localctx: Modl_top_level_conditional_returnContext = Modl_top_level_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 16, MODLParser.RULE_modl_top_level_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(166)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(163)
		 		try modl_structure()


		 		setState(168)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_map_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func modl_map_conditional_return() -> [Modl_map_conditional_returnContext] {
				return getRuleContexts(Modl_map_conditional_returnContext.self)
			}
			open
			func modl_map_conditional_return(_ i: Int) -> Modl_map_conditional_returnContext? {
				return getRuleContext(Modl_map_conditional_returnContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_map_conditional() throws -> Modl_map_conditionalContext {
		var _localctx: Modl_map_conditionalContext = Modl_map_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 18, MODLParser.RULE_modl_map_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(169)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(170)
		 	try modl_condition_test()
		 	setState(171)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(172)
		 	try modl_map_conditional_return()
		 	setState(181)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.FSLASH.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(173)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(175)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }()) {
		 			setState(174)
		 			try modl_condition_test()

		 		}

		 		setState(177)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(178)
		 		try modl_map_conditional_return()


		 		setState(183)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(184)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_map_conditional_returnContext: ParserRuleContext {
			open
			func modl_map_item() -> [Modl_map_itemContext] {
				return getRuleContexts(Modl_map_itemContext.self)
			}
			open
			func modl_map_item(_ i: Int) -> Modl_map_itemContext? {
				return getRuleContext(Modl_map_itemContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_map_conditional_return() throws -> Modl_map_conditional_returnContext {
		var _localctx: Modl_map_conditional_returnContext = Modl_map_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 20, MODLParser.RULE_modl_map_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(187) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(186)
		 		try modl_map_item()


		 		setState(189); 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	} while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }())

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_map_itemContext: ParserRuleContext {
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
			open
			func modl_map_conditional() -> Modl_map_conditionalContext? {
				return getRuleContext(Modl_map_conditionalContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_map_item() throws -> Modl_map_itemContext {
		var _localctx: Modl_map_itemContext = Modl_map_itemContext(_ctx, getState())
		try enterRule(_localctx, 22, MODLParser.RULE_modl_map_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(193)
		 	try _errHandler.sync(self)
		 	switch (MODLParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .NULL:fallthrough
		 	case .TRUE:fallthrough
		 	case .FALSE:fallthrough
		 	case .NUMBER:fallthrough
		 	case .STRING:fallthrough
		 	case .QUOTED:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(191)
		 		try modl_pair()

		 		break

		 	case .LCBRAC:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(192)
		 		try modl_map_conditional()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func modl_array_conditional_return() -> [Modl_array_conditional_returnContext] {
				return getRuleContexts(Modl_array_conditional_returnContext.self)
			}
			open
			func modl_array_conditional_return(_ i: Int) -> Modl_array_conditional_returnContext? {
				return getRuleContext(Modl_array_conditional_returnContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_conditional() throws -> Modl_array_conditionalContext {
		var _localctx: Modl_array_conditionalContext = Modl_array_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 24, MODLParser.RULE_modl_array_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(195)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(196)
		 	try modl_condition_test()
		 	setState(197)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(198)
		 	try modl_array_conditional_return()
		 	setState(207)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.FSLASH.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(199)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(201)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }()) {
		 			setState(200)
		 			try modl_condition_test()

		 		}

		 		setState(203)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(204)
		 		try modl_array_conditional_return()


		 		setState(209)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(210)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_conditional_returnContext: ParserRuleContext {
			open
			func modl_array_item() -> [Modl_array_itemContext] {
				return getRuleContexts(Modl_array_itemContext.self)
			}
			open
			func modl_array_item(_ i: Int) -> Modl_array_itemContext? {
				return getRuleContext(Modl_array_itemContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_conditional_return() throws -> Modl_array_conditional_returnContext {
		var _localctx: Modl_array_conditional_returnContext = Modl_array_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 26, MODLParser.RULE_modl_array_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(213) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(212)
		 		try modl_array_item()


		 		setState(215); 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	} while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }())

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_itemContext: ParserRuleContext {
			open
			func modl_array_value_item() -> Modl_array_value_itemContext? {
				return getRuleContext(Modl_array_value_itemContext.self, 0)
			}
			open
			func modl_array_conditional() -> Modl_array_conditionalContext? {
				return getRuleContext(Modl_array_conditionalContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_item() throws -> Modl_array_itemContext {
		var _localctx: Modl_array_itemContext = Modl_array_itemContext(_ctx, getState())
		try enterRule(_localctx, 28, MODLParser.RULE_modl_array_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(219)
		 	try _errHandler.sync(self)
		 	switch (MODLParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .NULL:fallthrough
		 	case .TRUE:fallthrough
		 	case .FALSE:fallthrough
		 	case .LBRAC:fallthrough
		 	case .LSBRAC:fallthrough
		 	case .NUMBER:fallthrough
		 	case .STRING:fallthrough
		 	case .QUOTED:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(217)
		 		try modl_array_value_item()

		 		break

		 	case .LCBRAC:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(218)
		 		try modl_array_conditional()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_value_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func modl_value_conditional_return() -> [Modl_value_conditional_returnContext] {
				return getRuleContexts(Modl_value_conditional_returnContext.self)
			}
			open
			func modl_value_conditional_return(_ i: Int) -> Modl_value_conditional_returnContext? {
				return getRuleContext(Modl_value_conditional_returnContext.self, i)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_value_conditional() throws -> Modl_value_conditionalContext {
		var _localctx: Modl_value_conditionalContext = Modl_value_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 30, MODLParser.RULE_modl_value_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(221)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(222)
		 	try modl_condition_test()
		 	setState(223)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(239)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(224)
		 		try modl_value_conditional_return()
		 		setState(232)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,30,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(225)
		 				try match(MODLParser.Tokens.FSLASH.rawValue)
		 				setState(226)
		 				try modl_condition_test()
		 				setState(227)
		 				try match(MODLParser.Tokens.QMARK.rawValue)
		 				setState(228)
		 				try modl_value_conditional_return()

		 		 
		 			}
		 			setState(234)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,30,_ctx)
		 		}

		 		setState(235)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(236)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(237)
		 		try modl_value_conditional_return()


		 	}

		 	setState(241)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_value_conditional_returnContext: ParserRuleContext {
			open
			func modl_value_item() -> [Modl_value_itemContext] {
				return getRuleContexts(Modl_value_itemContext.self)
			}
			open
			func modl_value_item(_ i: Int) -> Modl_value_itemContext? {
				return getRuleContext(Modl_value_itemContext.self, i)
			}
			open
			func COLON() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.COLON.rawValue)
			}
			open
			func COLON(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.COLON.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_value_conditional_return() throws -> Modl_value_conditional_returnContext {
		var _localctx: Modl_value_conditional_returnContext = Modl_value_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 32, MODLParser.RULE_modl_value_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(243)
		 	try modl_value_item()
		 	setState(248)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.COLON.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(244)
		 		try match(MODLParser.Tokens.COLON.rawValue)
		 		setState(245)
		 		try modl_value_item()


		 		setState(250)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_condition_testContext: ParserRuleContext {
			open
			func modl_condition() -> [Modl_conditionContext] {
				return getRuleContexts(Modl_conditionContext.self)
			}
			open
			func modl_condition(_ i: Int) -> Modl_conditionContext? {
				return getRuleContext(Modl_conditionContext.self, i)
			}
			open
			func modl_condition_group() -> [Modl_condition_groupContext] {
				return getRuleContexts(Modl_condition_groupContext.self)
			}
			open
			func modl_condition_group(_ i: Int) -> Modl_condition_groupContext? {
				return getRuleContext(Modl_condition_groupContext.self, i)
			}
			open
			func EXCLAM() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.EXCLAM.rawValue)
			}
			open
			func EXCLAM(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.EXCLAM.rawValue, i)
			}
			open
			func AMP() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.AMP.rawValue)
			}
			open
			func AMP(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.AMP.rawValue, i)
			}
			open
			func PIPE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.PIPE.rawValue)
			}
			open
			func PIPE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.PIPE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_condition_test
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_condition_test(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_condition_test(self)
			}
		}
	}
	@discardableResult
	 open func modl_condition_test() throws -> Modl_condition_testContext {
		var _localctx: Modl_condition_testContext = Modl_condition_testContext(_ctx, getState())
		try enterRule(_localctx, 34, MODLParser.RULE_modl_condition_test)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(252)
		 	try _errHandler.sync(self)
		 	switch (try getInterpreter().adaptivePredict(_input,33,_ctx)) {
		 	case 1:
		 		setState(251)
		 		try match(MODLParser.Tokens.EXCLAM.rawValue)

		 		break
		 	default: break
		 	}
		 	setState(256)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,34, _ctx)) {
		 	case 1:
		 		setState(254)
		 		try modl_condition()

		 		break
		 	case 2:
		 		setState(255)
		 		try modl_condition_group()

		 		break
		 	default: break
		 	}
		 	setState(268)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,37,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(258)
		 			_la = try _input.LA(1)
		 			if (!(//closure
		 			 { () -> Bool in
		 			      let testSet: Bool = _la == MODLParser.Tokens.AMP.rawValue || _la == MODLParser.Tokens.PIPE.rawValue
		 			      return testSet
		 			 }())) {
		 			try _errHandler.recoverInline(self)
		 			}
		 			else {
		 				_errHandler.reportMatch(self)
		 				try consume()
		 			}
		 			setState(260)
		 			try _errHandler.sync(self)
		 			switch (try getInterpreter().adaptivePredict(_input,35,_ctx)) {
		 			case 1:
		 				setState(259)
		 				try match(MODLParser.Tokens.EXCLAM.rawValue)

		 				break
		 			default: break
		 			}
		 			setState(264)
		 			try _errHandler.sync(self)
		 			switch(try getInterpreter().adaptivePredict(_input,36, _ctx)) {
		 			case 1:
		 				setState(262)
		 				try modl_condition()

		 				break
		 			case 2:
		 				setState(263)
		 				try modl_condition_group()

		 				break
		 			default: break
		 			}

		 	 
		 		}
		 		setState(270)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,37,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_operatorContext: ParserRuleContext {
			open
			func EQUALS() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EQUALS.rawValue, 0)
			}
			open
			func GTHAN() -> TerminalNode? {
				return getToken(MODLParser.Tokens.GTHAN.rawValue, 0)
			}
			open
			func LTHAN() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LTHAN.rawValue, 0)
			}
			open
			func EXCLAM() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EXCLAM.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_operator
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_operator(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_operator(self)
			}
		}
	}
	@discardableResult
	 open func modl_operator() throws -> Modl_operatorContext {
		var _localctx: Modl_operatorContext = Modl_operatorContext(_ctx, getState())
		try enterRule(_localctx, 36, MODLParser.RULE_modl_operator)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(280)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,38, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(271)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(272)
		 		try match(MODLParser.Tokens.GTHAN.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(273)
		 		try match(MODLParser.Tokens.GTHAN.rawValue)
		 		setState(274)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(275)
		 		try match(MODLParser.Tokens.LTHAN.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(276)
		 		try match(MODLParser.Tokens.LTHAN.rawValue)
		 		setState(277)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(278)
		 		try match(MODLParser.Tokens.EXCLAM.rawValue)
		 		setState(279)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_conditionContext: ParserRuleContext {
			open
			func modl_value() -> [Modl_valueContext] {
				return getRuleContexts(Modl_valueContext.self)
			}
			open
			func modl_value(_ i: Int) -> Modl_valueContext? {
				return getRuleContext(Modl_valueContext.self, i)
			}
			open
			func STRING() -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRING.rawValue, 0)
			}
			open
			func modl_operator() -> Modl_operatorContext? {
				return getRuleContext(Modl_operatorContext.self, 0)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_condition
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_condition(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_condition(self)
			}
		}
	}
	@discardableResult
	 open func modl_condition() throws -> Modl_conditionContext {
		var _localctx: Modl_conditionContext = Modl_conditionContext(_ctx, getState())
		try enterRule(_localctx, 38, MODLParser.RULE_modl_condition)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(283)
		 	try _errHandler.sync(self)
		 	switch (try getInterpreter().adaptivePredict(_input,39,_ctx)) {
		 	case 1:
		 		setState(282)
		 		try match(MODLParser.Tokens.STRING.rawValue)

		 		break
		 	default: break
		 	}
		 	setState(286)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(285)
		 		try modl_operator()

		 	}

		 	setState(288)
		 	try modl_value()
		 	setState(293)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.FSLASH.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(289)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(290)
		 		try modl_value()


		 		setState(295)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_condition_groupContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func AMP() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.AMP.rawValue)
			}
			open
			func AMP(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.AMP.rawValue, i)
			}
			open
			func PIPE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.PIPE.rawValue)
			}
			open
			func PIPE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.PIPE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_condition_group
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_condition_group(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_condition_group(self)
			}
		}
	}
	@discardableResult
	 open func modl_condition_group() throws -> Modl_condition_groupContext {
		var _localctx: Modl_condition_groupContext = Modl_condition_groupContext(_ctx, getState())
		try enterRule(_localctx, 40, MODLParser.RULE_modl_condition_group)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(296)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(297)
		 	try modl_condition_test()
		 	setState(302)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.AMP.rawValue || _la == MODLParser.Tokens.PIPE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(298)
		 		_la = try _input.LA(1)
		 		if (!(//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.AMP.rawValue || _la == MODLParser.Tokens.PIPE.rawValue
		 		      return testSet
		 		 }())) {
		 		try _errHandler.recoverInline(self)
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}
		 		setState(299)
		 		try modl_condition_test()


		 		setState(304)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(305)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_valueContext: ParserRuleContext {
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
			open
			func modl_nb_array() -> Modl_nb_arrayContext? {
				return getRuleContext(Modl_nb_arrayContext.self, 0)
			}
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
			open
			func modl_primitive() -> Modl_primitiveContext? {
				return getRuleContext(Modl_primitiveContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value(self)
			}
		}
	}
	@discardableResult
	 open func modl_value() throws -> Modl_valueContext {
		var _localctx: Modl_valueContext = Modl_valueContext(_ctx, getState())
		try enterRule(_localctx, 42, MODLParser.RULE_modl_value)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(312)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,43, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(307)
		 		try modl_map()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(308)
		 		try modl_array()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(309)
		 		try modl_nb_array()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(310)
		 		try modl_pair()

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(311)
		 		try modl_primitive()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_value_itemContext: ParserRuleContext {
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
			open
			func modl_primitive() -> Modl_primitiveContext? {
				return getRuleContext(Modl_primitiveContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_value_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_value_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_value_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_value_item() throws -> Modl_array_value_itemContext {
		var _localctx: Modl_array_value_itemContext = Modl_array_value_itemContext(_ctx, getState())
		try enterRule(_localctx, 44, MODLParser.RULE_modl_array_value_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(318)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,44, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(314)
		 		try modl_map()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(315)
		 		try modl_pair()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(316)
		 		try modl_array()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(317)
		 		try modl_primitive()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_primitiveContext: ParserRuleContext {
			open
			func QUOTED() -> TerminalNode? {
				return getToken(MODLParser.Tokens.QUOTED.rawValue, 0)
			}
			open
			func NUMBER() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NUMBER.rawValue, 0)
			}
			open
			func STRING() -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRING.rawValue, 0)
			}
			open
			func TRUE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.TRUE.rawValue, 0)
			}
			open
			func FALSE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.FALSE.rawValue, 0)
			}
			open
			func NULL() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NULL.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_primitive
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_primitive(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_primitive(self)
			}
		}
	}
	@discardableResult
	 open func modl_primitive() throws -> Modl_primitiveContext {
		var _localctx: Modl_primitiveContext = Modl_primitiveContext(_ctx, getState())
		try enterRule(_localctx, 46, MODLParser.RULE_modl_primitive)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(320)
		 	_la = try _input.LA(1)
		 	if (!(//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }())) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}


	public
	static let _serializedATN = MODLParserATN().jsonString

	public
	static let _ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}