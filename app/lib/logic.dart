class Request{
  String expression;

  Request({required this.expression});
}

class Response{
  double answer;

  Response({this.answer = 0});
}

class Logic{
  String _postfix(String exp){
    List<String> stack = [''];
    int top = -1;

    String post = '';
    int start = 0;

    for(int i = 0; i < exp.length; i++){
      if(RegExp(r'[-+*/()]').hasMatch(exp[i])){
        post = '$post${exp.substring(start, i - 1)},';

        if(stack.isEmpty){
          top++;
          stack[top] = exp[i];
        }
        else{
          if(exp[i] == '+'){
            
          }
        }
      }
      else{
        stack.add(exp[i]);
        top++;
      }
    }

    return '';
  }

  static Response evaluate(Request req){
    String x = req.expression;

    
    return Response(answer: 10);
  }
}

void main() {
  
}