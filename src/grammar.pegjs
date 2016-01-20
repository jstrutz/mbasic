{
  function ExecutionContext() {
    this.indirectMode = false;
  }

  function Line(number, statements) {
    this.number = number;
    this.statements = statements;
  }

  function RemarkStatement(comment) {
    this.comment = comment;
  }

  function PrintStatement(printList) {
    this.printList = printList;
  }
}

start
  = DirectMode { var ctx = new ExecutionContext(); }

DirectMode
  = statements:DirectStatement+

DirectStatement
  = Statement CR

CR = '\r'
LF = '\n'

Statement = Expression

Expression
  = Integer

Integer
  = DecimalInteger

DecimalInteger = digits:[0-9]+ { return parseInt(digits.join('')); }

// Statements = statements:(Statement ws* ':')* ws* statement:Statement { return statements.concat([statement]);}
//
// Statement = Remark
//           / Print
//
// Remark = 'REM' ws+ comment:[^\n]* { return new RemarkStatement(comment); }
// Print  = 'PRINT' ws+ printlist:PrintList { return new PrintStatement(printlist); }
//
// PrintList = exprs:(Expression ';')* expr:Expression { return exprs.concat([expr]); }
//
// Expression = Constant
//
// Constant = Integer
//          / String
//
// String = '"' content:StringContent '"' { return new String(content.join('')); }
// StringContent = [a-zA-Z0-9]*

// {String Chars} = {Printable} - ["]
// {WS}           = {Whitespace} - {CR} - {LF}
//
// NewLine        = {CR}{LF}|{CR}
// Whitespace     = {WS}+
//
// Remark         = REM{Space}{Printable}*
// ID             = {Letter}[$%]?
// String         = '"'{String Chars}*'"'
// Integer        = {digit}+
// Real           = {digit}+.{digit}+
//
// <Lines>       ::= Integer <Statements> NewLine <Lines>
//                 | Integer <Statements> NewLine
//
// <Statements>  ::= <Statement> ':' <Statements>
//                 | <Statement>
//
// <Statement>   ::= CLOSE '#' Integer
//                 | DATA <Constant List>
//                 | DIM ID '(' <Integer List> ')'
//                 | END
//                 | FOR ID '=' <Expression> TO <Expression>
//                 | FOR ID '=' <Expression> TO <Expression> STEP Integer
//                 | GOTO <Expression>
//                 | GOSUB <Expression>
//                 | IF <Expression> THEN <Statement>
//                 | INPUT <ID List>
//                 | INPUT '#' Integer ',' <ID List>
//                 | LET Id '=' <Expression>
//                 | NEXT <ID List>
//                 | OPEN <Value> FOR <Access> AS '#' Integer
//                 | POKE <Value List>
//                 | PRINT <Print list>
//                 | PRINT '#' Integer ',' <Print List>
//                 | READ <ID List>
//                 | RETURN
//                 | RESTORE
//                 | RUN
//                 | STOP
//                 | SYS <Value>
//                 | WAIT <Value List>
//                 | Remark
//
// <Access>   ::= INPUT
//              | OUPUT
//
// <ID List>  ::= ID ',' <ID List>
//              | ID
//
// <Value List>      ::= <Value> ',' <Value List>
//                     | <Value>
//
// <Constant List>   ::= <Constant> ',' <Constant List>
//                     | <Constant>
//
// <Integer List>    ::= Integer ',' <Integer List>
//                     | Integer
//
// <Expression List> ::= <Expression> ',' <Expression List>
//                     | <Expression>
//
// <Print List>      ::= <Expression> ';' <Print List>
//                     | <Expression>
//                     |
//
// <Expression>  ::= <And Exp> OR <Expression>
//                 | <And Exp>
//
// <And Exp>     ::= <Not Exp> AND <And Exp>
//                 | <Not Exp>
//
// <Not Exp>     ::= NOT <Compare Exp>
//                 | <Compare Exp>
//
// <Compare Exp> ::= <Add Exp> '='  <Compare Exp>
//                 | <Add Exp> '<>' <Compare Exp>
//                 | <Add Exp> '><' <Compare Exp>
//                 | <Add Exp> '>'  <Compare Exp>
//                 | <Add Exp> '>=' <Compare Exp>
//                 | <Add Exp> '<'  <Compare Exp>
//                 | <Add Exp> '<=' <Compare Exp>
//                 | <Add Exp>
//
// <Add Exp>     ::= <Mult Exp> '+' <Add Exp>
//                 | <Mult Exp> '-' <Add Exp>
//                 | <Mult Exp>
//
// <Mult Exp>    ::= <Negate Exp> '*' <Mult Exp>
//                 | <Negate Exp> '/' <Mult Exp>
//                 | <Negate Exp>
//
// <Negate Exp>  ::= '-' <Power Exp>
//                 | <Power Exp>
//
// <Power Exp>   ::= <Power Exp> '^' <Value>
//                 | <Value>
//
// <Value>       ::= '(' <Expression> ')'
//                 | ID
//                 | ID '(' <Expression List> ')'
//                 | <Constant>
//
// <Constant> ::= Integer
//              | String
//              | Real
