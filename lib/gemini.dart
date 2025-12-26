import 'package:google_generative_ai/google_generative_ai.dart';

class Gemini {
  static const apikey = "";
  static final model = GenerativeModel (
    apiKey: apikey, 
    model: "gemini-2.5-flash-lite",
    systemInstruction: Content.system(
      "You are an expert organizer. I will give you a list of existing categories and a thought. "
      "1. Look at the existing categories: if the thought fits perfectly, reply with that category name. "
      "2. If it does NOT fit perfectly, you MUST create a new, specific category name (1-2 words). "
      "3. Avoid using the word 'General' unless absolutely necessary. "
      "4. Reply ONLY with the category name, no punctuation."),
  );

  static Future<String> group(List<String> groups, String thoughtContent) async {
  try {
    final String groupString = groups.isEmpty ? "None yet" : groups.join(", ");
    
    final prompt = [
      Content.text(
        "I have these existing categories: $groupString. "
        "I just thought of this: '$thoughtContent'. "
        "Which category does it belong to? "
        "If it doesn't fit, give me a NEW short category name. "
        "Respond ONLY with the category name."
      )
    ];

    final response = await model.generateContent(prompt);
    
    //print("AI raw response: ${response.text}");

    if (response.text != null && response.text!.trim().isNotEmpty) {
      return response.text!.trim();
    } 
    else {
      //print("AI returned empty text");
      return "General";
    }
  } 
  catch (e) {
    //print("Caught an actual error: $e");
    return "General";
  }
}
  
}