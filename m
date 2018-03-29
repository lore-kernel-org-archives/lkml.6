Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeC2Dzt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 23:55:49 -0400
Received: from mail-dm3nam03on0068.outbound.protection.outlook.com ([104.47.41.68]:11670
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbeC2Dzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 23:55:47 -0400
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 5/5] powerpc:dts:pm: add power management node
Date: Thu, 29 Mar 2018 09:31:43 +0800
Message-ID: <20180329013143.22527-5-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180329013143.22527-1-ran.wang_1@nxp.com>
References: <20180329013143.22527-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131667693453107189;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(39860400002)(346002)(39380400002)(376002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(336012)(54906003)(2616005)(2906002)(97736004)(59450400001)(476003)(11346002)(36756003)(47776003)(48376002)(6636002)(508600001)(26826003)(86362001)(76176011)(110136005)(6666003)(51416003)(305945005)(53936002)(446003)(5660300001)(356003)(316002)(106466001)(68736007)(50466002)(1076002)(16586007)(8936002)(104016004)(77096007)(105606002)(81166006)(81156014)(486005)(26005)(6346003)(4326008)(126002)(486005)(8676002)(50226002)(450100002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3109;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD006;1:yUbN9WyhECraRernLstqLhsf3UWSiCo/SwnsMHmH/hsBbTF1t06/5uakTuj/B5WYMnlMpc08ovzD10rESKcm3WxOuYFBFTkhSQnknLulANeLByKpuT8SzJcBieUs0m0H
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb3378d6-3e6d-4787-7e96-08d59528f31f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR03MB3109;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;3:gp9djuysoiLv1OFqJ4eZ2t2OEb7An74X0n/u/Hp6MKPq1yYj7CgNiM664Rp30HHtyuvHdqxUIqXyYdFO3l56t+FMbPXMOA4jqN/O7BVjQZ5gRdASxlihgrW4mxdHfzergK3cJZeeCsxYpuI9lG/9/T72AQfhSqx98dOvBzZYK3qPlK4wmoQ2IdJdL89whteDlXLtlX+xSb5b326U9H/SqBPYJJPnbA9yDNuzU+zWtyA+VsAVTeAeFpaBqKRha7WSVh8MMPllKT2GbYgmfrXcf4GAdz9nVCgKPQVZNbOSXC3tpHK1usOVjjPM6bROTrR2iBiAnAKFtft+Gfv79faW8yw4JAvPQNd/UMrd6YGbZKA=;25:kjAGu6plpcMrsah3esuIQWwaxTGkXIMizDL51VC0A0X71l2LoVWFh5cMg4mzBuhxb+y5xSbY3Eb4CtPj2jV2qCH38T6xrQFccR4G8VeOTysKOpwFeySUOZm7W7ys0xwxdHjP5y8WKso5ppoYceSLO2ufPPjIlXIF3oc1pYtkxRAL+t6Cu4IFdJHadPj6ioIk+0MyZG7zwulHFNyJJ1hN9qVW57bGcC4V3lEb78ejB/w6CHXui4wADYdfDPy0e2FWSFeuj8DFPly7k0qDElPN5EQtpg0YyU2NJJabdj7cIIOKmlWPD98f1Rhv1L9Iwr/dfvjDt77lATTM1R+Anr1g+A==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3109:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;31:w2Xzqlbo1oxsT+R+/ZbBKEmL92zrcyycaf6qRHus4JjFUfh1O9kYJ56YDRscz7ZeG+xsfdW0cAimKArVc5jplchkWhhp5O5amYFJwCorowa2AbVRnR6fMALnc301TrXlve97LpNDWAT2P8twW1G0Tj4QWqnCN1ZewfK7vngnAlPFiITY58zF8A3Xg39teYUnWX5g/4uMrqbur0dZvdQM48ZnUrOc6xXkbaJCqwqoXZk=;4:oylYv64gUIK3lXI8H3W1Doh3B5cWHz5SeDOeYEjPL9G5qo2OZYRh7uM7kx7KC+7k3yrdijrUIT4HELrDO5eSwYNMd7o1ISEx+512TQtuTIpR6rHgk0YrvZBAWCA7ChRVVOlXFqDi4WHh29vu1vzXM+9Idbkzl80aAyZut6HvsOJIrCsOomArvw7jFWUlcXQzrLhgEt6CKy2HE8V6qCRc7SfvotANar+PCG/RPSpqJ3NcYWhzihk6FQT9CI7eufHRaNye/gfr+Vy9X32dyNaOo9GGxCLWNueQyxZbP9WQN0U/1hISD7xybdIcdRta8y1KgJPNNplhJrVo3C5uo+QTCP61OFgIWcToNoB9a/z1zzc=
X-Microsoft-Antispam-PRVS: <CY4PR03MB3109EB55B6F4F4CE2A408342F1A20@CY4PR03MB3109.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123556025)(20161123561025)(20161123559100)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123565025)(20161123563025)(201708071742011);SRVR:CY4PR03MB3109;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR03MB3109;
X-Forefront-PRVS: 0626C21B10
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3109;23:lGlcynNG1JS/Sxknq1nSw86GehoxWza/a1yGZ2YTs?=
 =?us-ascii?Q?TLoE7INTa69p/XmGLKHxM6JWEPM3doKWpUZlT8a5sAIjMmLbVt1DLOYj9gXH?=
 =?us-ascii?Q?UKZSzF5IBpBIUwuXO3HRllIpX7MWUuNEthr0sWQnVgc7QrCZgvFphr7FRN+O?=
 =?us-ascii?Q?MI4478+jXlQtwWn9DMPacLGIcfjYL5ynE2SxQLhck7YvFlDJxqZS/GGd6Kd9?=
 =?us-ascii?Q?kyDYSPcDldn99Y/rA0+2XcloIgv7lIszB1xlZvrPjyo9JpfDP7h85CaLUU0D?=
 =?us-ascii?Q?JIqZO4ssPNCTo1a7BwMfk2UjoGWOGdWdIJdchPAFknBtf7JcpghFaaULepp+?=
 =?us-ascii?Q?YA1KAsez1WchO3kDlV1zlOxQGDQ/OXHwikoqIm2RGq8SYww/fvW74ILpS2FR?=
 =?us-ascii?Q?CDuWQnhcFd6y4crl63ObB0R2fTHJZID8NlHS77pOuAW6aixyk5KZGTy21ldv?=
 =?us-ascii?Q?aPw3i5zeTUi2iua4iulxwlaEX6RU0Ab5GHygrKdruecTjkgnfPPvtKArXPBo?=
 =?us-ascii?Q?TiZRNnH0Q4QLmzpOowvBVcyBBDsL1tcsjC1CgiL5+qGFzrF0k05FvQ97xGI4?=
 =?us-ascii?Q?W+MrKnoOJhxrtaSwoUK7C4t/0aPasQGWg6rZ13famim88ZpBoosI3LS9bOiC?=
 =?us-ascii?Q?ZgiNiaTIWO1edITFsYgH9fNEhAfMLG1pLW4Y/7P/y6ApxegkIAgr3a/uhmnM?=
 =?us-ascii?Q?HXKFVNtd9YxGuKhArbxw1CSuSArLae9ekFzfKkF1KzV3m/CDUD214G3sX5L0?=
 =?us-ascii?Q?C7YMd6eizzlAX0Bm9fccYIVRhzHBglDKgsE+V37zYUQ8Q5ueZxM5ClrEF2Di?=
 =?us-ascii?Q?z98hulhyvDDfYq1ZhBZ/pjLNfuqktz40cSk3RnsYYirSqoPTb7YXOo9qRFQd?=
 =?us-ascii?Q?cPnRuv4OtojQvTuWWtoieC1b4TxdeangPavsR3gabm5VwClMlCe4lORHbxGa?=
 =?us-ascii?Q?P2BG7OpLFCftBjc6sfzKt6+hLx8W30nm6EhP7HViDM57+Dcnybckk8PhLpPG?=
 =?us-ascii?Q?yCE8Wt+UXsMBuxR849+CljDPXkripfloCkBthIV3B0Hu6A01xYEEe/CVVKEK?=
 =?us-ascii?Q?DRA0Ntl0kgKgwWewO9O+WGXg6bsMhZSVuZz8wIyBqv4+MTHk71yH/qqzw6Yb?=
 =?us-ascii?Q?0Qw8yXIp90tQwy/ZkPwo8/3LHywTUpBbNwqBwXV4UGqXHLLFinFLZBzAcriR?=
 =?us-ascii?Q?wZQK1+zdchlvPeRukDeilPRviITeeDU0vqDB7DH0OSUMYW0g+r5UJomUUSCu?=
 =?us-ascii?Q?B/pdLAK/pVcz5bV4KVkBvwNVyajheijgupbCoyPsVeRfw2DrMEAnpWTy8yvG?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: RgiQwrC2wdVGkG0ZpzRNX5AQapWvF1pVFPIAgClHCzWIMWAgpmrpMWRHF9/xgQGlW5JHr1OfSVlaa7kvafVkfb/+L2dnl7wVrVTPf7OR7eGaaQtc/b+ybPaIjYKxk2lvk1IOFdoJKRfly4sQpmWhnpZW2bgpCa/3LIlqcPWfWfsVCMmpR1XrSlDbUV5TTd9F
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;6:ELns9EdHIZetAFkaYcWJIhf3IDnqiuJf7c4ylAlIhQ2qeOhJfX4EvtisbbpPbrlPDEAricmUOiRCLfWx+M/L/JskZ9ki9eFxqgy6qZNLmGpGYWaR8euyHO5+5EWMM+0Ic5pBcdrinmDFqimYACC3fiojqu5+ZEo5rDP55jp5xJTjIZK+/LZK2i7QoZziwj0vyz5MMLqBrnN0EafCMr90sn2YEbU+SsTYZaJVkNk6ZRjDHvxeMhdA++eStQ54GVSAoXOcNmDJEKwBlbBSCDbQ50ro3pNsNlEFub9Jf0VCxWo9cZy9ni1la5+X7TdnrEThTRxRU0z6vH8XEiENMHDhhPB+Mx+VRHbWkIocse5rMyKWR4zXVebSLTcPLy+rkEt9+mReL4mMLE6fsttSdjZaE56pVSZbNdhKU5ZPkhfscbX1BU9o1001MYsSC0ZB6nnVeRt9rZ/CHXG0soXWaTWKeA==;5:I/RFKcs2TtOJJ9ZofVzqpAK5Ou72IRZTGlSpXfp427Q/eO7QN2f3u7bGhnTx8F6+RP4p8fUPAmhj2ImgB6N3jfPWNiMR9MmxG9Rl3SPvhFc9P1F5z1hMT38Kni85CjbaTu3APCmMgPG89tcMmdgHGnkVzoYZMSGPy+YabSzmWss=;24:O3RlE5qn1+o1ijV9heenF1OMcx8/GlFfbyB/G/P3zj3w1oqK1PSxZXLWp3nbrNR4Qu1Ho1t2xP+wYeaVjKyvr1E3qLkk5OAYdEL9ce0JyCA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;7:J7zcZRQUoJAg/ouLNHRajY6HX10SbIoKpSXTGaAIjdwBuhM+OMcU5RL43iYhJZGHSwTXXhnwfynqBcZcGHIN9kRTgiQ2Kybp5xC6FL727o3GbBuyl/iZbUA8ENfbBBpgpYTw3XDthfnGmJLFOm5I/sXRPQAifHTE4wPrh+p1fIkLZBIMgxk6HbuoeBearkpwNnhEYWYtpn/sWuwQMd6T/b+Ik2x2IYp+WJlYAKPgMUe8HslqEMf5FdNJe2zCF5Ni
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 03:55:44.3903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3378d6-3e6d-4787-7e96-08d59528f31f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Power Management feature on device tree, including MPC8536,
MPC8544, MPC8548, MPC8572, P1010, P1020, P1021, P1022, P2020, P2041,
P3041, T104X, T1024.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |   14 ++++++-
 arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi |    2 +
 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi |    2 +
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi |    2 +
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    8 ++++
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   |    5 +++
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi   |    5 +++
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    9 +++--
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |   14 +++++++
 arch/powerpc/boot/dts/fsl/pq3-power.dtsi      |   48 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1024rdb.dts        |    2 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts        |    2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts        |    2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts     |    2 +-
 14 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-power.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
index 4193570..fba40a1 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -199,6 +199,10 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-etsec1-0.dtsi"
+	enet0: ethernet@24000 {
+		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec1_clk>;
+	};
 /include/ "pq3-etsec1-timer-0.dtsi"
 
 	usb@22000 {
@@ -222,9 +226,10 @@
 	};
 
 /include/ "pq3-etsec1-2.dtsi"
-
-	ethernet@26000 {
+	enet2: ethernet@26000 {
 		cell-index = <1>;
+		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec3_clk>;
 	};
 
 	usb@2b000 {
@@ -249,4 +254,9 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
+	power@e0070 {
+		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi
index b68eb11..ea7416a 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8544si-post.dtsi
@@ -188,4 +188,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
index 579d76c..dddb737 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi
@@ -156,4 +156,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
index 49294cf..40a6cff 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
@@ -193,4 +193,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 1b4aafc..47b62a8 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -173,6 +173,8 @@
 
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: ethernet@b0000 {
+		fsl,pmc-handle = <&etsec1_clk>;
+
 		queue-group@b0000 {
 			fsl,rx-bit-map = <0xff>;
 			fsl,tx-bit-map = <0xff>;
@@ -181,6 +183,8 @@
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: ethernet@b1000 {
+		fsl,pmc-handle = <&etsec2_clk>;
+
 		queue-group@b1000 {
 			fsl,rx-bit-map = <0xff>;
 			fsl,tx-bit-map = <0xff>;
@@ -189,6 +193,8 @@
 
 /include/ "pq3-etsec2-2.dtsi"
 	enet2: ethernet@b2000 {
+		fsl,pmc-handle = <&etsec3_clk>;
+
 		queue-group@b2000 {
 			fsl,rx-bit-map = <0xff>;
 			fsl,tx-bit-map = <0xff>;
@@ -201,4 +207,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
index 642dc3a..cc4c746 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
@@ -163,14 +163,17 @@
 
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: enet0_grp2: ethernet@b0000 {
+		fsl,pmc-handle = <&etsec1_clk>;
 	};
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: enet1_grp2: ethernet@b1000 {
+		fsl,pmc-handle = <&etsec2_clk>;
 	};
 
 /include/ "pq3-etsec2-2.dtsi"
 	enet2: enet2_grp2: ethernet@b2000 {
+		fsl,pmc-handle = <&etsec3_clk>;
 	};
 
 	global-utilities@e0000 {
@@ -178,6 +181,8 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
 
 /include/ "pq3-etsec2-grp2-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
index 407cb5f..378195d 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -159,14 +159,17 @@
 
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: enet0_grp2: ethernet@b0000 {
+		fsl,pmc-handle = <&etsec1_clk>;
 	};
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: enet1_grp2: ethernet@b1000 {
+		fsl,pmc-handle = <&etsec2_clk>;
 	};
 
 /include/ "pq3-etsec2-2.dtsi"
 	enet2: enet2_grp2: ethernet@b2000 {
+		fsl,pmc-handle = <&etsec3_clk>;
 	};
 
 	global-utilities@e0000 {
@@ -174,6 +177,8 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
 
 &qe {
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 5f51b7b..6ac21e8 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -225,11 +225,13 @@
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: enet0_grp2: ethernet@b0000 {
 		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec1_clk>;
 	};
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: enet1_grp2: ethernet@b1000 {
 		fsl,wake-on-filer;
+		fsl,pmc-handle = <&etsec2_clk>;
 	};
 
 	global-utilities@e0000 {
@@ -238,9 +240,10 @@
 		fsl,has-rstcr;
 	};
 
-	power@e0070{
-		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
-		reg = <0xe0070 0x20>;
+/include/ "pq3-power.dtsi"
+	power@e0070 {
+		compatible = "fsl,p1022-pmc", "fsl,mpc8536-pmc",
+				"fsl,mpc8548-pmc";
 	};
 
 };
diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index 884e01b..2c4787c 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -175,6 +175,10 @@
 		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
 	};
 /include/ "pq3-etsec1-0.dtsi"
+	enet0: ethernet@24000 {
+		fsl,pmc-handle = <&etsec1_clk>;
+
+	};
 /include/ "pq3-etsec1-timer-0.dtsi"
 
 	ptp_clock@24e00 {
@@ -183,7 +187,15 @@
 
 
 /include/ "pq3-etsec1-1.dtsi"
+	enet1: ethernet@25000 {
+		fsl,pmc-handle = <&etsec2_clk>;
+	};
+
 /include/ "pq3-etsec1-2.dtsi"
+	enet2: ethernet@26000 {
+		fsl,pmc-handle = <&etsec3_clk>;
+	};
+
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
 		compatible = "fsl,p2020-esdhc", "fsl,esdhc";
@@ -198,4 +210,6 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+/include/ "pq3-power.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/pq3-power.dtsi b/arch/powerpc/boot/dts/fsl/pq3-power.dtsi
new file mode 100644
index 0000000..5a760b3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-power.dtsi
@@ -0,0 +1,48 @@
+/*
+ * PQ3 Power Management device tree stub
+ *
+ * Copyright 2012-2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+power@e0070 {
+	compatible = "fsl,mpc8548-pmc";
+	reg = <0xe0070 0x20>;
+
+	etsec1_clk: soc-clk@24 {
+		fsl,pmcdr-mask = <0x00000080>;
+	};
+	etsec2_clk: soc-clk@25 {
+		fsl,pmcdr-mask = <0x00000040>;
+	};
+	etsec3_clk: soc-clk@26 {
+		fsl,pmcdr-mask = <0x00000020>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index 73a6453..95fc694 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -91,7 +91,7 @@
 		board-control@2,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "fsl,t1024-cpld";
+			compatible = "fsl,t1024-cpld", "fsl,deepsleep-cpld";
 			reg = <3 0 0x300>;
 			ranges = <0 3 0 0x300>;
 			bank-width = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index 65ff34c..825665c 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -70,7 +70,7 @@
 
 	ifc: localbus@ffe124000 {
 		cpld@3,0 {
-			compatible = "fsl,t1040rdb-cpld";
+			compatible = "fsl,t104xrdb-cpld", "fsl,deepsleep-cpld";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t1042rdb.dts b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
index 3ebb712..0997643 100644
--- a/arch/powerpc/boot/dts/fsl/t1042rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb.dts
@@ -68,7 +68,7 @@
 
 	ifc: localbus@ffe124000 {
 		cpld@3,0 {
-			compatible = "fsl,t1042rdb-cpld";
+			compatible = "fsl,t104xrdb-cpld", "fsl,deepsleep-cpld";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
index 8ec3ff4..b10cab1 100644
--- a/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
+++ b/arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts
@@ -41,7 +41,7 @@
 
 	ifc: localbus@ffe124000 {
 		cpld@3,0 {
-			compatible = "fsl,t1042rdb_pi-cpld";
+			compatible = "fsl,t104xrdb-cpld", "fsl,deepsleep-cpld";
 		};
 	};
 
-- 
1.7.1
