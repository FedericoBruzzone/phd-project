module FunDeclaration {
    imports {
        java.util.concurrent.atomic.AtomicInteger;
    }
    reference syntax {
       // $0              #0         $1         #1  $2      #2  #3  $3             #4
       FunDeclaration <-- "function" Identifier "(" FunArgs ")" "{" BlockStatement "}";
       FunArgs <-- Identifier "," FunArgs;
       FunArgs <-- Identifier;
       FunArgs <-- "";

       categories:
            keyword = { "function" },
            brackets = { "{", "}" };

    }

    role(type-checker) <typecheck> {
        0 .{
            var helper = $$CompilationHelper;
            var unit = $$CompilationUnit;

            try {
                eval $1
                // We are creating a new TypeFunction that is a class
                // that extends Type and represent a function
                var type = new TypeFunction();

                //SymbolTableEntryFactory is a factory to create a SymbolTableEntry
                var functionScope = new SymbolTableEntryFactory()
                    .withCompilationHelper(helper)
                    .withCompilationUnit(unit)
                    .withToken($1.token)
                    .withEntryType(type0)
                    // The folding range is enclose between braces "{" "}"
                    .withFoldingRange(Range.foldingRangeFrom($n,3,4))
                    .withEntryKind(EntryKind.DEFINE)
                    //At the end we bind the symbol created to the current scope
                    .bindScopeOrReuse();

                helper.getTaskBuilder()
                    .withContext($ctx)
                    .insideScope(functionScope)
                    .withPriority(Priorities.FUNCTION)
                    .withAstNodes($3)
                    // We create and register a task for node $3
                    .createAndRegisterTask();

                // We execute node $2
                unit.enterScope(functionScope);
                eval $2
                unit.exitScope();
            } catch (NeverlangTypesystemException e) {
                e.submit(helper);
            }
        }.
    }

    role(before-each) {
        0 .{
            AtomicInteger counter = new AtomicInteger(0);
            $ctx.nt(2).streamSymbolList("FunArgs", "Identifier").forEachOrdered(e ->
              e.setValue("pos", counter.getAndIncrement())
            );
        }.
    }

}
