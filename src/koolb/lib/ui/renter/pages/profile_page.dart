import 'package:koolb/flutter_flow/flutter_flow_theme.dart';
import 'package:koolb/flutter_flow/flutter_flow_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.network(
                        'https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg',
                        width: 400,
                        height: 200,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://azpet.b-cdn.net/wp-content/uploads/2022/09/C2725-C13180-1.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Text(
                                      'Frankie',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF152A50),
                                          ),
                                    ),
                                  ),
                                  Text(
                                    'Vietnam',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF6E829A),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'DOB',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            '12/10/2002',
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 30,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Email',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'exam@gmail.com',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 30,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Facebook',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(40),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'huhuhu',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Setting',
                      style: FlutterFlowTheme.of(context).title1,
                    ),
                  ],
                ),
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'User and Security',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              borderRadius: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'General',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 1,
                              ),
                              borderRadius: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Notification Setting',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 1,
                              ),
                              borderRadius: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'About Us',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 1,
                              ),
                              borderRadius: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Help Center',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 1,
                              ),
                              borderRadius: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Log Out',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: Color(0xDA39A2EF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
