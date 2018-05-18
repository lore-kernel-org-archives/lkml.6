Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeERBFC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:05:02 -0400
Received: from mail-ve1eur01on0062.outbound.protection.outlook.com ([104.47.1.62]:62890
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752089AbeERBE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:04:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, stefan@agner.ch, adriana.reus@nxp.com,
        rui.silva@linaro.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V2 3/3] ARM: dts: imx7: correct enet ipg clock
Date: Fri, 18 May 2018 09:01:06 +0800
Message-Id: <1526605266-18464-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0144.apcprd02.prod.outlook.com
 (2603:1096:202:16::28) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:ISVtug5CFbmLVABwEJaZ3JK7DP7UMJ1MFdlAYT9fVMuARVzpqElrjEV33zW293mvrsESSu3INbfBNoBZGBv822z65RNmYPFT/ooYm6ckwOZDowg4VR0qO6iVhCsnqyFjIw96sQgu98FQc5EuXwOujAN353ZczNnN86gJJQEUq/pL1swzpcX+xQjxybY4Nu5b0eOXN7DYo21ega60mcTsutgkVKQue4B9zcxl8f+aGEi+wIOSdo1OnqEYZR8OW7MS;25:VW0cuR4/78CBkG7GcFfD5WlTPMm9ZVgWF7+5w3a8soAtdg8WPVQ/OZW3qWpx+hS9Z4wLSRS9U2WRsjqHf7d5sdSN15INCf8cD9XEe2FaMG57U/bDywrn9/SxoYYvM3lvF9IxkTda+3RWxVUxdjp1M2O9RyYpyOb7vJXAsD8qjdCiBEurMy8RvMEXydXyxxsRgKnFyPx1ZBdLZ7bZEze9FDf1F4ZAS2TSJMvfeFS/uDDA2S9ei0+ITGBQEgTXrrwB4lHdQIFnIG0UvoR0dsOeb4pxFXjGzXuVGeQDj/6ag3vdKNSQRfuwMLU1MpkJ5YMVjYODK11kw16hoJc5ZMsdRQ==;31:j/SzA6jT5gD7DBL+MxlartFEao4aHiSc5TO+jVZ05nwZfDJgEOejMyoTkZKMdARHgq92uOiPKPb8Wicq2SqTmNmesLys7HM6VP0fKeoo/ctssqEl/jZe/vfD+NaEduMQRU4n6ONC0Od4oZU9iFgIqRJL9L9qaalPPKRJG4jnx46AmAivxyM6OR9bfwfpV9t2qDcB9heXBTNOz21J1OyBeIFF5VZUri/sb2AbVrwRA38=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:CruqjqsBTFltc1gNpTN1U3X+Z+n9FQlTT6q5RyNfsac1SDOIrXSlIEhyOf5Is93DIFOtgVAONMlvvVwtY1ExwFK8yGab0/k/tN29l543YY5anxgeH8JiRqsG6l/4rnDb35aTmAgJGkEUydsiSnVYcQtbs1GmR/Ka3DhiX4nOSjF/hP+gUn+r8UysiVX+YEAvsyWNdA5Ehs512nN2/8ytrcysqELdI3ONxbs4hlVQafpOy5uaEGFKaOSKzPx657L6lVYeucZJoWjphUUeBn2MidHU1avCxXnykZjWx9ORLFVgD6IY+D23EDcM8eITshegZTjUFbM+pH7q8Ir+XCgAz92ojkdh9Zo3np7KqGo2sEcmHmnMht7gCtfj22Pi2VhJXtI9/nYZRZT7qchZah+d9lTg3xTRh24d4yJV0ykQghocB15lUjOlY9fRIIaqnTXQDj1KXNjcGQGP/iLNV1NynuzJkWBjuvPBl/lgEWZjAYsS9FutTn7vgYdPUVIMhxup;4:NWyjgBZ7KH9tlAA+4rJzyRRldIwL8Jw98GytWvO80I7MZsaoqDR9Nfro5W1OzN9ED9cooKPd2bAs2RLkWkoqKRSbq2Y/AXX5lKsCm0Y6etgWu/HHZ6gOJG4Yq/0Jwe67jbybbPX/lvU4kEkxu26dI1BBobv91PNP8pn5NI/R0bYU6rFxtYi65Jy+oi+ctf3c7ORTCSu5gnDaeuz/d4gP9o68HxcbK6MLDsJolwYZzTHA9XYhPfGrger1haXZPgt7h+/pRdEsAQZce4ukt8aaIWZIZYXqTa/rm58II0NcwhE8NIPa5+ZLCPcR4fZF+IjJ
X-Microsoft-Antispam-PRVS: <DB5PR04MB1318CBCF21EA9834A2CA159DF5900@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(39380400002)(396003)(189003)(199004)(476003)(6116002)(11346002)(5660300001)(50466002)(81166006)(81156014)(446003)(2906002)(105586002)(486006)(3846002)(106356001)(316002)(956004)(25786009)(2616005)(186003)(8936002)(47776003)(97736004)(51416003)(478600001)(16526019)(66066001)(16586007)(50226002)(8676002)(26005)(48376002)(7416002)(6506007)(4326008)(7736002)(305945005)(386003)(6512007)(53936002)(52116002)(6666003)(36756003)(6486002)(76176011)(86362001)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:k33KWFMd3apzFFv8rmtqbCJ922ZQRvTFYhMF6MUn2?=
 =?us-ascii?Q?evoBhQmocwjnyq1ZE1J7dYu3Bc+nrEGIdswuWqgoqzSI2kUhda3aYD95QRMC?=
 =?us-ascii?Q?wqDtYblNcXZMSrGRC8yadpq83NUOr4d/yT8EJfDxBmBSRZ92bp9GHCbyeSBY?=
 =?us-ascii?Q?mCIrwhGvYSi8M+LTkdjIp2Z7k7c/dLRAWrW33bFGNejcd0CTvhy+dt7GgTLV?=
 =?us-ascii?Q?AHKwNfxlf/EjjRxdCiHuZKpD9gw0jAE4GoGcJxtpylIhaVUFG21kjtyAiFTj?=
 =?us-ascii?Q?+DlSMKWLOHRd//IltWF5N+wmVY5dLZ2XJs2xNIi6z+3LYhQFF4oIZu4JtN2V?=
 =?us-ascii?Q?ZPCvXaEbR+k7dI82yAU5jKtt/+NgsuosmFmEwUswbQp17bFHKKbAM5LchWc/?=
 =?us-ascii?Q?Hqc9tBZT5VEX3idCoeAgnqhVV7gcIE3FU/i7o0y2Fl/plNGmLyCqqYzsOgHo?=
 =?us-ascii?Q?DUEqR//ggIe6TA3bOIsOZfeEZ0GMLbSqkj7I98ss5V5295TafGJV/tt05VCD?=
 =?us-ascii?Q?AI8mGpHyz6jJE3dCO7ekqNnZEcrXBb9OeyW3XbGHODjNP0WdsBpHs914FnuU?=
 =?us-ascii?Q?O2QkhB760u+iLdtLuyIP2lItAeeoVrGMov8zVIDXNiLzB3eU8t9hkO/jr3rb?=
 =?us-ascii?Q?p+JSC0R9sMV/10HWWYzSLk/R9V9U7jG4krDIcXYboRxCXuxV6xjiM0MEGeqj?=
 =?us-ascii?Q?qutAb8hEdv5uuIgb9Edf/AjnqfTJvBl76f7g4o4sbufUM11uaeWF4wnJ5lfc?=
 =?us-ascii?Q?OqxMXDkwbZMG4yeANnvGnUcm/yaV0MKSaDhrv8FxGdlFyZL34vPWs4ge10sR?=
 =?us-ascii?Q?QzXbC+olE5I/LR2xisCHq30v1CqaGUlsJaFg+tJE0lWg8sK0sCQ5JxS1PaMt?=
 =?us-ascii?Q?JyB2Iv8whmm23AeNC357R7ps4tLrtV/OmZ3iQUIEkTBoHmZWEt2wZaQl0Mqx?=
 =?us-ascii?Q?btHwzy9VRzwBKz4oVQfloxkwNJ9/NV2i05b/yPVaDJrwo7qP1EZeHeMtdZ3M?=
 =?us-ascii?Q?mU6M19zDfMeuR4VPpA5NThrFxBrT7ljxAuHNFPdSvGEpxirzUM/tYLGjDU71?=
 =?us-ascii?Q?84GiFGBsAWbWCFE+z8IiiqIQ6hhx1RrC+WqUSlYy0egCrBasXf6ZcuTc8jZR?=
 =?us-ascii?Q?YQe4XgXTkYTl1miFQilvIvbivH8UE1oejlzxSZiDl0XMUvdtDeqvzZAgW+at?=
 =?us-ascii?Q?LWnQIiq9v/LZFg94jpG7ZPMPTolnzfm/YYL?=
X-Microsoft-Antispam-Message-Info: TgaqguTUt7g1NwbZMbQ8/bV49X+X4AirH6Jt4c9S5t6V25iVC7b8G93BchlMh5mHlsvxWjul0hwiTa8pNmw+Zk7q2Oke+YohXOvIDhhCBz5ROXktZR528yGcizr86gU9Q8Xq2HAlwxyIUj0OLM2VRxU1NARvm7QYRKuZLHOVkFIpQoYQXAgT0wuEL13uvuEZ
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:X1AuOIJcxG4NVfhEUs9k8EQ6zgd3rkIiKhJB4NeNpl/j35fcF2dv6SDGeoat+SXNkB+/MuM9zR+E3lyu60UM6z3KIehXOoyRYLfOAwG/Htxh7eVIYJ+o4Hmf98FPl3wB7S+EkEcHwZRX6x9oJQak9GWbs9TmOuYdQ9Duqjl4RZIQfA/D/mzXchudriuD1288NjHOhnlvsI/LbO24mD47REjtNOJRTmdJLhW69pVd9a/hwMz5ZJY6GWbNV6f7Sk6zaK13U8qMUm4E4W2TkqpL+imzIYUjImsClZqARdLYDRk4MTE9NaybZsdA3h7vUHCHxUIhHsGShsIAEceVRBHnyCua9nK4I6a+63g+VdikHczbh7UUzDa0ThxjzlKrDkwJPYtfxbyBcwjR/4RhnLfauJ0GxgmAmqqTpMnCXnyex5RYj6Vt5htCRIZLHvh/MfE4LTi7I5oxR/Ra3kcbTvPbsw==;5:eBn0mD0qinTRamG82Qtr7l3a7gv9CduwKiMk7UVuQKerjI3zNot60TB5QZQGnJ91CU488BdXeAbbhWjyRQlPJpSeDXiHqo4hb3Xvz0CHwicsV0CZ7QqHJ62ewh0TNCCTktrgpqxAtFhty902TXDtQsW2i06htUTPkFWfIKH7FfI=;24:Bcvnc+utQnHma7tW0T+k/E02EnE1jOlTjr8Z7CN6Sl1+FmbqHM67/vwqVghMTF8c9OT3C5uNlSUYym+cgAoDgy9fKmf2YyMgqAd/gtEro3Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:LFrEIWZoF8KBj8ChzLtgc6pdmwyJBL+QWUCuB3u1AdYmSOBiV6PtsW4gpiGEId9aJ4IxVDV637tMwgLdoawgQq7XleyWcOSepUnzCkYujt+Wi5MNsImOzyonRJppUUMtlpaTu55ughSAnPSRTkUi9eQnyQTJ45RVijG/dynZ+/ihjlC5R0SHfAYhAHe7DTcmkEIU7Xks7mxHKDYfLd7CbF5m8wb4mNYWfcndReW2+uJ5h8p5IO++i9eDztYLMdw3
X-MS-Office365-Filtering-Correlation-Id: 38e52a25-d2f5-4634-4211-08d5bc5b5d83
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 01:04:49.4564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e52a25-d2f5-4634-4211-08d5bc5b5d83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENET "ipg" clock should be IMX7D_ENETx_IPG_ROOT_CLK
rather than IMX7D_ENET_AXI_ROOT_CLK which is for ENET bus
clock.

Based on Andy Duan's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 2 +-
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 200714e..d74dd7f 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -120,7 +120,7 @@
 			<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		clocks = <&clks IMX7D_ENET2_IPG_ROOT_CLK>,
 			<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 			<&clks IMX7D_ENET2_TIME_ROOT_CLK>,
 			<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 4d42335..b90769d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1091,7 +1091,7 @@
 					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+				clocks = <&clks IMX7D_ENET1_IPG_ROOT_CLK>,
 					<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 					<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
 					<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
-- 
2.7.4
