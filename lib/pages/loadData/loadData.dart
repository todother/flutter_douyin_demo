import 'package:flutter/material.dart';

class LoadDataDemo extends StatelessWidget {
  const LoadDataDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("获取数据"),
          centerTitle: true,
        ),
        body: RefreshPage());
  }
}

class RefreshPage extends StatefulWidget {
  RefreshPage({Key key}) : super(key: key);

  @override
  _RefreshPageState createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  List<String> data = List<String>();
  ScrollController controller;
  bool ifLoading = false;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    List.generate(30, (i) => data.add("item ${i + 1}"));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            data=List<String>();
            List.generate(30, (i) => data.add("item ${i + 1}"));
            setState(() {
              data = data;
            });
          });
        },
        child: NotificationListener<ScrollNotification>(
            onNotification: (scroll) {
              if (!ifLoading &&
                  scroll.metrics.maxScrollExtent <= controller.offset + 200) {
                
                setState(() {
                  ifLoading = true;
                });
                List.generate(30, (i) {
                  data.add("item ${data.length + 1}");
                });
                // setState(() {
                //   data = data;
                //   ifLoading = false;
                // });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    data = data;
                    ifLoading = false;
                  });
                });
              }
              // return;
            },
            child: ListView.builder(
              controller: controller,
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  child: Text(data[index]),
                );
              },
            )),
      ),
      ifLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container()
    ]);
  }
}
