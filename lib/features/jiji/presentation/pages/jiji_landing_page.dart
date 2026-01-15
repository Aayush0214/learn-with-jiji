import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiji/core/constant_images/constant_images.dart';
import 'package:jiji/features/jiji/presentation/bloc/jiji_bloc.dart';
import 'package:jiji/features/jiji/presentation/widgets/jiji_loading_shimmer.dart';

import '../widgets/resource_card.dart';

class JijiLandingPage extends StatefulWidget {
  const JijiLandingPage({super.key});

  @override
  State<JijiLandingPage> createState() => _JijiLandingPageState();
}

class _JijiLandingPageState extends State<JijiLandingPage> {
  late TextEditingController _queryController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<JijiBloc, JijiState>(
        listener: (context, state) {
          if (state is JijiErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage, style: TextStyle(color: Colors.white)),
                showCloseIcon: true,
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              )
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Jiji",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Your AI Friend",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10.h),

                // Avatar Image
                Center(
                  child: Image.asset(
                    ConstantImages.jijiImages,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.55,
                  ),
                ),

                // Search/Input Box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                        color: Colors.black.withValues(alpha: 0.1),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextFormField(
                          controller: _queryController,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                          onFieldSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "What is in your mind?",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            contentPadding: EdgeInsets.symmetric(vertical: 12.h)
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<JijiBloc>().add(SendQueryEvent(query :_queryController.text));
                          _queryController.clear();
                        },
                        icon: const Icon(Icons.send,color: Colors.teal),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                // Response Section
                BlocBuilder<JijiBloc, JijiState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is JijiLoadingState) {
                      /// show CircularProgressIndicator or Shimmer Effect
                      return const JijiLoadingShimmer();
                    }

                    if (state is JijiLoadedState){
                      if(state.response.isEmpty) return Text('');
                      return Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Jiji says",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  state.response,
                                  style: const TextStyle(
                                    height: 1.4,
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Resource Cards
                                buildResourceCard(
                                  icon: Icons.slideshow,
                                  title: "Presentation on RAG",
                                  subtitle: "PowerPoint Presentation",
                                  buttonText: "Open",
                                  onButtonTap: () {},
                                ),
                                SizedBox(height: 15.h),
                                buildResourceCard(
                                  icon: Icons.ondemand_video,
                                  title: "What is RAG? Retrieval-Augmented...",
                                  subtitle: "YouTube Video",
                                  buttonText: "Watch",
                                  onButtonTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
