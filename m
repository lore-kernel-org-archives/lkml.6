Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A061FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7796B20684
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfBXVwE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 16:52:04 -0500
Received: from mail-oln040092072092.outbound.protection.outlook.com ([40.92.72.92]:9306
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfBXVwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 16:52:03 -0500
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (10.152.18.54) by VE1EUR03HT122.eop-EUR03.prod.protection.outlook.com
 (10.152.19.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.11; Sun, 24 Feb
 2019 21:52:00 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.18.57) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Sun, 24 Feb 2019 21:52:00 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1643.019; Sun, 24 Feb
 2019 21:52:00 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] ARM: dts: rockchip: rk3288: fix missing grf reference in
 tsadc node
Thread-Topic: [PATCH] ARM: dts: rockchip: rk3288: fix missing grf reference in
 tsadc node
Thread-Index: AQHUzIsrW0lDPGzod0axIMQ6/XBdIg==
Date:   Sun, 24 Feb 2019 21:52:00 +0000
Message-ID: <AM3PR03MB0966E8AA93CC1B7CA355CECEAC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:209:15::41) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:15FE91DE1AA5C4E98D07A8A46C53197ECE86C5185117D5B62CA6E2BBE1209BD0;UpperCasedChecksum:6EF191C621A58E1290D2FC9330AE75E681509F6127DE3882C19915954BF3B044;SizeAsReceived:8621;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [nP1CL3Q867oVxGzBoSvuqfYWEtS28/zV]
x-microsoft-original-message-id: <20190224215150.27145-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT122;
x-ms-traffictypediagnostic: VE1EUR03HT122:
x-microsoft-antispam-message-info: FYE8B5Qu0ny2xY0YqsdcNTpUIpmOeETeB5DeR4FuIboU+XOIRc6MyY4GSWmZFDmw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8a00df-d4e3-40f5-eb5a-08d69aa24da1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 21:51:59.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following message can be seen during boot:

  rockchip-thermal ff280000.tsadc: Missing rockchip,grf property

Fix this by adding rockchip,grf property to tsadc node.

Fixes: b67d6bc38823 ("ARM: dts: rockchip: add main thermal info to rk3288")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ca7d52daa8fb..b577f3e41811 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -569,6 +569,7 @@
 		pinctrl-1 = <&otp_out>;
 		pinctrl-2 = <&otp_gpio>;
 		#thermal-sensor-cells = <1>;
+		rockchip,grf = <&grf>;
 		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
 	};
-- 
2.17.1

