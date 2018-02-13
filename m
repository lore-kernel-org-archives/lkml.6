Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934136AbeBMPzq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:55:46 -0500
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:59168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933440AbeBMPzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:55:44 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <shawnguo@kernel.org>, <Anson.Huang@nxp.com>, <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH RESEND V3 6/9] dt-bindings: clock: add imx7ulp clock binding doc
Date: Tue, 13 Feb 2018 21:28:11 +0800
Message-ID: <1518528494-25723-7-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630109430542397;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(396003)(39860400002)(2980300002)(1109001)(1110001)(339900001)(54534003)(189003)(199004)(2906002)(85426001)(316002)(36756003)(104016004)(76176011)(336011)(77096007)(26005)(81166006)(8676002)(305945005)(68736007)(16586007)(54906003)(450100002)(81156014)(86362001)(356003)(4326008)(105606002)(50226002)(8936002)(48376002)(50466002)(6666003)(26826003)(498600001)(2351001)(47776003)(97736004)(59450400001)(51416003)(5660300001)(2950100002)(6916009)(106466001)(53936002)(2004002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB1423;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD025;1:lTj0UdrxeRIBa+d2lDRcehwuQDWp7Y9bDOFqEuXdvguaA1t3O395QbWYAK3DH3OrKjRX8dI/OoBMROK5QWnubKBlS7++0AYQnR96sOcMy0Ue4GY44azlSFPPDeJHjQx2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf7d43c3-3477-43e5-0edc-08d572fa3ccf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR03MB1423;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1423;3:FSNkSQi3j5299xz+/vroGpGm1wvyR/chDrSAxfTfcw2wW6ThDuC/SZFstuDQ/6vQDNG3sjJNcYw+35cSMHMQx+D3CmqHU5U72bqCiKm9wJxqBwlZnA4P3hJM1FDx/EijHoq2XgVpQkpKFryJvHIvnfwDGr21jXTYbCp40GZuecbgu6kVaKDT5wWv3hzxVCtdeTN+VT9l2jN13voRPLhNktr2CNzDc98T1vKLFvL3LCB9dfry40NDduemOZUzXXz70Jj2Mgq7vgLN9yPES5yz7I6OwH9eZK6csWFTx9FoAADqkhQ6SZOCdBuTwmkPAj0eU7NgN9ri+7eIpL8abzwMLK8JTl1b/hhXzD8LZBqzmxc=;25:zTLfhOjIVe04Dq7pXg8hy4LvifpXDDFD5bQ/osQspoxHAOZI0aDIMA/T85HRb5LAeYh2M1Y3r9fjhhbtvtb+cwjMF48UwjHnpr0W9AbreuYKYDVWd2ZeqFyjcNybxCAz7LO9e+aWxIHQsEetA1Ev13edqaIHAXtcEw+c9isiDivDOS6vp5/20obeAiJJPh2kDJhbvOhrXrrR8pf91A6uSTXrU8DJ4c/oazTBN6vVLP/Dr+hEfOHDS4ScV2J0G5l9k0Ot5Ii19xxMJR63R19lVqPGnVwRfUM4Oq309AjJBzVG1uswktHdeWmudfMmJ0RWoDh5GwlS9OVFfGbre8GZ5A==
X-MS-TrafficTypeDiagnostic: CY1PR03MB1423:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1423;31:Px+cPwofAEKQssg6UraHA8Pe+CgWrDBCahvNHEK8ANNcpF765ENrKzr1unjWuZ2k21JUjmMYF/8TRVA+7PsjBasgnZNCi9BCbLOxyCu9qd4sGpN8e8HRngUGPdexMiftoLbd03SvfQ3bn3keH/xieO4LQhjG4IXs4njjHomG2C0Q7hPHFUHcQ8KJy/zdb78Y+rrmNjmt6DT1aRkkfUqnRMz4SWMDwKOLug2d2uTYNTo=;4:UCKvWifAgEeiUHqmVkgPM0gZUUAVHBs8UxW6e6Mi0vxDyXipp5ZOcG7hBo+a2ez23jxIIQl9b2maGEoMp/a7Hi5qr9Pivs/tHZp06CvDiI3PKrp9IZyFWNhvpdfRKlnzOhI9bN2ibwEfBaXPLmfSHkt7Ze5Ubyt8+/0WnUT5krYZD8fwXuJ3K0ARlC4Xg/tzRXOztqEwltjywLS4yh1RCDr0xND/hq+Jxfok59ccrVd8h4upBHeyEnAAYlBMZOWokaMlLWcA7XBnxc4t4dbOV7shXMJ5eNGObEooVRY8k2q5+SgPWQUs47li6UxCaqdFOfAGcgTW6HY8PsRARoZROM5CpBt9KS0SGjJTcTK6Fps=
X-Microsoft-Antispam-PRVS: <CY1PR03MB14232BCCF4B8B7DC28108F0480F60@CY1PR03MB1423.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123556025)(20161123561025)(20161123565025)(20161123559100)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(20161123563025)(201708071742011);SRVR:CY1PR03MB1423;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR03MB1423;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB1423;23:lcfjqTCrbBtLDC53M9T68wJDdv/XSnuYDPvozszyb?=
 =?us-ascii?Q?/2EFSHcIGKSyL4ErH7sdos8Zl4mfaIog+7aDFZL+nlLywhVjsbqhiE1tA5hm?=
 =?us-ascii?Q?t/5Wtew4N465BepeObSWQdvgDLaVE1HBUzRbI2czErnbx8jLmzlu0Pu7cVRr?=
 =?us-ascii?Q?8iKFN43pJRIpwoU4ATHajuH9REo3VQ3ZPcoZKETU89/C+E9HKPqz23JfHNfT?=
 =?us-ascii?Q?RSHhEJv2AaDvOw3HlOjxi1DES3y84capqUJdWqm1cAd93qUdMKRzh2TK6Xwl?=
 =?us-ascii?Q?NY4K2MiZv2kAA83zwtQP8yovrjvs26PvdwuX60rkmL7Zi5EZkX297ZZu0arZ?=
 =?us-ascii?Q?1jnFZtJMkbIDlUitI2wo+9Op/sK+cRWD7mLM5qTjFXTGNyL3dwSpQ/gvqk4h?=
 =?us-ascii?Q?FYrQOxHZBqr9tvbKyzX+wEOwZcYSEhg9tCd42E18z3zLrG4P5Ekys+xjEcoT?=
 =?us-ascii?Q?pmrJgnDR6hKhtLcq6/oEsPJkXzDgFHwN3FxyuL4GGYvGddpF5L2nc3anpYvK?=
 =?us-ascii?Q?FXPKhCIRTLIDbQzMM4302dM+1CfzSOozbbN6z+O8KuUyWFIepXPOwLlAUxgx?=
 =?us-ascii?Q?FeUb8BDeHER/ApbrgUgv9FCguHczxM/LwqFFGaCOWh27ZozISNFRSg73W9td?=
 =?us-ascii?Q?txH3gDYmZpRkJKyskdl7L99Lc1Cud8DNtsIAHF7FHE69X6teunAE2Yzab7aV?=
 =?us-ascii?Q?N922Y9aF9r2BAAKwSSc9/6BMUBzTizjQCQTy00hLWomQmajmzvZsdg53plft?=
 =?us-ascii?Q?frgxdMXsaJYzGqPrQ1CGEWv2VBxO0b+aCkMxBZyZh97pgL7A/ZBb0R/FjXf6?=
 =?us-ascii?Q?7iJ2+qPWu5xeACqPIj0SwLtsESsw1fod+MaCgAnMnW3wLmxShq/+uXDl8Rt2?=
 =?us-ascii?Q?bj7TwlJjhO+GEi2v3dZ5Vp1haXMxMBuRWW572lKOkNzPQgdNhTdpDSnKrSnm?=
 =?us-ascii?Q?Rmo9nO8jMoDY354aVKoGXI1FoyUT81FUCgmarCglP8oK/v24/tEmn0zBKSMd?=
 =?us-ascii?Q?+uq9fHON8oj0R0AVwqAEMV6zewmhSTG9KM+ewd6Hx05lEYCLCgYCef3bMNsT?=
 =?us-ascii?Q?6UGiBUFkojnutekHFgnk8MBSltBnP3Oonf7ddHT7+uB39TMSEWqCY7XMNiXB?=
 =?us-ascii?Q?aJyrKZVKhhX16ML25oUj9LtpUlq38nEfXZX98Vfmy+7f0HYb1/+qH39JqRdD?=
 =?us-ascii?Q?GKalkSSB0/S6Hwr4lwZaGFZ++9zCWmh3uBL?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1423;6:8IQeyRT+Q7a5kApEMU8IEu2wPTn4YSyHsKDBpF4p0ABAUKuxgMe/9foTPqHfsf3uAbh1VzP8aiwm6Izdy4mXhYXGPeajUX0ll7i4Tv0n5ST0rqkzom82KeO4FS0UKGTuHHaUajKQYQGNmoTz1uEn2eLrXSrLf7uDIjZHKfXA6iVNp3ZWStc4nKHejtZ7ij7cuxArIsCaW6HZ/gzQseYltgN+oghwvLl+SklKMZxgEEiQuSc//t//zaPCG1SwSwU7ywLaMhZMGdF1VxQ6Wp/VN/wq1Q7oWkG49fTPRLRQ9riyZdD85qn2gTEHRg6fKzErg09bMKuMMtHAVqvaSgkURptY28aXeaQKaYoZ8jcsC+o=;5:Bnu5l8t/VMYlzqzySlX7T0IZd18OsnVxrXbbXCs6/FwGOG8xE2dhr9yoM70hAvqGnDYdTV5+AdNmSEYxyUX0qgvMzsrEULQJLNi8/Kly6wa+rFXfgNx77yphCmW07KCkcg+4HFsEz9Gxj3cA3IwFLMHbQYPjWLCiq3G4YOWaUOg=;24:hQJ+C0fgkAG3tVldG9QQzbiv0CAhTHPjChcUjLuN73h12bTJErUIkzWF33IBLGX7sjw/+V3ocreOfHgXe9udn0ja+9gECMB98JOoQXvzpnM=;7:JyPX0DuFekJjWVI5S08e0TH/SRNyLgBejmuG6+6oOO+/jXqk6vafKmwXcgRRqksn/P6hTXubm9gR7KHNyZcaa5U9LHHza5oeWSyLO1PNj+p/1+mMjRLPt9sbsywPTJy5lHfnkRc1eT2G+JIyyOsY4xcMUH33u9OjoVq9Ygq9d87BE0vAn1ekLVlAS8YD5OaXRCXfjh+VqVkfeAo8Vo5sT545DNLdQbXt+Vdu0zLYNN+elhpYU44JNKHaCmYAWPM8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 15:55:42.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7d43c3-3477-43e5-0edc-08d572fa3ccf
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB1423
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

Note IMX7ULP has two clock domains: M4 and A7. This binding doc
is only for A7 clock domain.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2: no changes
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++++++++
 include/dt-bindings/clock/imx7ulp-clock.h          | 108 +++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
new file mode 100644
index 0000000..76ea3c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -0,0 +1,62 @@
+* Clock bindings for Freescale i.MX7ULP
+
+i.MX7ULP Clock functions are under joint control of the System
+Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
+modules, and Core Mode Controller (CMC)1 blocks
+
+The clocking scheme provides clear separation between M4 domain
+and A7 domain. Except for a few clock sources shared between two
+domains, such as the System Oscillator clock, the Slow IRC (SIRC),
+and and the Fast IRC clock (FIRCLK), clock sources and clock
+management are separated and contained within each domain.
+
+M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
+A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
+
+Note: this binding doc is only for A7 clock domain.
+
+Required properties:
+
+- compatible:	Should be "fsl,imx7ulp-clock".
+- reg : 	Should contain registers location and length for scg1,
+		pcc2 and pcc3.
+- reg-names:	Should contain the according reg names "scg1", "pcc2"
+		and "pcc3".
+- #clock-cells:	Should be <1>.
+- clocks:	Should contain the fixed input clocks.
+- clock-name:   Should contain the following clock names:"rsoc", "sosc",
+		"sirc", "firc", "upll", "mpll".
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+See include/dt-bindings/clock/imx7ulp-clock.h
+for the full list of i.MX7ULP clock IDs.
+
+Examples:
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+
+clks: scg1@403e0000 {
+	compatible = "fsl,imx7ulp-clock";
+	reg = <0x403e0000 0x10000>
+	      <0x403f0000 0x10000>
+	      <0x40b30000 0x10000>;
+	reg-names = "scg1", "pcc2", "pcc3";
+	clocks = <&rsoc>, <&sosc>, <&sirc>,
+		 <&firc>, <&upll>, <&mpll>;
+	clock-names = "rsoc", "sosc", "sirc",
+		      "firc", "upll", "mpll";
+	#clock-cells = <1>;
+};
+
+usdhc1: usdhc@40380000 {
+	compatible = "fsl,imx7ulp-usdhc";
+	reg = <0x40380000 0x10000>;
+	interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+		 <&clks IMX7ULP_CLK_NIC1_DIV>,
+		 <&clks IMX7ULP_CLK_USDHC1>;
+	clock-names ="ipg", "ahb", "per";
+	bus-width = <4>;
+	status = "disabled";
+};
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
new file mode 100644
index 0000000..2556106
--- /dev/null
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H
+#define __DT_BINDINGS_CLOCK_IMX7ULP_H
+
+#define IMX7ULP_CLK_DUMMY		0
+#define IMX7ULP_CLK_ROSC		1
+#define IMX7ULP_CLK_SOSC		2
+#define IMX7ULP_CLK_FIRC		3
+
+/* SCG1 */
+#define IMX7ULP_CLK_SPLL_PRE_SEL	4
+#define IMX7ULP_CLK_SPLL_PRE_DIV	5
+#define IMX7ULP_CLK_SPLL		6
+#define IMX7ULP_CLK_SPLL_POST_DIV1	7
+#define IMX7ULP_CLK_SPLL_POST_DIV2	8
+#define IMX7ULP_CLK_SPLL_PFD0		9
+#define IMX7ULP_CLK_SPLL_PFD1		10
+#define IMX7ULP_CLK_SPLL_PFD2		11
+#define IMX7ULP_CLK_SPLL_PFD3		12
+#define IMX7ULP_CLK_SPLL_PFD_SEL	13
+#define IMX7ULP_CLK_SPLL_SEL		14
+#define IMX7ULP_CLK_APLL_PRE_SEL	15
+#define IMX7ULP_CLK_APLL_PRE_DIV	16
+#define IMX7ULP_CLK_APLL		17
+#define IMX7ULP_CLK_APLL_POST_DIV1	18
+#define IMX7ULP_CLK_APLL_POST_DIV2	19
+#define IMX7ULP_CLK_APLL_PFD0		20
+#define IMX7ULP_CLK_APLL_PFD1		21
+#define IMX7ULP_CLK_APLL_PFD2		22
+#define IMX7ULP_CLK_APLL_PFD3		23
+#define IMX7ULP_CLK_APLL_PFD_SEL	24
+#define IMX7ULP_CLK_APLL_SEL		25
+#define IMX7ULP_CLK_UPLL		26
+#define IMX7ULP_CLK_SYS_SEL		27
+#define IMX7ULP_CLK_CORE_DIV		28
+#define IMX7ULP_CLK_BUS_DIV		29
+#define IMX7ULP_CLK_PLAT_DIV		30
+#define IMX7ULP_CLK_DDR_SEL		31
+#define IMX7ULP_CLK_DDR_DIV		32
+#define IMX7ULP_CLK_NIC_SEL		33
+#define IMX7ULP_CLK_NIC0_DIV		34
+#define IMX7ULP_CLK_GPU_DIV		35
+#define IMX7ULP_CLK_NIC1_DIV		36
+#define IMX7ULP_CLK_NIC1_BUS_DIV	37
+#define IMX7ULP_CLK_NIC1_EXT_DIV	38
+
+/* PCG2 */
+#define IMX7ULP_CLK_DMA1		39
+#define IMX7ULP_CLK_RGPIO2P1		40
+#define IMX7ULP_CLK_FLEXBUS		41
+#define IMX7ULP_CLK_SEMA42_1		42
+#define IMX7ULP_CLK_DMA_MUX1		43
+#define IMX7ULP_CLK_SNVS		44
+#define IMX7ULP_CLK_CAAM		45
+#define IMX7ULP_CLK_LPTPM4		46
+#define IMX7ULP_CLK_LPTPM5		47
+#define IMX7ULP_CLK_LPIT1		48
+#define IMX7ULP_CLK_LPSPI2		49
+#define IMX7ULP_CLK_LPSPI3		50
+#define IMX7ULP_CLK_LPI2C4		51
+#define IMX7ULP_CLK_LPI2C5		52
+#define IMX7ULP_CLK_LPUART4		53
+#define IMX7ULP_CLK_LPUART5		54
+#define IMX7ULP_CLK_FLEXIO1		55
+#define IMX7ULP_CLK_USB0		56
+#define IMX7ULP_CLK_USB1		57
+#define IMX7ULP_CLK_USB_PHY		58
+#define IMX7ULP_CLK_USB_PL301		59
+#define IMX7ULP_CLK_USDHC0		60
+#define IMX7ULP_CLK_USDHC1		61
+#define IMX7ULP_CLK_WDG1		62
+#define IMX7ULP_CLK_WDG2		63
+
+/* PCG3 */
+#define IMX7ULP_CLK_LPTPM6		64
+#define IMX7ULP_CLK_LPTPM7		65
+#define IMX7ULP_CLK_LPI2C6		66
+#define IMX7ULP_CLK_LPI2C7		67
+#define IMX7ULP_CLK_LPUART6		68
+#define IMX7ULP_CLK_LPUART7		69
+#define IMX7ULP_CLK_VIU			70
+#define IMX7ULP_CLK_DSI			71
+#define IMX7ULP_CLK_LCDIF		72
+#define IMX7ULP_CLK_MMDC		73
+#define IMX7ULP_CLK_PCTLC		74
+#define IMX7ULP_CLK_PCTLD		75
+#define IMX7ULP_CLK_PCTLE		76
+#define IMX7ULP_CLK_PCTLF		77
+#define IMX7ULP_CLK_GPU3D		78
+#define IMX7ULP_CLK_GPU2D		79
+#define IMX7ULP_CLK_MIPI_PLL		80
+#define IMX7ULP_CLK_SIRC		81
+#define IMX7ULP_CLK_SOSC_BUS_CLK	82
+#define IMX7ULP_CLK_FIRC_BUS_CLK	83
+#define IMX7ULP_CLK_SPLL_BUS_CLK	84
+
+#define IMX7ULP_CLK_END			85
+
+#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
-- 
2.7.4
