Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeCQHAO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 03:00:14 -0400
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:40409
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750770AbeCQHAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 03:00:12 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <yibin.gong@nxp.com>, <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
Date: Sat, 17 Mar 2018 14:57:07 +0800
Message-ID: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131657436106533977;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(450100002)(15650500001)(77096007)(26005)(36756003)(2420400007)(104016004)(336012)(16586007)(59450400001)(51416003)(68736007)(2906002)(54906003)(110136005)(106466001)(10710500007)(105606002)(47776003)(97736004)(7110500001)(316002)(498600001)(53936002)(6306002)(8676002)(85426001)(81166006)(81156014)(50226002)(5660300001)(966005)(50466002)(48376002)(4326008)(86362001)(356003)(575784001)(305945005)(72206003)(26826003)(8936002)(2201001)(32563001)(2101003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3158;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD008;1:JfffjBCndnZhAB8IWEZ7LSOXb0j2sVAJDTCgMXhy/Ueq51lSb58ZpA9jR2VchaqMcIcrhi7SxZJ5kCEWiFlXL6eQvHATBqmzh4R4Wg3/xOrB8y4K/oulXYq02/shLHTy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cf66800-a4b9-446f-caf9-08d58bd4b99f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR03MB3158;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3158;3:5DaWSpdip+EoQyuOhoUjLB/4Vn1Wh2ZyGlwZoRDwbuvNVxRmanBH/jIe8PtUqKdNjZRHWZ6VWWqpKlWGGeupH3QArgRdcNTMyrwXbFuQEhkhTSxHjm6n9GA3dlYXncgtEvToHs/AuouNcMNachq3NB7DOP53UG/91TrXxJQRQiMiZfbcBRd4PDrBKmWo6Nu/CTSz2dV4rNcK0uA6U9PSU54HUx4UqkU8oFrARUdZUKdgq/aAtFaX8Hu1cLfs4chCnek66l6e8z1LWsJyUFXL64JQsu7zxXd9xHByY1McPb0p5f+6laaPblBiir6br/Obgu5dHDP5zkI86HlOElpo3Ksr34kUzhTI0vTgMshELVY=;25:0IhxpfmL4GwLofQZqZlQ/rgl5GnHQzO2y0YZuuZPQ2qtfEEf97pZQ5JQaq8eM2Y/ljtVa+FO7pmXhWb/Z/evX79kJXaqCHLx7tVXXxtXXL9FTul39VZraE+j0MgMCstTH8WA7ASBPrKKrzn1EQ3YPtA20W5hBkPRLNv4yHb03OXq6UtVveuhoVwxFA+aC0M84nippdr49mlGqPlmaBR3fRD/LYLKE36bddpJty5qas/HPmDvBn90Fb9urxTqVmxLpJCiv3lC09FdpqTN6F0JHOuqxAKPNqtiLDmFi2CxVmDRSh4Un13Wh56KS7eoqv8HwaxHZHleRgy83Y5wD9bB5g==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3158:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3158;31:VpI81en+cAs4o5sL3KTK4nDH6lkeH451e0TFncuWW3xDQ4mnpikDh5HAeogYJzC4UwbOCYsrdXLIDJEFBTqzBqw2AnwhFyZyQIAZLSdLvDcWBj7EGavlkpTFOJSrjFpc49QZIZWFwbSYQ2KGaTvqHLBGa8plNjXPao5q7/MecXpVYx4IxHI1f2BmL5WT9Qh5/d6BBYql6jS2PEau5vfNPOPWqOnJ7QxSFevufb/QBwA=;4:PpHLW4FuaJGYQUi9NzaItSVu9WoTdnEHaRjUCZAqwEwoUJ/qnru/0Vi1gmf2PBFrPfK9gkyoAYD6co06Nn/PRHPLrx3XoUju4ml8QVzh12wRV93appnP3+batgfS5EFRA/XGRG9/+qqfsey/La1IZ1ZTPFbDW5nuCShZUpxEd1r7WrTOSc/ZEcnt5D2i8o00X7GhU/ZRI8cCjGCwU104a3kMggTk0rSs0wfC+MrLS3f+ZDvuVrMsNCzWYZj/sCDnsWMLfuoDTqZFQgTdNa9Q9eKFcSWhCY2VJDGpdWUGmXzxEQw1crLhPrWygxP64dDn5AK/TgMqZdjw7GjCFuj1F5Xgf++nqFxHC7pePzDtxOY=
X-Microsoft-Antispam-PRVS: <CY4PR03MB31587B46C3F8A04A29F20200F5D60@CY4PR03MB3158.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501295)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123559100)(20161123563025)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123565025)(201708071742011);SRVR:CY4PR03MB3158;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR03MB3158;
X-Forefront-PRVS: 06141B80DC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3158;23:l4/IJSP8rHlGWedOpfcLXXIV0MkwDRUZhRSkhY18c?=
 =?us-ascii?Q?N3eRWERQ1ZJGdzxH0GzacsrWV21QV/XI63zujSa2EBe/8B8F43xfNc5u0YGK?=
 =?us-ascii?Q?5Oi8FmjZRQMK3d3zZG0NlbKy+glKl/MB5Pl5/4y+mPl2v06nQXAD9UwXxd6e?=
 =?us-ascii?Q?bHngGBjd0DfLv/JssmVBqpD5s1Sg/x0Fj+ANeZRKTLY5keZa1K0SC0BZ+kl4?=
 =?us-ascii?Q?dpAVf6xwN5alHPb9Sd/lc8BnWHjqQ0CjW/bS3GRjHpGUOC/bmwqSkEEzMAkC?=
 =?us-ascii?Q?oBpAdreZLtmf6kkqc2+5BA5lL0gwdP6POSom3yLUpOrQ8lAax5ZJIjmad8Lh?=
 =?us-ascii?Q?81kOXHqaHvawGp1KlQjj/+/CzqxQuUyYt4tCsRDr67HmopV+lrHjsA1MtlWb?=
 =?us-ascii?Q?pyXBSzA465MmNmTOthUOVUpLlCuZYv5oN7ySRlZBWThSwGogbC3OuFmH6+uN?=
 =?us-ascii?Q?L5WN0Vg5hJZnIgGeptvlHZAuMlr699Okjs6YW1tdCk8LHPj0MafCZv5/cq8K?=
 =?us-ascii?Q?3IDrPA5CmRTZ94UzMASM93OINGK8GE9g/hNHOvCsm75rhpBo2xiZ6AxfP3Ul?=
 =?us-ascii?Q?XZSMo8N+7zGg9E8Xdbop0NRX1brfJODQbwtBURLY2ZRwn9Twfu91UuHNWJky?=
 =?us-ascii?Q?htxqzz0T1qAUBER50uwJDylpSD3ecMWakT6FTU6zPSfQlQHg+DFxDYwezsOK?=
 =?us-ascii?Q?RQSFP+4buH+0R3KZ63be4zlvmP3hgoI44mqeoPblDplbyLQzV1HEWzFj1k+t?=
 =?us-ascii?Q?JJ67C79OnfpTt8ty5Bx6n9VGCND75biNmVMUoGARhG23mhJ8/LQfBum9q4KX?=
 =?us-ascii?Q?L9iT1fn4N98FoPEi+DF1OIBOi6EWuRNfiLBMrqXHkr3BWMiUsqt2vEX4+Edb?=
 =?us-ascii?Q?+2mCbuwj/buh+yonXhMXdrHvx1sR05ZYQpxkgrO5qIQYckLKttKglZ0XhlAx?=
 =?us-ascii?Q?cGgifGlX8o0PpZ6jvRHAkePTM2djoivignssVv8zj/pPPriFvUai7i4a6pyu?=
 =?us-ascii?Q?mcsa7P2Y+khOSCCo9nm9R6RifOEac6FNZUcj68E+c19e+3TwwcGS2hgHAZaH?=
 =?us-ascii?Q?FWnqSVgrSmovVyx6nUUDmquBqbapVNmOvLFymwcDeT/AqPTm+b+TJY+rUkvk?=
 =?us-ascii?Q?34t9z+Y9qViD67kuY3prhtj9sRfTD6lH5kVRi5RefKLSMGCpfmQmpMclbuDJ?=
 =?us-ascii?Q?XpzmQPLNfILlDwKOJbrjMkbPoi5jvIwZHFprss0L3fWe//t9agsQI3Ru0sQV?=
 =?us-ascii?Q?LGgZ3AOocQiDXi252BPzB6rv2zeTR9TCavQ9j5SWaIzNZqBiNQeGZJvyu5Cn?=
 =?us-ascii?Q?sa6iAcKxy6ehaBHqTWJzCgY4VL9PlInn4XCQ0+ITW+X?=
X-Microsoft-Antispam-Message-Info: IdgBrA2e7s3hw30CWLUnehdsr9VyxIGE/PHlMymAoux0Ivb4a5/a8uCWx+8rD+il8RyDL87PpDZ50i1LuM7CbZOIgUhgZSAL03c0aYsMlK6f3wW4sMFA6ydRcfkPh0UGpPx+N5L8zBODpvsRaCZv54chGMm2KQFFKKgGy3XRGPwbb9Fq87UvUdgx+LfBBKlx
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3158;6:Ylc0RiAfn3ePQ0Zgb3AERdBQsvTBtCSuRJQRO1ocLsC43p8vv6C2fL0khUnxqBNZWyTwLqEq0CVQ9NneTtWHgbHed5R/XtnLBUbtAw7Vk2w9Hx6iSU0Q+yF6CgrwUrdkzGjY37uoQoFrrYrJbXXgqmn68hPha22KkHERNjrK3D7fx9x9pjDc1edOHggbNJA0KOZKSEsWBBNOE31QRYFCd7XXWvgGe9IUJQaQrSWRW//D0hBEyR1W2aj9cER9uiqZCBLn48sdXXdILwv06EDQp9OsT6KJlJQ1PTjdOcqLP+rPKaBTgcCXqWYNdKWBnzDArUZwkobgy+zVKGWHFqU7V3hSqq0XT048KcaiWEK78Mc=;5:ojr0ztX1A4MWNLfSiPBtYl+brF2RGyISoci0el4zKLOhwCPouY7LMDj6JHttm1ZYUpQbHRoCk4vY6IIgJUUzxwKNtN7mepdSyD/z4nOF6+JG82OZ90td0N89iphbtoSK+sJ6/KAZdB0dx1JkOdOh0Dqn30uFVpTtNgaV8fO1qro=;24:Rt6qSWKEqdJ56bllp2AKIgSne4eV67jZQxg2t9eZXB//JinGh8XJZjuWaPoMPCmbZkkvToaIgd55pBLfES+ysE7yVAMwA2wG0uvmAKpTUEo=;7:1X99ILXy0img2jhJQ0u2Uvoq+WgXdWsnD4L/nyPnJMgkcWKVb3ylhOWEUBgDeXWIDS0luOKCnZIh8q0TWUEdYJCw+VeW6w4vHyNenRWYaqnlrpIQP1OAAQI2NrQAUiISxIqPITKVmFnvNY14kbpi1kjZrS1lDZa7YC7fJTwl2KIR9Lck4EoDuT9eGhlbFcC3vR4ljNJgMGrYYiprtK0/1IRkOfKW3y1BS9MIs9pXShXdoilr5F7DJ+JdNXdyASU2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2018 07:00:10.4973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf66800-a4b9-446f-caf9-08d58bd4b99f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update sw1a/vldo4's voltage range according to latest pfuze3000
datasheet from:

http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi  | 2 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts         | 6 +++---
 arch/arm/boot/dts/imx7s-warp.dts        | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 53b3eac..1de0a0f 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -142,7 +142,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ae45af1..3781cb8 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -87,7 +87,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
@@ -284,4 +284,4 @@
 			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
 		>;
 	};
-};
\ No newline at end of file
+};
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 2b05898..2802bcf 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -188,7 +188,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index a7a5dc7..ba60457 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -248,7 +248,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
@@ -324,8 +324,8 @@
 			};
 
 			vgen6_reg: vldo4 {
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 		};
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 9bdf121..0e0cbcf 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -129,7 +129,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
-- 
2.7.4
