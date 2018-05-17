Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeEQIo2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:44:28 -0400
Received: from mail-db5eur01on0083.outbound.protection.outlook.com ([104.47.2.83]:59712
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750825AbeEQIoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:44:14 -0400
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
Subject: [PATCH 2/2] ARM: dts: imx7: correct enet clock settings
Date: Thu, 17 May 2018 16:40:22 +0800
Message-Id: <1526546422-7431-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526546422-7431-1-git-send-email-Anson.Huang@nxp.com>
References: <1526546422-7431-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:x15peqZ5XnQhe2Pk2Uq5ZcZWgZ2miHXdIeqZcFvrlu1XyEhuZUrKRrDtHtDQLR5Yrkb36Iz+sxg819QUNRFIEUVi10St8aJSCmkQb7p0e5lxvjnZQoIGUQua7T7YXkf1LFsTbekU/Hzeoa02FNFFYgzwdZ+SQ5DnYs6ka/zX0/0jOAOZ15YCXbWGiVictsw6aCtl3ENioA2uKDACCq2eQDXO6Qd0Fgrc+xuZXSLn1QiHqxzQHEt2PjMixUZ926xk;25:6kFvzBtryvFWKrObhNQ/NGPxPciiFWXQd4POqkGExr50WXqL5AnT49qDor6Tkdt4GxsH/5rYg0LWf+LwEwZkP1xkHXeXkpTlPLXFTw5uziFZave7lupHKYFKvzUpfU66qLvejix/b4X6X5tV+NfPMZl4gkKYEp9viY2hcRRnrMAyzZpNirJTP1v32hzw9QEvQTarwFYpKJHFNwpyW5CMEdq0rAQtnvG1nADSoIrm/OEmcFPxojZpWwQ5naZ78hm+WiUMGqsfl5LsW3irvUN97BOANCZkHKOKTktOkGbC7fxL9y5erBvOd76lBW99NfpO6Iw2UflBMv8r10cJROCi5A==;31:prcI0lZvwc7lb4xHJ/mZmx/2gAZD+SCzh7vDq/K+pp42lmwn+XyqI0YK1yRpeOnOUva4OsZzwoc4PMXwIcIrZDPLF30w2noVri283bS4AJ5yePz4rKbfF0ciMM7p3drRxPubyiD4rt06ATji7RsOssf3v1EdINEnKPpVRPMDui/lEyXARjtURoJ4FCtvi2lRqjDW7bAyFsBEfJ2uJBKLp5N9g3FziXM5yW+PLc3CfUc=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:CDv9KjV1lCfAG1XyKkUVmbbyeMs7fee66SYQhQBlFSLqE/ZoR5r7+hvXT0CxD4jh6VwS6WvgzZQTfWrqnxo9xxWuxyRmolOBALX3nr7AvTdZukg38JcyXn+K7lZZIVA+LGf8xSqNBB5zr9BVCnU/QfPA+/XTgpfeIrpMICo8hhuxgmzNRRIKQimk3qDERVJqe+/zzaQIEluC7p4ERE7P06eYOIZql2af/L2Anyidhxa+5ZLpzg6QVpxsVEtMdbaufuvmq+en+O0YFNx1035/Foy6glQ04BM5r4O5chvfKMQGykpo3zw3M8jTqEiElvmoXqLAYXk5ODbtZ9qaAk0sg3yzGiG6Xb0LGC0XrcD6MNp1xNKIhe/RhzzV0ZpOCHIow4xJenngweRKpa1lC1XUDvLLLtlqutxPBAfmSGcdt0kcmPLr+lN3TFRVkb6PR0/LyOEj09BxHqwGHXg9v9H2YFGOTvDChFfz7qg12hkUbp13CYtrgp7KzXgmC+oJipcp;4:pjYYgCOZiGx49n7MrzrmiCayg4VOWt/3IHoDduAQOYYtFSGYFMGXmZqLjZzvNIRh9d8I8FuHYHy0j0W3fL9RwZQ71SWBHQ1b0FJp6CHU7US7sRSSbPRleuudsGL+mCrzfKLv9rZZkTo90Qk2/Y9kd9VOneHRzxX4v9DmG31GFFk5IV7QLRFV8tbAC7fgls2hDo7PaJssdQP0LmPk1qd6/WauWBrDarw1UlYMzMKSGqsQgIRN0tEdzKEJGQ+ijaPIEYfxWDsvHmeyHqC//Wtnqy0XVlr5Rbe0B1Ow5TwbCs0a4BFMAJkcLD1W5MHa5Qns
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323493F41682F29CDECC285F5910@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(68736007)(3846002)(446003)(316002)(16586007)(4326008)(48376002)(6512007)(956004)(6666003)(2616005)(11346002)(97736004)(53936002)(476003)(50466002)(2906002)(106356001)(478600001)(105586002)(305945005)(52116002)(16526019)(186003)(6116002)(7736002)(8676002)(25786009)(66066001)(81166006)(8936002)(47776003)(26005)(51416003)(6486002)(6506007)(386003)(86362001)(7416002)(5660300001)(81156014)(76176011)(486006)(36756003)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:T5PTE3w8gcQPxnEp0jTy/tcojxihlC5UpPtS9I+RG?=
 =?us-ascii?Q?x8CPL2gYBRHJlajs0fxGRWaJctC7Fb5s3KUqqis9hkOhXDV+Wr+FiBQX4oRV?=
 =?us-ascii?Q?V6iU9MXTcXuKFk7NLWr/kKvMju+5oCe6eJ/UlWBXwYfGLS5iUnGKmSKqv+NE?=
 =?us-ascii?Q?3ZV/uWb/VpxCwAlShwVe9WFkh8LSOzNnIkVmF7a0dWOu4qiCps58oz/+YAR7?=
 =?us-ascii?Q?J6GJVOVUkFkNeZbJ5lYd0X5Cb4VKrk+WFzXh8wClHZaxwDlU8iEed2lbiyXW?=
 =?us-ascii?Q?alRD43BaByu4/UsY0EADJUvOLRRLNYt/6EJQX4I6qM0FjFYfcaDhGiz3Mn7g?=
 =?us-ascii?Q?o/wb6Mtle44d8krbDLnv/M6pnzXH8GrhNusfKFdVFJ3TxOW1CyIC+pt91czm?=
 =?us-ascii?Q?TP9O+jaykukCwDH5fHdJ5CeD0U6zeWYmODBKTr1VI4yFZW/VmnNpdebDaokq?=
 =?us-ascii?Q?546c/jGVfVanLSC8JE9ZvZrX27kqdscKVepa8qGbOfwBx6Mt3WC6SjqUirEO?=
 =?us-ascii?Q?9WsBSYqjS/T1cvu2C+fnji8c/k8hWuZeKNiAOLnTrZ8uAxFsXKLoZVEZvO3a?=
 =?us-ascii?Q?nk47ZPSn0y3/Wd4YSiwE3hHMRYm9a8Qo57lm0Tzr0QgqJGdfhjKWhGnW/AbY?=
 =?us-ascii?Q?FP49t+GVSRBcuFccsP2Xe52V00P78pw41Z/qXNlikwMl9GAK4wvvPQg8ZcOw?=
 =?us-ascii?Q?pO2cNY5KwUzIEBOSo0p28dVswMmkTr2Cjy7AiLgLlXpno7aaQlFe/6NsSDYf?=
 =?us-ascii?Q?nALYZGxIVxc6REtBR3A/mQyMsFYT8MesQDIxMckr+JkknkscJUTRaRMYAgjA?=
 =?us-ascii?Q?y8AtKIKjOFbpgqDooQm+Tv78JTQp3rHvWSV6Z+w1RwWNEvbWAd0YgCmihdoh?=
 =?us-ascii?Q?CDL2til00ni5IW1xvpyranoq3r5zYWfPBjZID9Ap6nmsR8XQsAGixyL32SOW?=
 =?us-ascii?Q?wFmCIbhy8A93gCpiw1aeCKsDm69Rdm4b4c4lKLHziN9oH8Y8PFows829PwGX?=
 =?us-ascii?Q?cU6jh5wSf0VetaEpF21HbnaTLDOZ6aT2kMJ7pYRtL6mMlISwhcKuWkpPaLNP?=
 =?us-ascii?Q?DvV5zOWADX+eLrc7aT7+hsO6YgVLK9sqg/jpoqEtcZX36cJY61KSWup5bHvG?=
 =?us-ascii?Q?mUX/FYDWHrWAz8J8CKl/WNEJMIqY2zjyU6DWpN9GQRj2oe4vMIay2OyOdujw?=
 =?us-ascii?Q?gJxzZhD6PtDaiJaIlrTu4XX/DMMHqStJDuf?=
X-Microsoft-Antispam-Message-Info: ntniD6b+gLm6VALSUInmcLwBNXwYYjjzg2/CwRrFDK61fG3PDRlHJ9pd/mpVy9OKj0qKQ0IhNRU9PEPA9KLqBdLFoypE3w6OtJ0u1PMaU2cX5inXCTE6COWR5XssWI5Ceqe2fLEiNlDyuR9YZ/gGDqc01QYtTFLAWlW07MdidLxZJt5rYADakk8uCUpolIdx
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:y2uU/+1X0lwSCNfFPMTenXz9Dw1cIEG4FZwkIYJpEpzudtpAYYPgfIhhiK8X7gNzbR0ANGAU0085yGKTm6YN0BxLG89xOPN+JowfJB1B4vNRT/DFFherKzVdooZSquggIcmaNPRhw6i+XZVZ+Q9yrsFpt/PmpsdeXVz3DDHqrFtFjkjC6HfwZY54u7B7Irsy+Ubx2S5wvydM1fEVS/W4Gi0UCMhNzo2lPRMhRPLZy7otoVOlEYaVyfI7scbNmc4Kc+/G1aSpmehujzf6jE51vpi8KAtG50gJbTAI+bK/l0O4UbXAKYdJ7OhCIilHo4o8wJ+eJfZOoCm1/424tLn14fRTCKMbsgjlxAEV5D53alP0+kOCVzllV7hsOmEnrQjnNe8DXl9MasywZ4Ro6+tDY3BJTUH1JWJaaVwzICmLtCisTknrQWGYp78Om4EQA8SJMcakq7z7qwPcgrBPO1/T6Q==;5:DolMJ7J/t9Dd5bTmrTbtEPC1Zv9kovwleanx9hANFmKxEvg6uTM7Sz7bg60yYyslz6VBiIm3oVDz1dEc6vn+qdzT2rsAo520+dcSQvbirrY2mKiPgc8VvVQN4e+GpyjPLe99PcXwsqGNp2UehvLOdrmBWZLLAIBNNM8RixLTuHs=;24:djSh2lKK7yG23ehFvL4ppOS9Rn0kbzSdMiM2oquUvE9m4vBoq+OMq2O9e3puk+yWgg20I090ZRzQCZUeyz2KL2SQwBhU9DJCHsQhaq40PSs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:czpY7YlzGEy6QdIHPh5y2bz6/S8ClfBTTax/IDHtGbFxhJvA5cXuUEkSYr6/oxUx8Qs07uzWNqKjhewAa+HqVC5CLz+b2h+bDFSMnoBNrLxreX8sfZe3U+DxV3djmzA2RdXUyhcGM8TransWtmT9E970tZgpBkPVvw6PVh3PX85xyCPvl+QD5xi3OGmXFwU8s2jgjW1S+9cWmkrPgQgFQuVmY3ATC4Ve4VmiNGOgQ+AFcp/NTBEns1vSfDiNl5AO
X-MS-Office365-Filtering-Correlation-Id: 1a0dfb8d-4ac0-448f-de31-08d5bbd25b5e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 08:44:04.7324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0dfb8d-4ac0-448f-de31-08d5bbd25b5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects ENET "ipg" and "enet_out"
clock settings according to clock driver's changes.

Based on Andy Duan's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 4 ++--
 arch/arm/boot/dts/imx7s.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 200714e..92022ea 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -120,11 +120,11 @@
 			<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		clocks = <&clks IMX7D_ENET2_IPG_ROOT_CLK>,
 			<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 			<&clks IMX7D_ENET2_TIME_ROOT_CLK>,
 			<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
-			<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
+			<&clks IMX7D_ENET_PHY_REF_ROOT_DIV>;
 		clock-names = "ipg", "ahb", "ptp",
 			"enet_clk_ref", "enet_out";
 		fsl,num-tx-queues=<3>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 4d42335..cf4ba53 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1091,11 +1091,11 @@
 					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+				clocks = <&clks IMX7D_ENET1_IPG_ROOT_CLK>,
 					<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 					<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
 					<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
-					<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
+					<&clks IMX7D_ENET_PHY_REF_ROOT_DIV>;
 				clock-names = "ipg", "ahb", "ptp",
 					"enet_clk_ref", "enet_out";
 				fsl,num-tx-queues=<3>;
-- 
2.7.4
