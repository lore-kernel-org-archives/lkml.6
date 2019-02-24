Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D00C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C875020651
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfBXUKK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:10:10 -0500
Received: from mail-oln040092068047.outbound.protection.outlook.com ([40.92.68.47]:18459
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbfBXUKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:10:10 -0500
Received: from HE1EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (10.152.10.54) by HE1EUR02HT083.eop-EUR02.prod.protection.outlook.com
 (10.152.11.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 24 Feb
 2019 20:10:06 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.10.55) by
 HE1EUR02FT021.mail.protection.outlook.com (10.152.10.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 24 Feb 2019 20:10:06 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1643.019; Sun, 24 Feb
 2019 20:10:06 +0000
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
Subject: [PATCH] ARM: dts: rockchip: Enable HDMI CEC on rk3288-tinker-s
Thread-Topic: [PATCH] ARM: dts: rockchip: Enable HDMI CEC on rk3288-tinker-s
Thread-Index: AQHUzHzvJU+Wey4D206DLTd1OY5eQQ==
Date:   Sun, 24 Feb 2019 20:10:06 +0000
Message-ID: <AM3PR03MB096695687A4BDD432428A977AC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0099.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::40) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:DF45CFA2DB92743F5C7E5AD08D39BB51D9D1ADA39CD8ADE41BFD400F7968AF1B;UpperCasedChecksum:831317F6FE4A78AFABB9D7F6F5BC619E12747762929F90A536B904AF3764E6F1;SizeAsReceived:8581;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [VLWJ+WQVJrDV080W2HfAOQbvGWV6bNUD]
x-microsoft-original-message-id: <20190224200946.25414-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(1601125500)(1603101475)(1701031045);SRVR:HE1EUR02HT083;
x-ms-traffictypediagnostic: HE1EUR02HT083:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:HE1EUR02HT083;BCL:0;PCL:0;RULEID:;SRVR:HE1EUR02HT083;
x-microsoft-antispam-message-info: xJVlkGBqpmwcrZyBIHktzBkx3iI/TQpItjQ7BohXquhy4X+L65XOAUonVYmuoxWI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-Network-Message-Id: d46cab32-06c7-4d71-70e7-08d69a941167
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 20:10:05.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables HDMI CEC on Tinker Board S

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rk3288-tinker-s.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rk3288-tinker-s.dts
index 37093922b482..590e3b06bbc4 100644
--- a/arch/arm/boot/dts/rk3288-tinker-s.dts
+++ b/arch/arm/boot/dts/rk3288-tinker-s.dts
@@ -24,3 +24,8 @@
 	mmc-ddr-1_8v;
 	status = "okay";
 };
+
+&hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec_c0>;
+};
-- 
2.17.1

