import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylast2gproject/src/features/ScanningHome/presentation/widgets/diseases_details.dart';
import '../controllers/scan_controller.dart';

class ScanPage extends StatelessWidget {
  final ScanController controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text(
          'Corn Detection',
          style: GoogleFonts.aclonica(),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.loading
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 300,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                        child: const Center(child: Text('Image Appears here')),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 280,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.file(controller.image!),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (controller.diagnosisList.isNotEmpty)
                              Text(
                                controller.diagnosisList.last['disease'],
                                style: GoogleFonts.robotoCondensed(
                                  fontSize: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: controller.loadImageCamera,
                    child: const Text('Capture Image'),
                    color: const Color(0xff01AEBC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: controller.loadImageGallery,
                    child: const Text('Pick Image from Gallery'),
                    color: const Color(0xff01AEBC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.diagnosisList.length,
                  itemBuilder: (context, index) {
                    final Key itemKey = UniqueKey();
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DiagnosisDetailsPage(
                              image: controller.diagnosisList[index]['image'],
                              disease: controller.diagnosisList[index]['disease'],
                            ));
                      },
                      child: ListTile(
                        key: itemKey,
                        leading: Image.file(
                          controller.diagnosisList[index]['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          controller.diagnosisList[index]['disease'],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.removeDiagnosis(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
