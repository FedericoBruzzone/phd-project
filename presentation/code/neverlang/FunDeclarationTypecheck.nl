module FunDeclaration {
    imports {
        java.util.concurrent.atomic.AtomicInteger;
    }
    reference syntax {
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
            try {
                eval $1
                define scope function $1 from #3 to #4 [ run $2 $3 priority function ]
            }
        }.

        4 @{
            define unresolved $5 position $5.pos
        }.

        7 @{
            define unresolved $8 position $8.pos
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
