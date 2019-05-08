// Generated from MODLParser.g4 by ANTLR 4.7.2

import Antlr4


/**
 * This class provides an empty implementation of {@link MODLParserListener},
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
open class MODLParserBaseListener: MODLParserListener {
     public init() { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl(_ ctx: MODLParser.ModlContext) { print("HIT enter")}
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl(_ ctx: MODLParser.ModlContext) { print("HIT exit") }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_structure(_ ctx: MODLParser.Modl_structureContext) { print("HIT enter structure") }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_structure(_ ctx: MODLParser.Modl_structureContext) {print("HIT exit structure") }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_map(_ ctx: MODLParser.Modl_mapContext) {print("HIT enter map") }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_map(_ ctx: MODLParser.Modl_mapContext) {print("HIT exit map") }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_array(_ ctx: MODLParser.Modl_arrayContext) {print("HIT enter array") }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_array(_ ctx: MODLParser.Modl_arrayContext) {print("HIT exit array") }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_nb_array(_ ctx: MODLParser.Modl_nb_arrayContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_nb_array(_ ctx: MODLParser.Modl_nb_arrayContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_pair(_ ctx: MODLParser.Modl_pairContext) {print("HIT enter pair") }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_pair(_ ctx: MODLParser.Modl_pairContext) { print("HIT exit pair")}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_value_item(_ ctx: MODLParser.Modl_value_itemContext) {print("HIT enter value item") }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_value_item(_ ctx: MODLParser.Modl_value_itemContext) { print("HIT exit value item")}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_top_level_conditional(_ ctx: MODLParser.Modl_top_level_conditionalContext) {print("HIT enter toplevelconditional") }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_top_level_conditional(_ ctx: MODLParser.Modl_top_level_conditionalContext) { print("HIT exit toplevelconditional")}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_top_level_conditional_return(_ ctx: MODLParser.Modl_top_level_conditional_returnContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_top_level_conditional_return(_ ctx: MODLParser.Modl_top_level_conditional_returnContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_map_conditional(_ ctx: MODLParser.Modl_map_conditionalContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_map_conditional(_ ctx: MODLParser.Modl_map_conditionalContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_map_conditional_return(_ ctx: MODLParser.Modl_map_conditional_returnContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_map_conditional_return(_ ctx: MODLParser.Modl_map_conditional_returnContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_map_item(_ ctx: MODLParser.Modl_map_itemContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_map_item(_ ctx: MODLParser.Modl_map_itemContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_array_conditional(_ ctx: MODLParser.Modl_array_conditionalContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_array_conditional(_ ctx: MODLParser.Modl_array_conditionalContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_array_conditional_return(_ ctx: MODLParser.Modl_array_conditional_returnContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_array_conditional_return(_ ctx: MODLParser.Modl_array_conditional_returnContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_array_item(_ ctx: MODLParser.Modl_array_itemContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_array_item(_ ctx: MODLParser.Modl_array_itemContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_value_conditional(_ ctx: MODLParser.Modl_value_conditionalContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_value_conditional(_ ctx: MODLParser.Modl_value_conditionalContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_value_conditional_return(_ ctx: MODLParser.Modl_value_conditional_returnContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_value_conditional_return(_ ctx: MODLParser.Modl_value_conditional_returnContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_condition_test(_ ctx: MODLParser.Modl_condition_testContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_condition_test(_ ctx: MODLParser.Modl_condition_testContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_operator(_ ctx: MODLParser.Modl_operatorContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_operator(_ ctx: MODLParser.Modl_operatorContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_condition(_ ctx: MODLParser.Modl_conditionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_condition(_ ctx: MODLParser.Modl_conditionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_condition_group(_ ctx: MODLParser.Modl_condition_groupContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_condition_group(_ ctx: MODLParser.Modl_condition_groupContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_value(_ ctx: MODLParser.Modl_valueContext) {print("HIT enter value") }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_value(_ ctx: MODLParser.Modl_valueContext) {print("HIT exit value") }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterModl_array_value_item(_ ctx: MODLParser.Modl_array_value_itemContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitModl_array_value_item(_ ctx: MODLParser.Modl_array_value_itemContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterEveryRule(_ ctx: ParserRuleContext) { print("HIT enter every rule")}
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitEveryRule(_ ctx: ParserRuleContext) { print("HIT exit every rule")}
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitTerminal(_ node: TerminalNode) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitErrorNode(_ node: ErrorNode) { }
}
