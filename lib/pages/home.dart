import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kwallpapers/utils/ads.dart';
import 'image_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference _wallpapers =
      FirebaseFirestore.instance.collection("wallpapers");
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: MyAds.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print("Failed to Load Banner ad Ad${error.message}");
          _isBannerAdReady = false;
          ad.dispose();
        }),
        request: const AdRequest())
      ..load();

    InterstitialAd.load(
        adUnitId: MyAds.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        }, onAdFailedToLoad: (error) {
          print("Failed to load interstial ad Ad${error.message}");
        }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade300,
        appBar: AppBar(
          title: const Text(
            "Korean Wallpapers",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: _wallpapers.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: snapshot.data.size,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GridTile(
                        child: GestureDetector(
                          onTap: () {
                            _interstitialAd.show();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ImageView(
                                            imgUrl: documentSnapshot["url"])));
                          },
                          // child: Hero(
                          //     tag: documentSnapshot['url'],
                          //     child: Container(
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(8.0),
                          //         child: CachedNetworkImage(
                          //           imageUrl: documentSnapshot['url'],
                          //           height: 300,
                          //           width: 150,
                          //           fit: BoxFit.cover,
                          //         ),
                          //       ),
                          //     )),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: documentSnapshot["url"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Connecting to Internet"),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: _isBannerAdReady
            ? Container(
                height: _bannerAd.size.height.toDouble(),
                width: _bannerAd.size.width.toDouble(),
                child: AdWidget(
                  ad: _bannerAd,
                ),
              )
            : const SizedBox());
  }
}
