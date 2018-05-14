Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeENINb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:13:31 -0400
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:26033
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752102AbeENINY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:13:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: imx: add cooling-cells for cpufreq cooling device
Date: Mon, 14 May 2018 16:09:19 +0800
Message-Id: <1526285359-17978-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY2PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:404:a::25) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:OpZv9trLrbKP/ZuJ0lc+oupr81hokszRLGRYBAo3lPgr9TlauGXZujH/7NoZOy6JSe7R0W03EG1nFYGexFz22gTzP87/cbYW0Rnl1R0Z173z15t2CeXLplfsCYAodOlMQfTKCMlr+S86Ga1AeBhuhUi3U+NHbD6x93ME/Gji9gdXVuRAoZmheNwAIBUOSZSRtqBeQ81jiL6/af/q9qqFyiJcRw9XmITzPSRxaLFxM5OiEHWni3D+g6xBPTQE993h;25:ZKBtxaMoUButLPWvq79WxyihInJNrZ1ktOOlOWt0dE0onkxpJARnktoG5DRdPM8cGoe+y6TRJQznNkcyxsH+DlJg6vhjUOGaIz3KairG3KGQv+qsju/o1WAB+KOYuCysMPa60FgnneHrB1+g4RSiAsKsHVVFmInn0cDPSp+wL/DdypMcf9NO3UTPGNYfI2QoB7d1y/53lO3ls0SIEObHFBKb1DNmgt+H+Ubhb2VlDJudv/KV5nZMzov3R8AEgdP1TcgLyt9m1nK/ZBF8noOjdpBukdpZVtjzvDePkyWj/Ek98D9HL3wKNO7UQKJh5JRMWuK1S6VkkPf/wDj4w/rnDA==;31:VaUXLKyTBbFYHWDdL2ZSrVUaiiWrZM1VooDz5UG9c2pVAKzKrVQ1fZ1FSXDj5Paj0HNER0Y9CE3pzpDAqI/JhDq+6WYQ9WkCzw7U/s9gtAzCKr87TcNz/nuRJbwCYICt9RAETs1oIjtkARcUJL2lUKXuzRqmM1VEDYRC2cwfGngvyX6vZH0Y5qR1fuiDOWXsPwfEZ2QclF6o1SFYz854ODUXP7cqYIxCIMm2x3W82tU=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:VOQ1PN3qDMeruTF4WS1qd7mzZBufkjO7lrEOkUhXx3/4sfCRYt3uvfvKNDK/gN+mVsGYNvQe9ek/2ATC4JADkiVmRS66pCHl+mqeOwUzW4pJQAMeBbXoQtLHYnuBap23+SA0DFbDkfCSilDtzlzzVs9BGD1LtxvugbhAyrIpgWxEhfxa2t7PuU2YGCXpS/oEaPeH9984OhrjHIbmDrAwQ8zpolB2U2+YVgOKO9mOQAEgqZD2o561KrQphr9wv4lXqOYpskVBE+HbcfEGFcsKDjnaNWAOuQCQzawb72FyTBp8y/q3xfGceINrQaZvgQt3pMKBPPsCiji3EP9LFz+Qxla/obA2dzdIc6zI8wFtQyaPypLJTxOMqTU5oCALrjmI8ewVcMOwvw2LWehOkNmvatEAuFVC1vGHqIfUTCYyETNFob1DzFkQ+AHBsxDPo/UPPLcmOEoJ/jTVuY1OIN2MdDaaGrPX/vHbioanN5HvgIHpvkM+PIdI73CwU52nOUwo;4:PLPrzy5tOZQXPkz96o1nj5gunCkpMF4G3ytbNZ35SOqjceO6qGO/qJKnlUhvF14wUdLbXqBNBzCNzQuJYjNi/inpy0aiXxAqfdKlieRDhH1Yx+GeCguYm379IVllEUKBUqDKhe8vPYC3c/RkQs+e2IycZgBDL1IBUkkdBpSUTZgkq6lhlaPAcJv8wQiWp/eVptYYAHeq/HKKyCtnvszubVepoRKJFYMyG2x/fHguemrYcIKTBAQOTjxe6o8acjcgxZN3FjzaQ4NNcarZKVrNHBH8BSk4K5hSULUeKsaLpesc8FcO++x+3LTjErbar15R
X-Microsoft-Antispam-PRVS: <HE1PR04MB1324AFE4CB3B183DDD3D9DD8F59C0@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(39380400002)(396003)(199004)(189003)(316002)(2906002)(52116002)(7416002)(51416003)(16586007)(5660300001)(25786009)(39060400002)(68736007)(6512007)(53936002)(4326008)(36756003)(97736004)(478600001)(6116002)(3846002)(106356001)(305945005)(105586002)(7736002)(386003)(6486002)(50226002)(47776003)(8936002)(66066001)(81156014)(81166006)(6506007)(8676002)(48376002)(11346002)(76176011)(446003)(50466002)(956004)(486006)(2616005)(26005)(476003)(16526019)(186003)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:2TsR2PML83zO5Yh9DpyTfo8L6wLsb+ronfCh1OpRi?=
 =?us-ascii?Q?rPObgaEGEdZl62c8hdyeNXHBqHxMNRRYVV8eUaQXzBnxnNwA/c7j+ur+76qh?=
 =?us-ascii?Q?aAmLRKJMWAGQqQTAc+ZuVBYbtFjwr46qSrByWX1rG4nyNgSYMoIR4n5jHw+w?=
 =?us-ascii?Q?qr8VVZE/O7igJSWO7U4UPv8WF/GJw4JTDGsx9SYtLFIBYQUQi56ei2j0q5wg?=
 =?us-ascii?Q?WDyYPzd9zM3NnR6/3F1xjCOGYrKyte9L7OVcRkurNBqCFmH+KLfA8mZL7w9C?=
 =?us-ascii?Q?8twKS2V7MDiw7g1jf4aHonZd+4opzuf2xcNHOMN6gK3bHiI3+lcZ4Vf5nSO/?=
 =?us-ascii?Q?vUhIUSj86AhLGEL0afsu4C6P6zKLDGtCACZ/jA6Hus4ukeZs3Dd51WbfXDaO?=
 =?us-ascii?Q?q/UyXsMXTB2nexgYVMttNkoh92iDIrFJXF3x05LRWQD/Nq8c+56Ldp+FE8/C?=
 =?us-ascii?Q?LA+MLvkqMVDvQVXITo0zLZI1GVi2h0kcCuxIy0XIif2O4CeRtlcdM9GFFDnL?=
 =?us-ascii?Q?ZD/lTeWJ7KcmXVVTMcoLnF3gtkUJnA5Rjm+8+m5RUCP1FsKl1aeuDb4jYQd8?=
 =?us-ascii?Q?kO2WkFiO3CRqdWws0QqF2zaCYLAFKEYBIsNttKHwTL6Hn0Sbx0PTtbwOOmVh?=
 =?us-ascii?Q?cLFboeTptJnGiSr/aFEI4y9rkoV89ZsAlQupgiVtmUAZcB7TRisOfzR2ZIVI?=
 =?us-ascii?Q?3NSKF4Xn2cdcDNEAW0fqXUIsSZHpIXKdaqA3ZfrPi0gGUaTHCOfipTS6EhMG?=
 =?us-ascii?Q?KS665wpTjeCTFBTqTCJ56RcibTh0C7i662SLnJZuZWoqu5bQy3bbr8omK2Zq?=
 =?us-ascii?Q?1h5m0rDCvEaonVenLchWZ0mvpXrFdd8UKyt+Yk/HtTrOS5O4OUdbrMBaEEQR?=
 =?us-ascii?Q?o5ZDQ+J/Ew5evkND6nNVx1JTHsdT81f6m33cYOg//baKFGf97rXopx8RMi03?=
 =?us-ascii?Q?PMWeDHVbJsIZhiA1ZMONNnhZfOF28KRLOnUtltX7krOOmTQ21oZ1khHM9ae0?=
 =?us-ascii?Q?Kk5i21HGWoGxw74333IMROAmfdVIPRFCd1ahmsok6L78+leOWORLyL77m1g/?=
 =?us-ascii?Q?E5p+SkHmPP1wxNgeYK6jltusHbfRZKn/MldHSeo0cqzFIt5fCWMkvg26g7KA?=
 =?us-ascii?Q?3oueEAocWm459lB2YmGBlROoRoP3DVwc3CZTAq+8/vsEmwwxFfeoZ1VVFoqk?=
 =?us-ascii?Q?SIxK6gBPKhdB8ZMC7+IDCusYfLXutzM2wdpB0njOs8L3dNla1LMiPC+Jw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Ikb1ehdRxUKHF3Xd8RLvlyPd1sfaKU1DCoEOE+TvE/YanDq4YOvAeMt0i0qlQX1uAajx0TVmLsOCVKbyS8J2Z+WdUHgbWYQyPslpxfX8JedkNF5I4UuP9d3zaxTIzTKpT+NMiC8uWRr+2DUi+Bq0450R1uAoOpoMka9Uhl5ngSIxIAdbWE8RIfUTgzXifzk9
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:55ilKeZBgyoF9rEz1Qku3WzKEN2xZKxyO21bdcpHG8Rs/SN2owQxJOrxEn9Fn6/I3XrRRoF8/qBzwxp2r8NEAyOIXVgB0qRWFcq6BNBmYaTkh2RNhilGhcGDIXpDq2SeoQ2Y3fO9Aus/m3L3oUdXOKG2jykHpEf9qVJ+XoatDRyNd/j+qKL0WthTSqNExaaMHtcp1z7SW+nGbWX0nQmRh8CsT3plQioApWJ4JJDy4Tu1VIMVfaZoNiHXVGLxds4s7F8jYFSckIbHstUTXMLoZH+qPLLCDLTWnxqaV9mQjQjH9AqbD2ZxlePIS5df9UTzGR0UoEAkRhFB5oF9sK7Md9MRN8JZvxFOY58P4x6RDSfF8jVXnSa+wMaHiuy78dw833LtxoB9hgdtLqjFe8E5ORR2b/SGWvG7Khs2YtCbnkqk5HD8xEQ8xDNqbMiMpw4mBlBDxpywFzTKfcp4wRlD1g==;5:VzYrrlsGXNwLBzGfkWe51FaGzylMd35IjSSSufJjBjjJdXJ4Edrmu3xKaElW/3oNr+AD1O/6P1hAl2VwhhyMXgAuSZsB6W/FD7xlffquSAA9AvNOH97iQ/FONFhfCkHNycl0pxN1unZ0hQ0l6KsOn5o+L4O+kaXzUpxjeR90ZFc=;24:YvcpZJyPJVO1/FAQkka/XQbwS3kBRjd4+ASqFyyqPj29xpPIMVwL5kJjC5pf019LnxshmEwE8tubG1O0DjT40Q38hzhnuAMuQpAS3/+aSdA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:9957LyvduqDEQdBh4EuY2oBWU8Ae57SIcA5cdGHjG6hnnM8sB4yMg06hSf9C+jjIAE+0RfoXGlBgcIumSwHEFxbuYkXUMC4dYZzvkoHviiR9KAR8i6TEpvB5+uIWZeyEQmmsuJmiQ0aUzTveg0Rwy2O9hQYjIZjcm3JW4Fylt1/Bm6HoWYDQfcllXM+iIiAYhgAxf67jzSymIfAVSxeb4pLhb9x8LXMGwOrcnJsKKgEtNEYQtjthbSQe31XxNMUB
X-MS-Office365-Filtering-Correlation-Id: 0def3ba2-79c5-43aa-e649-08d5b9728cce
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 08:13:12.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0def3ba2-79c5-43aa-e649-08d5b9728cce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #cooling-cells for i.MX6/7 SoCs for cpufreq
cooling device usage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 1 +
 arch/arm/boot/dts/imx6q.dtsi  | 1 +
 arch/arm/boot/dts/imx6sl.dtsi | 1 +
 arch/arm/boot/dts/imx6sx.dtsi | 1 +
 arch/arm/boot/dts/imx6ul.dtsi | 1 +
 arch/arm/boot/dts/imx7d.dtsi  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 558bce8..b830dfd 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -39,6 +39,7 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6QDL_CLK_ARM>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
 				 <&clks IMX6QDL_CLK_STEP>,
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ae7b3f1..ac9f5cb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -44,6 +44,7 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6QDL_CLK_ARM>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
 				 <&clks IMX6QDL_CLK_STEP>,
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ab6a7e2..d35d4e9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -65,6 +65,7 @@
 				396000          1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>,
 					<&clks IMX6SL_CLK_STEP>, <&clks IMX6SL_CLK_PLL1_SW>,
 					<&clks IMX6SL_CLK_PLL1_SYS>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205..966e39a 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -83,6 +83,7 @@
 				198000	    1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6SX_CLK_ARM>,
 				 <&clks IMX6SX_CLK_PLL2_PFD2>,
 				 <&clks IMX6SX_CLK_STEP>,
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972..14b6ac7 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -66,6 +66,7 @@
 			device_type = "cpu";
 			reg = <0>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			operating-points = <
 				/* kHz	uV */
 				696000	1275000
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 200714e..49913717 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -53,6 +53,7 @@
 				792000	975000
 			>;
 			clock-frequency = <996000000>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
-- 
2.7.4
