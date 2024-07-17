module Backup {
  reference syntax {@\label{rb:refsyntax}@
    Backup: @\tikz[na]\coordinate(d00);@Backup@\tikz[na]\coordinate(d01);@ <-- "backup" @\tikz[na]\coordinate(d10);@String@\tikz[na]\coordinate(d11);@  @\tikz[na]\coordinate(d20);@String@\tikz[na]\coordinate(d21);@; @\label{r:syntax}@
    Cmd: Cmd    <-- Backup;
    categories  : Keyword = { "backup" };@\label{r:idecat}@
  @\tikz[na]\coordinate(e0);@}@\label{re:refsyntax}@
  @\tikz[na]\coordinate(b1);@role(execution) {
    @\tikz[na]\coordinate(s0);@0 .{@\label{rb:action}@
        String src  = $@\tikz[na]\coordinate(s1);@1.string, dest = $@\tikz[na]\coordinate(s2);@2.string;@\label{re:attribute}@
        $$FileOp.backup(src, dest);
    }. @\label{re:action}@
  }
}
slice BackupSlice {@\label{rb:slice}@
  concrete syntax from Backup @\label{r:concsyntax}@
  module Backup with role execution @\label{rb:semantics}@
  module BackupPermCheck with role permissions @\label{re:semantics}@
}@\label{re:slice}@
language LogLang {@\label{rb:lang}@
  slices BackupSlice RemoveSlice RenameSlice  @\label{rb:slices}@
         MergeSlice Task Main LogLangTypes @\label{re:slices}@
  endemic slices FileOpEndemic PermEndemic @\label{r:endemic}@
  roles
    syntax < terminal-evaluation < permissions : execution @\label{r:roles}@
}@\label{re:lang}@

