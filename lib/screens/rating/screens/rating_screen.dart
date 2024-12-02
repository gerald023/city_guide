import 'package:city_guide/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _currentStep = 0;
  int _rating = 0;

  List<Step> stepList() => [
        Step(
          title: const Text('Rate'),
          isActive: _currentStep >= 1,
          state: _currentStep == 1 ? StepState.editing : StepState.complete,
          content: Column(
            children: [
              const Text(
                'Rate your experience',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 36,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              Text(
                'You selected $_rating star${_rating != 1 ? 's' : ''}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
        Step(
          title: const Text('Message'),
          isActive: _currentStep >= 0,
          state: _currentStep <= 0 ? StepState.editing : StepState.complete,
          content:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text('Leave a review.'),
              const SizedBox(height: 16),
             Padding(
              padding:const EdgeInsets.all(16),
              child: Form(
              child: TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                labelText: 'Enter your text',
                hintText: 'Type something here...',
                ),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'please enter your review.';
                  }
                  return null;
                },
              ),
             ),
            )
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave a review',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Get.back();
          },
        ),
      ),
      body:  Stepper(
      steps: stepList(),
      type: StepperType.horizontal,
      elevation: 0,
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep < (stepList().length - 1)) {
          setState(() {
            _currentStep += 1;
          });
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) {
          setState(() {
            _currentStep -= 1;
          });
        }
      },
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: CustomButton(
                  onPressed: (){
                    details.onStepCancel!();
                  },
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: const Color.fromARGB(76, 158, 158, 158),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  // ),
                  buttonText: 'back',
                  backgroundColor: const Color.fromARGB(59, 158, 158, 158),
                 
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                onPressed: (){
                  details.onStepContinue!();
                },
               buttonText: 'Next',
              ),
            ),
          ],
        );
      },
    ),
    );
  }
}
