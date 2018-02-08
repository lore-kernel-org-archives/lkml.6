Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeBHJcu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:32:50 -0500
Received: from mail-by2nam01on0058.outbound.protection.outlook.com ([104.47.34.58]:56950
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbeBHJcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:32:42 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC: Leo Li <leoyang.li@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 3/3] arm64: dts: update the cpu idle node
Date: Thu, 8 Feb 2018 15:54:36 +0800
Message-ID: <20180208075436.38443-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180208075436.38443-1-ran.wang_1@nxp.com>
References: <20180208075436.38443-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131625559601365055;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(39860400002)(376002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(50466002)(26826003)(1076002)(498600001)(316002)(68736007)(16586007)(110136005)(53936002)(54906003)(36756003)(575784001)(48376002)(86362001)(51416003)(2906002)(85426001)(2950100002)(6666003)(15650500001)(47776003)(50226002)(106466001)(336011)(356003)(97736004)(104016004)(105606002)(450100002)(305945005)(5660300001)(59450400001)(26005)(77096007)(8936002)(4326008)(8676002)(76176011)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1414;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD017;1:l3iJNDDOlsZinqbbW/UvdpDTnZuOYeid89aITyPzPxcLT8rjZ8GVpNFr0aSDh6HGUIvKJDSdPJUC9Yt/lh5UZBzi7g6ezFR1Psx62VY3RB3CTsMZSGd9piprZOlJZdMy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2f4a6e7-8f70-4795-fd7d-08d56ed6e5d8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN3PR03MB1414;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1414;3:ts3Bvdm01fRrkbRxQRegXAl7Gn2A+ia2RBvqTZUgSRGRaAQw25BLt5uAfaI5FnS/85V9Kg32aApc7ZsvbjrlffloT9I8gPEOARmjBQWIiHmoaZsDfQ8lSk53Cf+DMK3OyCcpDgXOaC+8TDWOZn+1Lb9GC35eiVcfJTGFpcIg7lo/He4APHsMjnCfOGV8gRt9GhcCc6/rtPQDghCIozOVCa1aI2PqksXjT02Lu+wgk5Ye09ttBg6MnpHvba1fmqJzAN3x8V8FNZRrtdZgjyDfZtWVLjNk30EMAGzBCufqrXiklJk9Tk23EvqBnt548CFGMu21G0ntX3qo49et+Q2KlkZDfvH7ObgNDNpORx8nuXM=;25:x/SC89yQWoddV0dW2Ot3+Tu85Izq1KtcIFsMn7m/q+TYBDXW7G4V7W6MHwKGDK5varSJnoy2poWpSXbjA1neHbiYxLWB1I/3GKEokkjjOd1M4KWvq6+xSdArk4bUcVKJZSK9qPKqFoPkd9pD9J9oCU8tnM6I4YrxNTbCGhddGr6mqpw8ZdXj0XPlzHVXABx6vDvGBdA2wTpXISpvW2BGfRWSPEYkDDKfjGvIRLLjJFoLeobrv5Pj8ZMxjKay9U871owBw+7R76WbH+WhHOvLYLLckh16YnLVtjiHLV545zrIn+2ShmGeFzjh4BzmqdJvf9+igkE5QlCAxBPP2gD37w==
X-MS-TrafficTypeDiagnostic: BN3PR03MB1414:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1414;31:jOZ02cqxwGf023ACR1tutjxDy1Uk0pQFlEY/yNZW5+X8qbCXESkho4xadxwodho3jwVjqcZQFBd41CxEztpKnWrbxnqIuxDq/8oE1Sw+im+rHYXyUjoVWic5EIER+AiVnqNoHu3eecnGlDllg9VmHiMgBBQc51La5rIptmM649FMqIpp+YqWHO3CC3e4yQHeOluh4fz79JdWGRJpxCXH4vMWtHLNWhhd4r4kfVuqWdk=;4:7RQx/AqKbNHQT//VMlN7SO0Bax5iXKfFvGVbI8IdZNzJpLn25HdcZlRvJK/S8mRafldTKaQd/J+/AnM3ZexNTUDwAVk5cU17pYvUzCqOg/jgAceleRKgnlSQHHcfRFdbQ3qBVGz0QABh9gPyskA2I/C19SGQtjSs2MFtfXQzihCaA99nsQbFFwJMrX5Gp7OfYCwF7pUk3bmMFR4lWCOEBxML3Ru+c8SMK4ndfML7c4FWNVH5V0vqL92AjY1x8gSarbSsIcrvKR9YggZoA/00fp3doxuPGCG/204MTCPzd3K6/R+/W9r03MIFntnV0gjC
X-Microsoft-Antispam-PRVS: <BN3PR03MB1414606973DBDBB5F9D8F8F8F1F30@BN3PR03MB1414.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(2400082)(944501161)(6055026)(6096035)(20161123556025)(20161123563025)(20161123561025)(20161123559100)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BN3PR03MB1414;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR03MB1414;
X-Forefront-PRVS: 0577AD41D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1414;23:F9WlR5tgnGmkum51DDAuOn4BKQthqmsebqA789Z9/?=
 =?us-ascii?Q?bCTpP8jbY+zekx80mTcMlkdHT75PYdLbFLnxspUZIwHocedBljSeql16YTKY?=
 =?us-ascii?Q?LMaHkpagsX8cATbnQkJOSZ9TllXXHtR7uhUq1P9aK8IOI7llwAsBgaf74T6v?=
 =?us-ascii?Q?/YHdL4tibwkluSebhoC6OZDFxxoLnTxE8lHY5AGirCP071FB+ZVv8uCqbwjG?=
 =?us-ascii?Q?C2MgknURRod5X0mik2grEefGjBuUTL4xC7bi8oBtWzrgQgJ+zNfQACKyzVRk?=
 =?us-ascii?Q?+BOUrd1IAKbdxs3wKeXuirI2YzCyPcmVcRnXpt+drbaMnvsH7npwRgwPfojH?=
 =?us-ascii?Q?1qLRBQCyxTUQ0W4KhWTGe+vkCKdn7Vh6WNz2mZop+4MxIaMgIEv3ezEVzzQ1?=
 =?us-ascii?Q?78ogQs4Fo1fDmeWeUULGe5gpXcsct2g+1lwUdzZLMpudpuzLburuWKcVxoNB?=
 =?us-ascii?Q?zPMuq/rpxNEr9rsXLOgkjPhWEzFJIRp83hG5IVE4iNFEkP0k96q5tYXEdyMe?=
 =?us-ascii?Q?TOYmtaZ9aw5AwU6gcprfkI8lD4AI8HtZVPtIZoaUVKQAus0be9UAeMfA77+9?=
 =?us-ascii?Q?rVQbdmykqucgQTOg8giHaTHFQ/WRQmMxhgOtUFZI83+aXD1CnDF210Du/S5l?=
 =?us-ascii?Q?eH6VJcI1rPWB6Ye8NP8ZgQ1W65EJ6NcMiGgq+rGUhWIDiO7yj2UqoB8L1L65?=
 =?us-ascii?Q?brdVsPOJih+adcobNbUWwpKh4eLZE/L9FS4hAkbeUGP/AP0HpKCZi2aIz9CZ?=
 =?us-ascii?Q?NFSuPUR/cCMV/oUHBcBUJH7wVEwKJeMMj5ZYYALeRmFbYjZncL5wpjl4vYWl?=
 =?us-ascii?Q?iLdfa2TS6idG2vNF71wXFt04sKPGA5Ibfts0Zf9iICfXnBxeGWJAwaTjeFMW?=
 =?us-ascii?Q?vCfoMmpyWR+MNSNBxMjCNLP6Z3IuLNs6P07sndn0Ip+sK9B1OQsaV1dLg77F?=
 =?us-ascii?Q?w1ZOWv37qeHZShSv1rL3xIzqWPvj70KD6X4a5mHUP9vb8e2gAFtFWAE11LAL?=
 =?us-ascii?Q?UH9N29wHD+BcUBZHJAtoF+A/kv+7IDjwefH1WO+xDGS5uAzpmz11EI/QvJIv?=
 =?us-ascii?Q?9ztw38RGDHaciB+aoyixEVLucTQf+/TjAcyqYifuQvVgFNg8cyq/cGoG9/aB?=
 =?us-ascii?Q?ngab3TcbyIH0bGCWMnHk8Wo8GQZX5HEqtXxwNUFjPayOMhI+don9sG1nOpAz?=
 =?us-ascii?Q?SbsDcJK4VYHtAn/OHitL7xg6BXrynIzSb9J?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1414;6:MnjjwO7kT36OoPVBI1shSFz25vEkcVoR1hx3PGLI5jCDjWv9ZdaJQo+3PYi/jiVButQV2WkQ9zMiFMmR5CgoyVJX1zyizzgJ0N1eBeX9BaJtOIsT7PpobgN4B8H9trIfKJOUcIEHjwvYj+nlk81vcAGEoJw1axuMo1A4nD8aErk+q1uk3fGMahxfimgf4KTo82RF73scQC0j9335+Ak3GUCHpXQv3TZMn2qc/xeDWbCuMaAkwi9QB8nK3wWuVn/YmFq2+0rD8Mp4KDYp9BDJXnXRY0TStZeilvoIGge7Iruq8ghNn2Uj0nsDgEGwyuO4vVQadrheNmbQbGHbZl/W60L+3k7jyaxFA+AX+DOWzYA=;5:MAcse9q5FD+Zb6nk9CRfbtMCPlOsAqU7yGydx5zreLpmGrZZ8msqYpRfsIGG+QEJ3DX/ug4Nyro19sgB4iGfQE/OXuWiFhkKmPjsbrA9epA5tPQBQF1H0e6WXi8xw+MHtMpsql16h+xkfaNsdiId4/eAREEufzNyh/Td9I2ArUg=;24:QvMUP8y8HnE0xkxLm7dmi+opeYgc0Xwh8/x0+YbxHolYGjC1AA9lxu0G/7+QGE6fZC2A/aAEsJz66PdQf3FXd2sH1hhIyAJJp6R88MJ4Nxk=;7:8wA1mCu036QkM0DIwpgceXNhG91NWl12NiJtTNgYEn51gRMQPOGEYHeqCZHK/lUY0VlhZ3asFVXzGGPlH9uLP6Y4uFCa6m/KP1UIzBG3BiVm8dYOOEAeUPgQaVrdNoAZIlHsK5wKfxVN/BB9Fh/HPqNaKaPlqpYuAf1lYXdAk8teqq4D7TxW+hrNqBaS9hktaJt2RNZmNkam5N9f8xusbAGztBHPmf7Q64O91EKnCZ+HdC9cm+6qWDm9sW/HrXy5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 09:32:39.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f4a6e7-8f70-4795-fd7d-08d56ed6e5d8
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1414
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

According to PSCI standard v0.2, for CPU_SUSPEND call, which is
used by cpu idle framework, bit[16] of state parameter must be 0.
So update bit[16] of property 'arm,psci-suspend-param', which is
used as state parameter, to 0.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 15421ef..3463b09 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -84,7 +84,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 18828b9..82ca0d9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -126,7 +126,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 06b5e12..2c56f9d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -122,7 +122,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8ff2688..fa6820b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -130,7 +130,7 @@
 		CPU_PH20: cpu-ph20 {
 			compatible = "arm,idle-state";
 			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
+			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <1000>;
 			exit-latency-us = <1000>;
 			min-residency-us = <3000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index aeaef01..0884e1a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -143,7 +143,7 @@
 	CPU_PW20: cpu-pw20 {
 		compatible = "arm,idle-state";
 		idle-state-name = "PW20";
-		arm,psci-suspend-param = <0x00010000>;
+		arm,psci-suspend-param = <0x0>;
 		entry-latency-us = <2000>;
 		exit-latency-us = <2000>;
 		min-residency-us = <6000>;
-- 
1.7.1
