import 'package:ai_text_to_image/feature/prompt/bloc/prompt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Images 🚀"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PromptGeneratingImageLoadState:
              return const Center(child: CircularProgressIndicator());

            case PromptGeneratingImageErrorState:
              return const Center(
                child: Text("Something went wrong 😔",
                    style: TextStyle(fontSize: 18, color: Colors.red)),
              );

            case PromptGeneratingImageSuccessState:
              final successState = state as PromptGeneratingImageSuccessState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🎨 Hộp chứa ảnh với khung đẹp
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(successState.uint8list),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 📝 Ô nhập văn bản và nút tạo ảnh
                  Container(
                    height: 240,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter your text",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),

                        // 📌 TextField nhập prompt
                        TextField(
                          controller: controller,
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                            hintText: "Type your text here...",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // 🎨 Nút Generate đẹp
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                promptBloc.add(
                                    PromptEnteredEvent(prompt: controller.text));
                              }
                            },
                            icon: const Icon(Icons.image),
                            label: const Text("Generate Image"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
