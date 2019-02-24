Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C412A20842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfBXVv2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 16:51:28 -0500
Received: from mail-oln040092071082.outbound.protection.outlook.com ([40.92.71.82]:6167
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfBXVv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 16:51:28 -0500
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (10.152.18.51) by VE1EUR03HT089.eop-EUR03.prod.protection.outlook.com
 (10.152.19.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.11; Sun, 24 Feb
 2019 21:51:22 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.18.57) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Sun, 24 Feb 2019 21:51:22 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1643.019; Sun, 24 Feb
 2019 21:51:22 +0000
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
Subject: [PATCH] ARM: dts: rockchip: fix rk3288 cpu opp node reference
Thread-Topic: [PATCH] ARM: dts: rockchip: fix rk3288 cpu opp node reference
Thread-Index: AQHUzIsUCHHVZIT5gUGqpB7tPDNEtQ==
Date:   Sun, 24 Feb 2019 21:51:22 +0000
Message-ID: <AM3PR03MB0966C52CCF14FCEDE6615265AC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0032.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::45) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:F972A736F52C2FD2BAFEE8270221852B49197743C65E7198F8353B7E1F4ED03C;UpperCasedChecksum:A95496DB9B26ED8EACC4EBD055DEC8D2EFF0A59412C85641A10823AAF85BF2F9;SizeAsReceived:8597;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [A3l8AM3xX4xbHoAhwb66n7xfNYIBNx57]
x-microsoft-original-message-id: <20190224215110.27049-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031324274)(2017031323274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT089;
x-ms-traffictypediagnostic: VE1EUR03HT089:
x-microsoft-antispam-message-info: 1WKWTie9iIDTAfZRdgTGJScraUIQoi4H/CDpIvH9o0fp2ROV+qbM1SERS+cnZStG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ac99c053-86c0-4c44-cea6-08d69aa236cf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 21:51:21.2029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error can be seen during boot:

  of: /cpus/cpu@501: Couldn't find opp node

Change cpu nodes to use operating-points-v2 in order to fix this.

Fixes: ce76de984649 ("ARM: dts: rockchip: convert rk3288 to operating-points-v2")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/boot/dts/rk3288.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ca7d52daa8fb..09868dcee34b 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -70,7 +70,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x501>;
 			resets = <&cru SRST_CORE1>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -80,7 +80,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x502>;
 			resets = <&cru SRST_CORE2>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -90,7 +90,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x503>;
 			resets = <&cru SRST_CORE3>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
-- 
2.17.1

