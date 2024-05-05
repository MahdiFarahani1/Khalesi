import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/gen/assets.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Features/Audio/presentation/bloc/audio/audio_cubit.dart';
import 'package:khalesi/Features/Audio/repository/foramt_duration.dart';

class AudioClick extends StatefulWidget {
  final String title;
  final String urlAudio;
  const AudioClick({super.key, required this.title, required this.urlAudio});

  @override
  State<AudioClick> createState() => _AudioClickState();
}

class _AudioClickState extends State<AudioClick> {
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    BlocProvider.of<AudioCubit>(context).initState(audioPlayer);
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.blueAccent,
              Colors.white,
            ],
          )),
          width: EsaySize.width(context),
          height: EsaySize.height(context),
          child: BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Assets.images.logo.image(),
                  ),
                  EsaySize.safeGap(EsaySize.height(context)),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        color: ConstColor.blue,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: ConstColor.yellow,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbColor: ConstColor.yellow,
                        trackHeight: 3,
                        activeTrackColor: ConstColor.yellow,
                        inactiveTrackColor: Colors.blue.shade300,
                      ),
                      child: Slider(
                        min: 0,
                        max: state.duration.inSeconds.toDouble(),
                        value: state.position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final pos = Duration(seconds: value.toInt());
                          await audioPlayer.seek(pos);
                          await audioPlayer.resume();

                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 8),
                        child: Text(
                          FormatDuration.formatDuration(state.position),
                          style:
                              TextStyle(color: ConstColor.yellow, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 8),
                        child: Text(
                          FormatDuration.formatDuration(
                              state.duration - state.position),
                          style:
                              TextStyle(color: ConstColor.yellow, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  InkResponse(
                    onTap: () async {
                      await BlocProvider.of<AudioCubit>(context)
                          .changeIcon(audioPlayer, widget.urlAudio);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: ConstColor.blue,
                      child: Icon(
                        state.icon,
                        size: 40,
                        color: ConstColor.yellow,
                      ),
                    ),
                  ),
                  EsaySize.gap(175),
                  Container(
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      width: EsaySize.width(context),
                      height: 40,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 32,
                            color: Colors.black,
                          )))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
