class Request{
  String expression;

  Request({required this.expression});
}

class Response{
  double answer;

  Response({this.answer = 0});
}

class Logic{
  static String _postfix(String exp){
    List<String> stack = [];

    String post = '';
    String topval = '';
    int start = 0;

    for (int i = 0; i < exp.length; i++) {
      if (RegExp(r'[-+*/()]').hasMatch(exp[i])) {
        post = '$post${exp.substring(start, i)},';
        start = i + 1;

        if (stack.isNotEmpty) {
          topval = stack[stack.length - 1];
        }

        if (exp[i] == '(') {
          stack.add(exp[i]);
        } else if (exp[i] == ')') {
          while (topval != '(') {
            topval = stack.removeLast();
            post = post + topval;
          }
          stack.removeLast();
        } else if (exp[i] == '+' || exp[i] == '-') {
          if (topval == '*' || topval == '/') {
            while (stack.isNotEmpty && topval != '(') {
              topval = stack.removeLast();
              post = post + topval;
            }
          } else {
            if (topval == '+' || topval == '-') {
              topval = stack.removeLast();
              post = post + topval;
            }
            
          }
          stack.add(exp[i]);
        } else if (exp[i] == '*' && topval == '/') {
          while (stack.isNotEmpty && topval != '(') {
            topval = stack.removeLast();
            post = post + topval;
          }
        } else {
          stack.add(exp[i]);
        }
      }
    }

    post = '$post${exp.substring(start)},';
    if (stack.isNotEmpty) post = post + stack.removeLast();
    return post;
  }

  static Response evaluate(Request req){
    String exp = _postfix(req.expression);
    List<double> stack = [];
    int start = 0;
    double val = 0;

    for(int i = 0; i < exp.length; i++){
      if(RegExp(r'[-+*/]').hasMatch(exp[i])){
        start = i + 1;
        double op2 = stack.removeLast();

        val = stack.removeLast();
        

        switch(exp[i]){
          case '+':
            val = val + op2;
            break;

          case '-':
            val = val - op2;
            break;

          case '*':
            val = val * op2;
            break;

          case '/':
            val = val / op2;
            break;

          default:
            break;
        }

        stack.add(val);
        
      }
      else if(exp[i] == ','){
        stack.add(double.parse(exp.substring(start, i)));
        start = i + 1;
      }
    }
    
    return Response(answer: val);
  }
}
