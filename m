Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeC1AYd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:24:33 -0400
Received: from mail-ty1jpn01on0049.outbound.protection.outlook.com ([104.47.93.49]:49248
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752060AbeC1AYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:24:31 -0400
From: Masaki Ota <masaki.ota@jp.alps.com>
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Kees Cook <keescook@chromium.org>,
        Nir Perry <nirperry@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Input: ALPS - add support for 73 03 28 devices (Thinkpad
 L570)
Thread-Topic: [PATCH] Input: ALPS - add support for 73 03 28 devices (Thinkpad
 L570)
Thread-Index: AQHTwrMnmglbnj/vq0u9azarPmI2eaPd4nQAgAY+5ICAAJ/OUA==
Date: Wed, 28 Mar 2018 00:24:26 +0000
Message-ID: <TYXPR01MB07194E0C045B134D1788E2C0C7A30@TYXPR01MB0719.jpnprd01.prod.outlook.com>
References: <7d5077ef-c185-c6b1-d602-df8d9f7dade3@secunet.com>
 <20180323143336.v26rvflt3oq5xppn@pali>
 <bbb6a2ea-c8d1-beae-1f83-c234f03d4d77@secunet.com>
In-Reply-To: <bbb6a2ea-c8d1-beae-1f83-c234f03d4d77@secunet.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masaki.ota@jp.alps.com;
x-originating-ip: [106.184.109.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB0958;7:IZPg53UidQP0cqz2mf+ev+ObzA7wKNpYReYlJJ0jnPV2eUBlTBS5j0GlZqUDOA6Mf+QhnQoTI5TQIvRreKYyXurrVoTVrfgSLN1Zset/3so0QppgjAkY561gXqcDi2wMK102jh1LkMAyi0Lf/9kVllxMUmGdrD64YyKN+3cbucj90kMTLY2Hv7LVYFbwi0IM9ADAh7TArwrMZXsZb4JvRoSvZqevSVI+MhvoTu5AyFjypS9A+2DFAOrSqq7o6NfQ;20:xoG5M0RBSrIrR41WXG9SXYJVGcyc34X45KLhfbyrofNru/cJL8Ig5CdNybW5SxbhycYb1Fw86xXb3e2JAMukL5askdJIr4C/ib7GX4Q1o+CdWxSySyX6djGA8agJQa/WDy+XWi7dtNaIrI7X5Gy8SiUED+2BiFSVCw/uAV9mhBQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1aa4215-bb5f-4a56-9d4b-08d59442437b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB0958;
x-ms-traffictypediagnostic: TYXPR01MB0958:
x-microsoft-antispam-prvs: <TYXPR01MB0958F6CF3C51BA0178700B52C7A30@TYXPR01MB0958.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(211171220733660)(9931346810618)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:TYXPR01MB0958;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB0958;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(59450400001)(86362001)(102836004)(33656002)(7696005)(53936002)(99286004)(186003)(6436002)(106356001)(76176011)(229853002)(77096007)(26005)(2906002)(8936002)(8676002)(81156014)(68736007)(3846002)(81166006)(74316002)(6116002)(7736002)(105586002)(305945005)(9686003)(55016002)(3280700002)(3660700001)(11346002)(446003)(2900100001)(85182001)(14454004)(316002)(25786009)(5660300001)(575784001)(97736004)(476003)(486005)(53546011)(66066001)(6246003)(478600001)(486005)(6506007)(4326008)(110136005)(54906003)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:TYXPR01MB0958;H:TYXPR01MB0719.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
x-microsoft-antispam-message-info: A7RdlCEVJ0LHPiZGa73iujj3fQAXlMTcIeW9l8ktM0jAkjj3gt4bjjuML3lcgnTZnscMA2GaE4GenYJFUm3kDoOLOkkpqwWD15c/Q+iBq0dSSfCJM3/7MuU6LB6OTOnuTzU3IKCmpBMg8A5563xySIRXXyn8A7VGk7ZvCYKp1ul+8U9E36eK67B80i6AcgmIOxbkxIm6zQWPOWfB+d0EyKL+7NyFwL6pLmQZDrOy4v1UMDPBODZNbGiS+XzKBjelUMUG/GMYLE3PmmT8yw7/p/vFgkkTPED6b1nPIV5ZchY6r/guNSOc/1keo8VF1JsHOMiIJgSpEIh2s95CZbkSMg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: jp.alps.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aa4215-bb5f-4a56-9d4b-08d59442437b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 00:24:26.1845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB0958
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2S0OdqJ019774

Hi, Dennis

I know your issue, and I added the solution for Thinkpad L/E system last year.
BTW, Pali also knows about it.

  On Wednesday 29 November 2017 17:33:58 Masaki Ota wrote:
From: Masaki Ota <masaki.ota@jp.alps.com
- The issue is that Thinkpad L570 TrackStick does not work. Because the main interface of Thinkpad L570 device is SMBus, so ALPS overlooked PS2 interface Firmware setting of TrackStick. The detail is that TrackStick otp bit is disabled.
- Add the code that checks 0xD7 address value. This value is device number information, so we can identify the device by checking this value.
- If we check 0xD7 value, we need to enable Command mode and after check the value we need to disable Command mode, then we have to enable the device(0xF4 command).
- Thinkpad L570 device number is 0x0C or 0x1D. If it is TRUE, enable ALPS_DUALPOINT flag.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com
---
 drivers/input/mouse/alps.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c 
b/drivers/input/mouse/alps.c index 850b00e3ad8e..6f092bdd9fc5
100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2541,13 +2541,31 @@ static int 
alps_update_btn_info_ss4_v2(unsigned char otp[][4],  }
 
 static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
-				       struct alps_data *priv)
+				       struct alps_data *priv,
+					struct psmouse *psmouse)
 {

 	bool is_dual = false;
+	int reg_val = 0;
+	struct ps2dev *ps2dev = &psmouse-ps2dev;
 
-	if (IS_SS4PLUS_DEV(priv-dev_id))
+	if (IS_SS4PLUS_DEV(priv-dev_id)) {
 		is_dual = (otp[0][0]  4) & 0x01;
 
+		if (!is_dual) {
+			/* For support TrackStick of Thinkpad L/E series */
+			if (alps_exit_command_mode(psmouse) == 0 &&
+				alps_enter_command_mode(psmouse) == 0) {
+				reg_val = alps_command_mode_read_reg(psmouse,
+									0xD7);
+			}
+			alps_exit_command_mode(psmouse);
+			ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+			if (reg_val == 0x0C || reg_val == 0x1D)
+				is_dual = true;
+		}
+	}
+
 	if (is_dual)
 		priv-flags |= ALPS_DUALPOINT |
 					ALPS_DUALPOINT_WITH_PRESSURE; @@ -2570,7 +2588,7 @@ static 
int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
 
 	alps_update_btn_info_ss4_v2(otp, priv);
 
-	alps_update_dual_info_ss4_v2(otp, priv);
+	alps_update_dual_info_ss4_v2(otp, priv, psmouse);

 	return 0;
 }
Best Regards,
Masaki Ota
-----Original Message-----
From: Dennis Wassenberg [mailto:dennis.wassenberg@secunet.com] 
Sent: Tuesday, March 27, 2018 10:56 PM
To: Pali Rohár <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Takashi Iwai <tiwai@suse.de>; Kees Cook <keescook@chromium.org>; Nir Perry <nirperry@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ALPS - add support for 73 03 28 devices (Thinkpad L570)

Hi,

oh ok, understood. Thanks for this hint.

So maybe there is something wrong with the alps_update_dual_info_ss4_v2 function or the reporting of the hardware.

alps_update_dual_info_ss4_v2 detects the ThinkPad L570 as ss4plus device but not as dualpoint device. This means that the ALPS_DUALPOINT and the ALPS_DUALPOINT_WITH_PRESSURE flag will not be set which results in a non function trackstick and hardware mouse buttons. Each time I touch the trackstick I get the message: "alps: Rejected trackstick packet from non DualPoint device".

The value of otp[0][0] inside alps_update_dual_info_ss4_v2 is 0xCE. Are there any ideas why it is not detected as dualpoint device?

Thank you & best regards,

Dennis

On 23.03.2018 15:33, Pali Rohár wrote:
> On Friday 23 March 2018 15:23:55 Dennis Wassenberg wrote:
>> The Lenovo Thinkpad L570 uses V8 protocol.
>> Add 0x73 0x03 0x28 devices to use V8 protovol which makes trackstick 
>> and mouse buttons work with Lenovo Thinkpad L570.
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
>> ---
>>  drivers/input/mouse/alps.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c 
>> index dbe57da..5523d4e 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -136,6 +136,8 @@
>>  	{ { 0x73, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
>>  	{ { 0x73, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },			/* Ahtec Laptop */
>>  	{ { 0x73, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },		/* Dell Vostro 1400 */
>> +	{ { 0x73, 0x03, 0x28 }, { ALPS_PROTO_V8, 0x18, 0x18,
>> +		ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE | ALPS_BUTTONPAD } },		/* Lenovo L570 */
>>  };
>>  
>>  static const struct alps_protocol_info alps_v3_protocol_data = {
> 
> Hi! alps_model_data table is used for fixed identification of v1 and 
> v2 protocols. Why you need to add there v8 protocol which 
> autodetection is already done in alps_identify() function? There is already code:
> 
> 		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
> 			   (e7[2] == 0x14 || e7[2] == 0x28)) {
> 			protocol = &alps_v8_protocol_data;
> 
> Which matches above your E7 detection 0x73, 0x03, 0x28.
> 
> Also you patch matches basically all v8 device and therefore has 
> potential to break proper v8 autodetection for other v8 devices...
> 
