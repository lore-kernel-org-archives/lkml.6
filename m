Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeDYFku (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:40:50 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:22656
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751436AbeDYFkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:40:39 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/6] ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
Date: Wed, 25 Apr 2018 13:36:07 +0800
Message-Id: <1524634571-5914-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:604:b::25) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:61b2ey1Ms4qPQhuuIbjg4hjzWevJ0t1FDZ284ol7u5mDhhypV12OXzdNynvCqmPCIIOyH1n3iGPDw9t5VoibHZUxC1qkqPuYb2v+0LAUrhxdd7uS2e8p74LTCkX6S1WA7OymwwS/QX/XG5opcI1c7Zy3SP11spjJCgGxk4QVmYJP3oMkCIIZyIkiMt4aBSJDcZwWfeG+YZszpNxQ6MlwvBWeBQOHD+yxtiP5Z4SkYtxD/GdU6YQqNUrYcmIyyWRA;25:ErQOlfENQ9C0v5YvsIpFTe1sVWNwcUvUMsPop4/s97vwMAHfRQ42MNU+y+GJPtbKW2lmebfqqL8t6Ab3y7xk2Yi9qcreY80IUe2An4DfPfS81fChXIabLfpJUEnHKdpMf4wYO6ONLqrtH+kD9dZR3za/DrP3ilfNU8DtCUTaBJJE9QjIpLdgL18DOLe/kQWiTX7C5ifSFqIgVwtr6zMvT1S5d0Uy7GBw3I7AN9C+DOgRi4IZQAUdrDkvsNxchDySPWoYOytaDT4s0FP5X5SCr+wgNasEegjzPgoCJ2hgNzCW9GEMsLiLTIkJxVfzf0uTsMr//+bu60Ron7Wef05ptw==;31:YA6S0t/TTQXJGMqHq+4uf6sgKe6Kr6ke/SC3zBv8rCeNAuCnz37yRgcqrzHzWD7lZl3s+whmf1UgomHsR3PHBXnWa7phb9edypCh0vGnmBB++dM4sU2hPLR6vSi5T8P6tPpq1f2wJee+ufpwAE9Nj3H6EmcgCWujJVFcy8+CNap+tM2ovdi7mfjX4GSWOKLsB68IUgXv5Fep8UVDyuHRHhmzIguIjK6sRWUvForpAE8=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:TO+Fo7VCE0kBzNrSP5i9S5pQ+a0/XoD8X+erCyBgCdqAvplYSgzx61A8fTESLbdqAUzSRetvm9mVfJeJpDl5FC1i9ZK9nFpCRFHp3muOD777velHOfuc53AVyE2JpJGstlN6/fE7yaEO4AsmcFhcqLnRKOpdQTu9GxTKNlEDht650wujDi0HQe6/MYic+A5HlQlfjpqNlQL8wSJ+Mv3VIdBJtxY8V/wqXaehTSwt9NLbEGP4V3u5QFthmZGD4+eGtqzaDLbikNZw2/hl8HmD38RlgX1Q1uNdY45krvJXBjx7sTSTjR8Yf4PKOGEPjI3aHsuPn/bXWXpIPNUuaTTxeCIJSKUywJqT0G2dkzjlXh6tz+XId/Ofe7i+L+IzdxSYwJKjC633MUCYITlvpgcIwfCFbc0JHHUmGhcgDiT1lWdfvkVUSSv0El7WUj8hJFDRAqlHC+B6cA/VOo8q9/o0I6sxAQsARP5umgTvjw1+7vsdBtslalBySyTyJNyaA6IM;4:DiVnwn7khh1XLbyklGJDnDSkCjnUtiloXFPTEqtqmLpA9f9cWz2ChHqanzHkK8IGUCO5N5twcGS1ydyv/ni4++YroYt6OUjgDmPP4oPg7DMOkgYl4CF8vdItA4d4MBT79Aj64hdekwwB6pAdhFFyumD5HxUM0URPRg0FPgJQFrsbZ5s6PnGr4w60nQyWt1jslspTpmijoGbfMfqFLbpzLUqY5MDSV370uHnugi44f/G9bWMEn8KZlZsL8jGUBbFplQ1x5gHjpr/brwsQd+iWexedrmoFMK5Forem60Eo9y+jEBsA5GY08QNo4qgLQE7T
X-Microsoft-Antispam-PRVS: <DB5PR04MB1319B5839A171B56814CF1B4F58F0@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(199004)(189003)(76176011)(478600001)(53936002)(4326008)(25786009)(16586007)(6512007)(51416003)(316002)(6506007)(386003)(2906002)(8936002)(81156014)(52116002)(50226002)(81166006)(106356001)(50466002)(36756003)(476003)(956004)(446003)(2616005)(66066001)(47776003)(26005)(105586002)(97736004)(48376002)(3846002)(186003)(16526019)(6486002)(6666003)(6116002)(68736007)(5660300001)(7736002)(86362001)(8676002)(305945005)(486006)(11346002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:uS8V9wdzlJJZsIF6WVRR9SnDaHaWdJWMzHEVCrbdU?=
 =?us-ascii?Q?3OnsN/ikw3xHWDPIFsbLwFWTeAVQoIsGQ7V/5xcntIGqbOUbAIjB0KDOd3Ku?=
 =?us-ascii?Q?a1eSFkU0IWiwGd+hItzM1FFl9l3uv2kmpQqLd+rCTG/m9NNSToeV8PqtWVdB?=
 =?us-ascii?Q?W5uhmR8nBrlshuygiQzScNtkFBPKi5Rsd1T997qvm/6SVgph9GeQLpiQbLjA?=
 =?us-ascii?Q?LD0Jqs1CuCSEKgONylmHrxsCxRJ1bPXTCMQ35UULPDR8wxep5H/Ea+6dbslm?=
 =?us-ascii?Q?D9Ppi257HSkFqY5oBHDQRYOK1sXzBUvE/JhcPEwSjflhBBjeWTk3ySDdOX9j?=
 =?us-ascii?Q?zW1+j/CdpAGmqWxeC1mKm56DJLU7+VDVg4w1Tc5G8AOC+ZHSSwKb+kYVqYGC?=
 =?us-ascii?Q?HCKzqoweaHggQu2DgZxCuJ9ebRTAr8v/iotZEunUtX6wgFxIFCNCOJiQg3b9?=
 =?us-ascii?Q?X6q9ZPZGOmn6dICRCNTCEwnGECiIyhRtwYlHWNOOV9/7Rnn9lfA2rGCKAabp?=
 =?us-ascii?Q?Idcf3ecqCd+jZfWwQi+N+eL1O2z8pDyKi9Ttk88jK8GgeVZLaz7Io50dNjSY?=
 =?us-ascii?Q?fiU7LEpb6Qj+AZtIzzpPxGFdCH1iAeCk5/lzV9kwHLVUhJuLeB4GKNOKLtBS?=
 =?us-ascii?Q?PrnOQR4SJH8yEBANJKsFNGw66GX4+qdbZmdXmUp1js6Y0QuMBaGQpo3Rjscu?=
 =?us-ascii?Q?pMHUSICBP1tS8B6IHtkTqSOVEhKcLs6kC4a2XPdQXFnMxxEmjga5JfkqMnzB?=
 =?us-ascii?Q?LXvcReGqH1Rzm7z9HUuYpvQodtMS+vNcoa0XBNq/PWD6HtgSDiLm68shrfFc?=
 =?us-ascii?Q?lt+7oH/XcUZHfjSy95kLSXShpHnIU4Wg8bg/QQE9S62QRNK+3yZXgmGvFXzU?=
 =?us-ascii?Q?MQnmM9Xy7kNEEZa/UCJ1iFXgTXcPz1vEDndj93ZCTcjTnWPISOV/Z3k1iHqw?=
 =?us-ascii?Q?CiFI1XOsSyg5Ph8vQo7fR7b19TeoeaVggxARJQL15ywJLKQpGBGnaviUd0Qa?=
 =?us-ascii?Q?IPXCwDCiimdZRxgF2yw1wOczXBvYhT+jsVUeLBYFykP8UAKd+mExFGrHfh8C?=
 =?us-ascii?Q?Q3o0vU5kZ3r5EQ29/FsnA6T/6HzWyox5BHG9EzG9FXGghCh52+CAfHbgjWKG?=
 =?us-ascii?Q?5g0iJGgFE4ePW9vZHEeTEUpr8cwUbkqzpil4LN6IABtfMG6v8lqZbPYWjaGC?=
 =?us-ascii?Q?7z3aqe4dCmXUbM=3D?=
X-Microsoft-Antispam-Message-Info: ai7Eq5gqjAZX3SuflZoAFlgJRTRMIFWgJYaW+k1Bg2cwqWE6XjZaIMSfiEjNLqL3EIoj8uBgiF4Dr2jd5SwVsB9Wl+HlFUgn+hRP8sahUUK57fPUQVtqLnw/VKubchggHzBwqWw2VeEaUOBUw9QltJvNv6QtknEGhWPmpIHwC2XZBfpHW/lnMXF2+QvLWGJm
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:Yt5Q6ZTeOyTUf3a8byD/kw3zK1dw3spvibGG6rZoprkd6Py4ZRDxbIkYH+KjixeSru8BG6YazTZ/mMYrNDYsnAPTOELlght+g4ZjWfusLaOp19sprF9wpgl3fmLbMt5QaKbzSZFjo5+LlqKxgL2A8b+fbzOvcb2jrER8RcazhS4JqtDv8Fx7DjuUWZn9iHEpIy0DwQXSxrtISVnAC5cHbZ5Vym5r7nbgyTKaX4xjvEoSrLQEzMVCM1qm0f5rNohv35FByqN+rmekgDmOasS52JuOzq9tJP4T1tK13bF7dREl1SI1HFgX9e5E+nQhxcK/c3axoH7y+HKIDgRPrRRSyFsnXPC4SB4lTLaLdyYTqF8l3lTvJJh/3EA6c45GF9OSjOvVT+G9Em/c6XebjrnwE+DT/hhYdpn7Pho37Z5bLRd7uKYfVcrNCUFnihq+PhLAzWM3r3J3lu2RVIIvA8AkHA==;5:HDsqWMxp8XVtdFDgpFUEbSJcwF6MGV6gqgtGWM92LMAaKdt9neQHePGHKgMDgHq2Ew4oeTB8wX0HM7nisL73DyU6c2lf72GwPHR8Ot6AJgMSjUAOcpp8biE4c6j+Tf+GyhwAk1jrLNTEoz3as1Qv/4oE/riMorepovMTlBOrEsE=;24:jaiPL/0iGl/5aUWVQCe6JrQmyGoLB43HixzFptTsR5dNm8RjDovoB/ZecTZW6WegI3v2xwM0g7JSI0R6IPgNWUchxi0XHDG3kMSpWD26KxI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:hEzRCRBHEO9u9s2JUSKUCE10nXJYC4FmK8zh5XwmDv8ZAUBOQD8g1eInYByngRajmA5ix5srjzkyi4hmJe8i6FygvwpW3f5Mf6MOZAgrieA0j7sRKuteWIZRgJO/xeZst+IW27iq+yZwTYhbEfOomoH7yJEBrTGfZD5EKgeMRHLB3nlhzpGomU0a/ZSxkyLimJDvIt9vYgzCBbjNs0HT+22Q8BAkOthkrHyKXPu/DsgWUutHOqTUQ/ugidqYZ7kC
X-MS-Office365-Filtering-Correlation-Id: 0d06bd09-916e-4d40-f405-08d5aa6f127f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 05:40:33.2196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d06bd09-916e-4d40-f405-08d5aa6f127f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX7322 IO expander support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 2caca934..d59084f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -163,6 +163,13 @@
 	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	pmic: pfuze100@08 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
