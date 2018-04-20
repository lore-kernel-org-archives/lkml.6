Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeDTHmh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:42:37 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:50549
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753729AbeDTHmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:42:32 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, shengjiu.wang@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V3 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock source
Date: Fri, 20 Apr 2018 15:38:11 +0800
Message-Id: <1524209891-14146-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524209891-14146-1-git-send-email-Anson.Huang@nxp.com>
References: <1524209891-14146-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:poJ+4+OpB5FB3nv0kmdPhiors7psdn5TR0z58Ud7TwC6klgGtZ7Pa4jhqlqmiVlWfrMiVNJ71shHa2McsYZKRTTWkKdUVcvaBkowCj6BH/NDwP4wfXJ9sCTZ/zqxQvKjCFK6IKimfsErG4CI6qeP1l7kkToJ8yms5ywIj5F0pJ2MSprPN+YcgpnfpTZlE894+5eC9qAn1xxYoimTnTZqix1Y5GnNdctaL4PyS2pHYToH9Zo6eXd7B8vjs4jVJ4pS;25:jkbucPUZ/Ao3gsb/WctaRIDasK6Hc+cTD0WE99DXmSxybhZlb7Ffbf877eXTFVbcvrTmJ6O5gudMDoS78uWDDxG11hubUG8zgZ/oYUkTUgnVFpR/9IvcPUbgutdDe50stSCZtpiL3u7ElZFK8bHL/2Gu01D4f0iF/dGXwjS2PvUJr+6+aD+mRvmFh4V765AguGp+WQSr3zUxe4krbwHXhjWjC4Q5NVhaoz8tGPof6M894uSGdyjYIrEr5pvAU/7S7prCGcy92IyGBNlNWhBo9uQt0XVduNUDBPF18qP2vWff38ytEUOsXdZnPHKjvAR5N3Gy7crCJWVtbXGw/tccKQ==;31:8BmcZZSBDhsdi6w6OX6iyeMqjAt5JzJCp34dEBK1qTkF0qNV1QP0NLzH/T4aDsKd3M6W5i4z/gctcnMOy0tWcX2uloXqtMJD0EcLDEZhxqwtT62ip9h10OUlftkCKIER5ez7OJTvypzGqriihnIEy+MHs9q/uSd3HdS4m8kk+dkETKS8VnaZREw/kOd+JePABv7isKtLoOnkfan9d80kRXMMRk2paiazR+5k1ZUt66k=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:H5SUvPZWfBZ9byYeDl+jdOYkxF1NnCywfUBY3ZIpnFe1Xr3BUt2poRAMdeZTuOrzU1YjiAynmoT7ks19Xtv3RYHeBRArTEUnyWxNKBxflqiZ/HxHsf5KbTRPfcIKwvnCrV2FMJ1t0algqoCo7mLzaTpK/80YZuPvSe2vyE7ctdDRNNyamRTT7ZRuPxcFO8tsfnb1U10e8IVv3y8qsaWtsy4zcccFVSNikTl3QkBMPIMZ8oOkxYEvyHktaTo7OuqvsJ+E+/X1cLUMYv7fHfvuzueq5JzvjURkOIiNTN4Yu8IRcYUJpEKvXE6sVRnSrHDeopw4gMdchaaI/MfrTO5lJh3Lf+wUYxQk+s1sW8aZ64+TL9H1k/xOeRUlONX/jd+VfuKv5FPFIE5jpDdiQj3+CLOSiNQowhXLjkxFmUfo3QgQ63i5BBl53Jz9ZOFeHz+yD1MHSl26df5/dO+0GH+oAXaA5PTblGDssBWiAFhYJgAt8T+8/wYBqcYLOeLPaCXX;4:623iTLsJrxECO1pIgJl97NPpYCOtB4ThsmeTxlACdoSMzxpWjsL00CHewOWBK2LbLHYOKHfGguBRw/LjRUkRZdsYK8iAkJGovtiQJ7hhszKx+c+7HhDRyl3LVdcZ2aBQvmI04DVxojSdDbL3h3YtsJPw4ar1UqbdxV24EgEv2ME/GDAhISHcWs6ZlT2UgEdwfWZvS2h7CZH2h9tXwtz6TLEHcpVBloBkeqx7G5DEMuNjK6udeIy82Z+evazRfCp+Nuey1nWDZw/o7jruKmncEIHaQ/HzC5/pe4jn0FvzFg4Guc+VQQbHGyXG2uyzh+C0
X-Microsoft-Antispam-PRVS: <HE1PR04MB13245E11AA12B87749E6FD1DF5B40@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501391)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(305945005)(25786009)(52116002)(11346002)(53936002)(478600001)(446003)(26005)(476003)(16586007)(66066001)(2616005)(6506007)(316002)(186003)(86362001)(16526019)(386003)(4326008)(76176011)(2906002)(3846002)(6116002)(6512007)(6666003)(7416002)(47776003)(956004)(6486002)(6636002)(50466002)(8676002)(36756003)(81166006)(48376002)(8936002)(7736002)(50226002)(5660300001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:LBUf8lyNuaM8Q0CoBfCsFSLU2ZZC4eI8OyWka6O7c?=
 =?us-ascii?Q?kwkjn2YxT2AVhjhLRpShu/SRF6Jg2VRGPdoelN1WijsxDPrCwd9kaDnFOgEx?=
 =?us-ascii?Q?3wF+VZ9bOeq0/87ZCTgsO79NqmJIjQQsmbyoCILP/6B8p7TZSwDJA9XesrUf?=
 =?us-ascii?Q?kpS5OkjQatZkX8gA4UdGG1ZNkIK2JGMssv4Ruo8uAC7ZGq5042KrX/Yezv2C?=
 =?us-ascii?Q?pAePApMVgpD9D+YMzURzVujoz1qO+SjBjvBFbVQiZ6rTXDkb0gkpzqBD2VDK?=
 =?us-ascii?Q?D1YSqP+jzfN2I8cxnmgEi/CZeI3Xm2jkxWDKWHw8BT9u5jJ1iKgo2KR62hR/?=
 =?us-ascii?Q?18Y0cvIf5V4aMWotXeJx89f4tL13xiZ3fhDnfrRKR1TIukuwkyBd0JrkQXLg?=
 =?us-ascii?Q?tZDk9cqkf2M5kctplgb4zZ13LRBKpjTiz8c+Mz2pAS78tofJKtdsexEbaZpH?=
 =?us-ascii?Q?TimJay1gGSd+AI0+JjEu9fGdahUcUMhpI1wCxwz/dxRlL2PWzb4TH0W4PYl3?=
 =?us-ascii?Q?ZtbusUoAnFC23zlYD4ZSqV+VKN5goK/uuCMBl1Z7hD2HrYXACPIfOXGGvDO7?=
 =?us-ascii?Q?WvYJSaGHH13UpOml0DJPSRVobukQOE3Yb1Fp1d0HGfWY5C8MYob5M13xsZG9?=
 =?us-ascii?Q?NSYs9/b3mFGMEDl0X9wLWHSczeRUb4N0qpVO0txm/YqkIIQU3bX5eHOsN4g1?=
 =?us-ascii?Q?m2Zz/Po3HQYxmyN9N5olJy6LlSQ09MkrM3tUGgwTr65zgbksE3kywNdbC69/?=
 =?us-ascii?Q?EFgvexc3wEkDJplirI038ZiSTVo7Q0XIf1t2G6EdyKp2viHFn2QdP9LGbQhP?=
 =?us-ascii?Q?L8ROT1ZNThiyK2Tq9RANbjiGG/ogpVt2xULWJ/fQdQ944aV2ib6RyCMKBjht?=
 =?us-ascii?Q?/JingqX6fipsDh4UBFw2yJ1+bUUsghf7jy3iGQ+JuqrlOAs2HvloCS7Xlxre?=
 =?us-ascii?Q?zjtniNVkZ5DWfIrjSNc/7PAVnmN7bD5PFAVGozY8NHF3q2KcbxEw0SdQFLQW?=
 =?us-ascii?Q?HvLyDZMgvNMDxYzU4y9lFImFQhPEyS8IOaBojdJ0Cl1/A=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2OjLc1CB7zYMW1gZxCjzE5yea7Z5D8gl+BOQUzx6CuN4NVg9pzz4uRyGfmiyoKv06dMVghcgPJhHFNl7UZ32DLauZkHsa2Vbqb/pTkO/89oZFfYsI+lxbC++WyvPmOLp3OoNlCp6Ew7Jvwj1p/vqd/Z1/L/Ggt52QlfoXYdwJqjELS7e7XBNiKeRPJwGZnEz
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:85SN6l5+EITPMOIGAP3Gqu+SmJYsrYj9a+8V2Ldo1z8+anRaNHy6VVP/yf/Ftob5TfSKCje7Xyj0zzUnIdOXtWgGdTlZ5F3V0Q41It5zkB+22IR6znbGyX4P8vrL/x9yweOoK4V9WW+SQOP7ZSdY/88Us4SOE2WrucgUOJSnZau+gNkNoZ75Q0nWDlm74Aod2X6EEPKJ6NBPi5qtTuKhe/b9eAh09nyBhyAV1QenAQL1IAFVQeU5kXW0bFmhY7/e1u6o4ix7w9MwAHmDlg4Li+YJwj1UM1I9aDktNV36j75JX0lRO8jH2S0t0VGooy6xsJbUzWUBORjkKY6C1mVbBg6K4FD1gabLITfRVDJyQg/YHnMcZ66HDBovHrc3ansDaiY3foP7nlcQlN4I/JfX73kWuFkiXwsVdY+GzDirrzzcn3bZvpU/H7ZEVmFNY3Q/oX4bKB3lm3P8ddP82FLZPQ==;5:V2Ch3siEcRuDePh4uXXk4qcdg4+/hYsW7EfKpERHe4qi3KFz00qqfZ5vD9qDysG+rF5+QyozaLZ1T9R6gHLSHjuTCfCdifv4kFcijk/L3FVPLIkLQyTgYlYrz/t01mxaovYosIrhFfQOe7CBuVsSSc2IoR0fBucwWVvMTpX7eLg=;24:VmVkq/51amvwxAroHlmM9HGidNAuAGP2BElZJhD46CGBwcuGsfPH9+LMTz6jH8+Y8Ucbhh877oHIUZ/h98fu23PQd7lKJ+Ku0/CZIbEc7Vk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:LUssPBIHA92vrT3ByvBwk8Qom4PUSYYQOAFGq8w7xrN37mowZD/AcuJcHhPeSt1eDraiebDmXuaYFalO55ZJTF2xPZK450qodryAB/m30L/dj+j7ToTd0rt8EoDofjDj46JCZct8G/MRmnEvVYAW9AYIz3GKbftWW4R/6zrVUTpbZKasxNnqJ/26e5njQ0t9U08vNMz8OgN/XWfY4wP2ruEgto/y+95oYXasijkZ9458zj041zH4KWV90rqan3ny
X-MS-Office365-Filtering-Correlation-Id: 2119dcdc-ee2e-4d89-e91e-08d5a6924358
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:42:22.7815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2119dcdc-ee2e-4d89-e91e-08d5a6924358
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SX SabreAuto board, there is external 24MHz clock
source for analog clock2, add this clock source to clock tree
and remove "clocks" container for all input clocks.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	remove "clocks" container and use new way for all input clocks definition.
 arch/arm/boot/dts/imx6sx-sabreauto.dts |  4 ++
 arch/arm/boot/dts/imx6sx.dtsi          | 71 ++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 72da5ac..57d1ea0 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -37,6 +37,10 @@
 	};
 };
 
+&anaclk2 {
+	clock-frequency = <24576000>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205..7e463d2 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -104,41 +104,46 @@
 		interrupt-parent = <&intc>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
+	ckil: clock-ckil {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ckil";
+	};
 
-		ckil: clock@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "ckil";
-		};
+	osc: clock-osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc";
+	};
 
-		osc: clock@1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			#clock-cells = <0>;
-			clock-frequency = <24000000>;
-			clock-output-names = "osc";
-		};
+	ipp_di0: clock-ipp-di0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "ipp_di0";
+	};
 
-		ipp_di0: clock@2 {
-			compatible = "fixed-clock";
-			reg = <2>;
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-			clock-output-names = "ipp_di0";
-		};
+	ipp_di1: clock-ipp-di1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "ipp_di1";
+	};
 
-		ipp_di1: clock@3 {
-			compatible = "fixed-clock";
-			reg = <3>;
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-			clock-output-names = "ipp_di1";
-		};
+	anaclk1: clock-anaclk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "anaclk1";
+	};
+
+	anaclk2: clock-anaclk2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "anaclk2";
 	};
 
 	tempmon: tempmon {
@@ -575,8 +580,8 @@
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
-				clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>;
-				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
+				clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>, <&anaclk1>, <&anaclk2>;
+				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1", "anaclk1", "anaclk2";
 			};
 
 			anatop: anatop@20c8000 {
-- 
2.7.4
