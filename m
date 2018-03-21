Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeCUCiH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:38:07 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:35688
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeCUCiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:38:03 -0400
From: Robin Gong <yibin.gong@nxp.com>
To: shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, kernel@pengutronix.de, fabio.estevam@nxp.com,
        aisheng.dong@nxp.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v1] ARM: dts: imx6qdl-sabreauto: add ecspi dts for sabreauto board
Date: Wed, 21 Mar 2018 18:38:18 +0800
Message-Id: <1521628698-1178-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To AM5PR04MB3217.eurprd04.prod.outlook.com
 (2603:10a6:206:7::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63c54119-c665-475a-0c14-08d58ed4c3e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3217;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:p9jTyvZR3LkvRK6yxrbpveINjt6T1E1UXdB3+Afwsp8naTzhO3sTN+xzQM3V3osnVDILXGx7Z+X7pyrWaoiWyg1DuY4dhGJYpyEGTbKOm6YBImN0DridkHgg4S2HfAxRV83BqXa7qzBLaPZKAusekcO0SxDgOvsosAB1t1d1d9mlI1qkfgdnlOIzA8zNL62gKvnAM8ot7xKV3BPtOsrhbSjQwcbdVlMAsn6uoIkllMMim7GAxmSY23cRptwyWNOM;25:TcrhsByMY4KiEWr/obnhl45Wbdnyq31CH/ScgkModASw4UXlD74SQkkfMCgS19Lf0wRl5TrCYf4f/Is7m0+TaYn93HALAT/DWhHZVE0BKPmkVD8jYhxz0WL8Wzfk55EKnss/jqgct8EjIklRxrVvOBNhKrVKl5wSttULipk0D4brJ+KYLe2mWNYgf/EwxP1i02bmX5b1oBw8szjO0cjaY9BKs49qUoTNsGfWCFzSpSkNLWG/7k9V92nqgEkCy1Cvn0AIYtUaesUIE7jF/OKABmyMjaC1Yp+ZT6XN34MxrWg05upfEvlDF7r9lsmpkJQSxu9wrnZ67+CQ/WvlQwOWYg==;31:AmiDqTPR2sWHIgqZqQqVzTy4poUkA3QkqCqUXf1UZd97QBKY0PVglD+2RwCjH11yYCvPBF3J22umYZATIexw43/kXASPBi+W9agPqyog0dr2EYMmOXdD3GCZqnv1dJPHvyb2S/DrwVlEdKL97N6d7jfMots0Is3Rf/aCcIYJD4TZsEmv2bP+fB/RfQGS67kguEtJSPHizwqqEI2ce0GHQa2GFUlvaWeFEA6S2NkDiuI=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:te7Q5rJAvEORguor47cPAZhh/0++NJTIQGyOnE3EAZu/Avuo7yULLYIfySRlDqOroM9dt3KNjavURzgFVJyOC5qP3V/vXyJusDuqxuAOhnoSgME97i+5K0g+qk7gazh6GTgJkilFMq//qbhBnQv2h+ErX8B+T9thKbXX5gwfCUkaHEBy2ZUC49NYjOSR7GfRbMeAVrqxO2MjGjbROOdUO/+a7MDZkRBWzRnMtp1nUNKPGeJYsV1JRqgc8yXZ9eN1lD9WqleWYAs9qPrMgN6H0Kn7D4CAIlaNRLYWQBZK+sarLcVES5znXEZiV1X6j8H6d1/qXm36E/Pbg6lt/3PTl3BWhnoqk3In8nCY3x5UgTMxi3AHDf35sNSIrcUBD4qcUW2V/Tlez7cNNlCRHP5stLIxRWOvCNwLFFeKqj+kRgb+QaxZz43ir7d1sEmBWgeF7zt7me+47rQ96t0pbe4ddCac78+QCXe9qokICjBtRsCuWp4NBNzkCMWDbiVpOdBR;4:iD/xgo47Th+8lR7KjJPV04Ynga7bNR1XGABpLjJBJx1YCrgHuzhu9bEMvowjm/sKCay4G8cNmlGVLGtuAUY4AtsygjDngtjLPptccAaI327DpRtR+BfpRxl5uRznz64NRW/Qyip+uURrBvCxC+bJfQ3sEPSHVJ9etINwwmLrOe+xSB/8dGScEwdq4nvRU7Hfv2mMQfZDX4PPOqYtGK7PUeLe5G5hTh/He9PNIa6J5JsosPMTmmN2qd3nTUTERQ6Ka4zqlsGSskPgzyACX7RGf9LDeSOR+Jq3ch2A2RFkgHdAPhs/yeFaCnqEhIapArnD
X-Microsoft-Antispam-PRVS: <AM5PR04MB32173BF1FEB4E0D49742421B89AA0@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501317)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(189003)(199004)(47776003)(6636002)(6512007)(6116002)(3846002)(105586002)(86362001)(6666003)(51416003)(52116002)(478600001)(50466002)(7736002)(50226002)(2906002)(305945005)(48376002)(316002)(8936002)(68736007)(26005)(4326008)(386003)(6506007)(16586007)(59450400001)(8676002)(81166006)(25786009)(6486002)(106356001)(5660300001)(81156014)(66066001)(16526019)(97736004)(53936002)(186003)(36756003)(2004002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:n1Kni1uFU8rQIef/kJP0jvgBfkFOB1MlgPkle2u8L?=
 =?us-ascii?Q?EVXCq884AX7wHQVH7tUzWyd9wE9f9T/Z3MvBybKq+A0kF/iYAuQk3FNLZYT7?=
 =?us-ascii?Q?z/4PMxqi3oL+N3/KHww9JtA3h1Jp90fs51RPC90dvqhTn2Dyd+0zlSDCWZ6c?=
 =?us-ascii?Q?wiZ2ikkOLs3HcPmyU1NVp7Ssd8U7BygiMF2Ncm/2i7JbmGCrsazDG0eZdQ22?=
 =?us-ascii?Q?WlJx9bxWc7pwkB3oth2q+7l6QMknkX5JPfye2GRnGEiGZ0JkIVQV2tvAip62?=
 =?us-ascii?Q?oBgrbhnFwtWZ2QfLeAgoIalQCy/U1z21C9JM9I455EQ6cpr310U+/lhgrCQm?=
 =?us-ascii?Q?SurZBNKQz9xGIvR355/cI8Ssdn23ZwI34I5addtHNqd82WUaglJSAd7an8Ek?=
 =?us-ascii?Q?rUjef4fVBwmDyNVLAHb+JGz3nDRyA21NPG8vC/k5Wn/Mu8mCghF9fqntR2XD?=
 =?us-ascii?Q?z1VauXPM5O/3/1srQDrpJnCC10YfioOYBqQUZk1penvHpE3wUJVFuo31NrOI?=
 =?us-ascii?Q?gFboV3oRSNzX9uxTf8nCacCT2oXk1X6E01kWZVFEAXwe7myyjKnLDyx4Uxg3?=
 =?us-ascii?Q?J6b7CF16/iPPpXRZTNOKW5nxIvYVppb4YcmcptUTweAy2rf5AzbC6c8HIYst?=
 =?us-ascii?Q?xIJMG4GzVxnM7FnRMG6CVelMspgPuLB6NHvVa3Gsc15MGYEhe6Lb0Xc3iZQ1?=
 =?us-ascii?Q?+0wqqq0yKQt9PWYPR+N+RwAfMVjlmgMX/uRM/irfJBp7aESenLzoCrMKNTOo?=
 =?us-ascii?Q?uvwHLPiyKHjEtYbCDnWgP05EeOLVodkWoxpEZv6Qp/PbJxnE3/NttWd1JjbX?=
 =?us-ascii?Q?zF/t/sby6ejiTon0OAEExQiqbVxBC31SdeDQnanWv0/e5Vyo7wfcE8qpbdTm?=
 =?us-ascii?Q?ClwbRpScyrISmNiv59I8WVCJjuIeqQc2lXo1L5Bq+o0orPLtSC5LTtYQTUid?=
 =?us-ascii?Q?jwxVxDbyD5s6FLr8ry6vcQUtn3JQZ8M/KH7AYU7eZ9t4IdLLtB0aU0/NlgvA?=
 =?us-ascii?Q?7t8764JbfOZDjLX8+Vh5XWl+0sv0leov/amhfmMsRkFEhhxoro2E2C8VIcFT?=
 =?us-ascii?Q?A2Sq8aqXwVfFKXqZo0JdIsgqtdch6UbytVwlp3vqU5jkxsO+YD5W5eWoaD5k?=
 =?us-ascii?Q?Wzmpb5STyE=3D?=
X-Microsoft-Antispam-Message-Info: rBSYaY2m6pwJ3H7pjzo0PPpBUrKhX1Lb+Xcg/QdxmmWOeYE3kCYz7Q16gSUAUDs/uB/uFvQ9WWoU5XM0pPxUuZappvenCpZ3jV6+5BvUDwVuKacZjq+bEL0rxtVBexWRcq26cEyvVgawDN0onhwuZ+la/Qw/aTxgqJD1lqdexNOqUMkyDGetHOl80aVd0bs4
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:kMz1Wkd3hubVpjrnc/93/6+pQLsZaFFewp6kMCyxtKuRDRrcAaF0V7YM3KpB4HWZoKCm+Ct0ZOgdm0QnLJ4z9wHSof/lrO4w7a6QUkJw9NaAiOZHOJVGeur00F8e99/pYTdOtepsNfNgJfYew5+AIdxdm/IQLXVxty20HEqClzEqeYUjcpEFNfXN7SiagF1HVvXWd+Rr3jbiPR2WNIu+RZTTODUmOsvdHc5IHke0OoWCMN2bQqSgNB3LHpZ8eoOPhAMm1c6zFA+pIom8KHqbWLhfAfYSHVDpRUBqGDB8MiLYlDUSHUidSOvefIxWGQ1uDcdeSoNhIv0PNv3KFFplM8hlLXoyvpGwAWcj/aROQh1C1jfUxTlvGObShPeNpwL+vOswfVswc0PGkF11Ez5wbqIxdrwitVz5IhiGC/IzKmhrzJKZJ/e46hwDokmV9jR7Htxh2qT0g8U62ZkvPHtdCQ==;5:b9mEOf5JVdDsfoOPyUIfFgO6/BTKeDCd5etoTe+T7ctmThaCwDYLEkdtjZxWnoIzZFzvnXRUTlMyV59qcOwbKlr9pKJXT3NYu6jIEfIEs6xpXmCsLSuVLntxLjKoezYKMEA57ZZrpOIjB8zwizIufCu6yVIaUZOEsvECyQ4XLs4=;24:qLgdxXNlAJWDzW2JBQC8WZn8w5+vb7AT4IOTVfxMqxvPRwFyHdVMXHox3b8zMX6oeYo8N0nFsWWUDe2+3Wo5Fk5cB3eB8YQ69UrVFR6humc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:xIE4cHYWSo5MjJB6qnZ++xMxZHFKKnir6euZlQU6uQjYxhnkSYm5JsY7Ie0wXOFoh9CUomHHDVXqi4+KzGb4e/UyPrlATniBiSjf4GOUi26q8kkM/HPqTzY49pZUhl0wuhyOj6CgqP/2JLwkzLyBMqpvTklXpuEMorUhcYYRrOcfFK5HfKU7CzZ07GERt5//T/pA9ox5Eh/XqfaQ3UzwU0dyH4Iggnrw8/h+WXsYa/Qdk71EBLOnfZz0IMBM5zjO
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 02:37:58.0652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c54119-c665-475a-0c14-08d58ed4c3e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIN pin of SPI-NOR muxed with I2C3_SDA which connected to one gpio expand
chip, thus have to disable all those module which compacted by those gpios
if enable SPI-NOR support on Sabreauto board.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/Makefile                   |  2 ++
 arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts | 47 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts  | 48 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     |  1 +
 4 files changed, 98 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4fe209c..4a814bb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -406,6 +406,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
 	imx6dl-sabreauto.dtb \
+	imx6dl-sabreauto-ecspi.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-savageboard.dtb \
@@ -478,6 +479,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-pistachio.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
+	imx6q-sabreauto-ecspi.dtb \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-savageboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts b/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
new file mode 100644
index 0000000..80d018d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6dl-sabreauto.dts"
+
+&gpio5 {
+	eim_d18_steered {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "ecspi1_din";
+	};
+};
+
+&ecspi1 {
+	status = "okay";
+};
+
+&can2 {
+	/* max7310_c on i2c3 is gone */
+	status = "disabled";
+};
+
+&i2c3 {
+	/* pin conflict with ecspi1 */
+	status = "disabled";
+};
+
+&uart3 {
+	/* the uart3 depends on the i2c3, so disable it too. */
+	status = "disabled";
+};
+
+&usbh1 {
+	/* max7310_b on i2c3 is gone */
+	status = "disabled";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts b/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts
new file mode 100644
index 0000000..cb7f38e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6q-sabreauto.dts"
+
+&gpio5 {
+	eim_d18_steered {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "ecspi1_din";
+	};
+};
+
+&ecspi1 {
+	status = "okay";
+};
+
+&can2 {
+	/* max7310_c on i2c3 is gone */
+	status = "disabled";
+};
+
+&i2c3 {
+	/* pin conflict with ecspi1 */
+	status = "disabled";
+};
+
+&uart3 {
+	/* the uart3 depends on the i2c3, so disable it too. */
+	status = "disabled";
+};
+
+&usbh1 {
+	/* max7310_b on i2c3 is gone */
+	status = "disabled";
+};
+
+&usbotg {
+	/* max7310_c on i2c3 is gone */
+	status = "okay";
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 54b0139..b83efc3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -375,6 +375,7 @@
 				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
 				MX6QDL_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
 				MX6QDL_PAD_GPIO_18__SD3_VSELECT 0x17059
+				MX6QDL_PAD_EIM_A24__GPIO5_IO04   0x80000000
 			>;
 		};
 
-- 
2.7.4
