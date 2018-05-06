Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEFGcV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:32:21 -0400
Received: from mail-ve1eur01on0087.outbound.protection.outlook.com ([104.47.1.87]:52352
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751822AbeEFGcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:32:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, fugang.duan@nxp.com,
        haibo.chen@nxp.com, yibin.gong@nxp.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 6/7] ARM: dts: imx6sx-sabreauto: add debug LED support
Date: Sun,  6 May 2018 14:28:12 +0800
Message-Id: <1525588093-29994-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KAXPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:402:1a::29) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:ajKTfPlUmrPwq3adMJodKSZRGFJSKAdEF+j/FDMutqER1B/TPnol4xiF+RWRfEZvwxjRC3Y3mDfac1gbPcIgzSw1xGMg02GDApybEW1XLg/WiLKhikFD1w2uXJAQt/Z9TSpmUWhSubFgWNeh4O1kia9OtnI8+nrKP5JG8v0QE44qmfnsmrS+wvlXpmnH8ncFeUXECx/OCR/KH2KJbK4CgeWuU9llEN0FLAlT3RyUn8bUVsryHZemOdrjjM+efoN/;25:EC0h1xuJPNoBy5mbIrOE7Y+IBxZ+LI+b3Jc43ja9G7f3IstbYQpgDSvYM3tdIPVWsvkVk7jqmcffZJTB8B2PTrB81gcMBCh4ar/0NNTOs9APhvo8vcy7uni5YHtnI22qs5w/MIgxsl7P41HhC0riJIzh25qDKR93jK9p83S6GQVBEgMrdb33T2oUFyjcjzc8PXmGgBaWP2x50FKK6TXHI6hvWcMnWcFu/v9eAv4V+OutwL3vTQij/XTD1I4hDUE7rA3hEN8tSoWAg+N9cTXA125H9uTVC4hDdaF+1y2APyg/7WjXnPiID976MDJ3SKqjlHRsVTg88igrXHo0Gw8r1A==;31:LClLOeT9UCIZZud+u4hEmF5ZpwPBcPb+cOM3DKKJ6GAfeDkhj4sDsw+weyLXc+cGUcXX9uo6E5PvCSkaokjmpZBrbytrLJAxxXA+pYYaS0qvkysyrQnVDI+xzdR1RDw15JOLjzWOBGfcYkqrROGuUNiebRAUTl9VTJqiBiD4F4U9Y5WkkNHroCnyze8JDX5uhDRkU2sFw1gL8h/EYvLr8+9VE6f6KjlQ9njJ2IPbTMM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:MRQwRQMBbs56I2HV92uIdJffmtVue9d/SpCeogikImUAlnq0sd0DA/Lr1eIQp0pM/Nt32L0tdpk+P8oS+gowQqI4LTuwgJ+ECFgABYTwb1+0MzzWRvzH2xsMnnXvRpuyX7MoLbc159/nVlMRFsFRhZWWtr902vRE4dUi/phhOxUfwAuEcv210AYAufasbx4DjX1tic7++VkWVQL25kK1e0wRA7ROztvayJ8haFBbdIWtdIOkIvTJW84YWkxQrKCX9GwBtw42+/UldsrZ/0zvptvptDOqa2WOiyF2SJaouYy9F8U64a2RgqnCrjmwdUOM+2wSuZoz5QlaHqMh9sd89Kb9nTh9tqJsrf5MkEvER6T9p35P721uOaKHatGAQWzeYlUoo7fwlBDedyo0UxqWVFlLvihfhphFJOgW3MLergmjzAsZ53kcjgvoTDtEo92z/ZPuxr0LYuC399WaTHX1R3mHHmsAio//nIalfKejtnUQDKLq578VJeDpjVDZgNUX;4:IzLaqRGAW4P7rnk2KqJg3KvUZYHWwcYiK4auReAralRuMQRj59jWzYErrfKZ0X1MmamhZLtah1LRULcMErznElgPwurTy6IoVUIF17R88FxDduH0ih92uAOyWooTkXiw+HgA1As7PTPoyPyPHEHomFCTr0b6qG1/xPIyLb9+oERnOJVYsmxCoFGdmMdruvA9yVha9qXpExqLJBb3FaZPuLxT9NrjkP0is2Dc2MV4zQiuot6/6BzXGfPRPTRVKuyQyVVsRQiON9W+94xtbVQ1GD8qLE5ah+FPdnflpJMep7WkENdEpuDSjOgdWsWS8Bh8
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323A677A29DE5190F4DEB1EF5840@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(189003)(199004)(6486002)(16586007)(6636002)(6666003)(81156014)(8676002)(50466002)(25786009)(81166006)(47776003)(66066001)(575784001)(5660300001)(486006)(86362001)(316002)(68736007)(6512007)(36756003)(4326008)(2906002)(956004)(186003)(16526019)(2616005)(26005)(476003)(106356001)(53936002)(11346002)(105586002)(446003)(48376002)(6506007)(386003)(8936002)(50226002)(6116002)(3846002)(51416003)(305945005)(97736004)(76176011)(478600001)(52116002)(7736002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:IWFM5tNYu71XjY6wOyFiWXBdrPThrh7Cyi7Tfacdd?=
 =?us-ascii?Q?Ys5mCOp6gCzA9O3V8Fd9MUiUqWToQe/k79dJNjdz9WBVVR2wz70wlN/Q5kmE?=
 =?us-ascii?Q?FJeGzNDj8XPgajQgH5/ctrxjBiWzUh8+xRrt4ac9wwcBJEtnXg3Fj8XICnhM?=
 =?us-ascii?Q?9laLkwCgwrmkqQ40gnxqxNf77Mrk+SpN/vuy9EnN0xe8PTgAPsGJa8SsP60B?=
 =?us-ascii?Q?wo6OjHCispmUEouaDR5R0CUygB4RgevDIvSfoBlC58HtyV0j1YnAm/+HnYVJ?=
 =?us-ascii?Q?/uqqX6QXo7EDwvwxN/saXvOFnUiKSVN8ZAmMSi7DteigT4aM4EFAbF/+o2qB?=
 =?us-ascii?Q?wGiLurHFCIYhFIJpn+LU/bTGG6DdiAxnC+yXs1EcbcsdGNvwQPpP9hZwny8m?=
 =?us-ascii?Q?2Olik8CGg/kguPoy6UT8c5gWPzFX47zPlyUVfjzH/DwREhf1vCb/UFXnEcv7?=
 =?us-ascii?Q?EFWGz8vxiyVv9dvslPG0mz1/hBFnVZrZScAMFcQE5UkmamEkuDwKsz7bujmH?=
 =?us-ascii?Q?Z3ogusv6aGASavcLKA0RYInP1uPgRED5ChvxCWXhMQssLrb4S7Dxz26LkiYH?=
 =?us-ascii?Q?nUpeeJYPoi4qWzSLYvJL0XtTKwGM3o6LpvN8McFilprXGV/3eodXxZWCvMlT?=
 =?us-ascii?Q?ibdreHM8uQ5+Vnkhkc+0kpAC4pta1iNBMabVlDbMjHKB1l/5aufhlZ19dYoe?=
 =?us-ascii?Q?5KRiXHAb2AqMbCbxX+tgw/zWox0p/HXwfTwlsxSZe9mXaXXKHYfXD9DdmVtF?=
 =?us-ascii?Q?HGuZN/EFyLiQIaOHYq+OnGTbZr7EA/3JTX67eIhUpSLVMZoWBbqtnJ1wJfE+?=
 =?us-ascii?Q?eZ/wk9pTzgWWH6ze+Kh863WzJHCRr2+yckZJzfhjfYjB+SuGtfA+Eni5VoyY?=
 =?us-ascii?Q?l7/mqi/TkLY2vu34DekB4FdDeDtE2NzF4YURZOUJeB00QZFd+EWPjHatWVNc?=
 =?us-ascii?Q?kFFjJenNgecD9jj+gSWjs+EvFkka+F4hWxSN42YAXF0C8fPSIscYZXrlvL0Z?=
 =?us-ascii?Q?FfmkqtWoszbKx2RS9sHaaqgRP75xW5+eBvE4pGfVAb00yk98IizS389x1+EO?=
 =?us-ascii?Q?6emtJPN7T9C2qofnrOg5iD40P50xAcTRAPURCnjJYzaqu+jWStvpYVJOkodM?=
 =?us-ascii?Q?kzcZkVOzWjp4/91FtU/KsEYoeYQTKXdWLpzl9uEsmLK6pX0nMitIEQX68OXD?=
 =?us-ascii?Q?TXfRNDQzkfXzU6rADECMayYISWWldHt/+TVUNVRVauuIOCwArNYALAI0BGQi?=
 =?us-ascii?Q?29SaSk4hl4hlL+b1hk=3D?=
X-Microsoft-Antispam-Message-Info: KcEHxgmQLzl9sajyisPUY2xF9NVfHf/HCXEu8yMLmnfKnle6b4JBLqYpqpyWfrawdmnhGaHWiImo7JXMFBtO9723RdG4Fl5ddUSfcYAvGrXo1/5JYwhfXAOKlwfE10nJmn1/CnMOf0vXbmzRCr2zxK8d4VnJFoB8P8z97CIVFoAqxDXMq1j5MeBoCndl2C6f
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:X501GDI4sK+CTxmML6zCmwDGpBhmtodtgktONZ2GEi0tG+1x1ZbgkqCm0vKENfyW6ntp62O3H3/UnLqrtGZx2U7To/y3zCUWRt/hQmv0ZmOozY+k4Jbi7PqmlBWgAPpBgvvEfu0aR8o4J0vDFI6qzH0Jf4pXZo9bTkCzjsP/WJNM2phHq/QE3A5Hbq59Lg2zsV5WGc38xnAV6GCwi+9ON4cxtxztFNW5baMn10vUiYZXVvspExaqr488gsXBkf3qt5wNRNEiKkRkHomOUfXd5cmTTPz+i306ZBSr3e2q+gKypGE9pkox4N5x6CNRsjIamoUTLMnm/wQS31gvDL8PfZjOU/QApencMgSlOmBUX/Mus0/aMBHhG/qL6ZYhnMV2WhcxD+GyF0cOZr49VJccdsp8SxQDGdMsif2yOjSZjaTixGNeZ/Y8hIXGjQKyX6sxjeHSyBFv3FBPambyCztOTQ==;5:JxkW7GBB3d4WwybrNLkEX3f94oSC/scIHlbsibq+es+nPO6Et2nee7pnvSoG6Oj1KQqtgURJH7QMjR9ka4aHlFkTNvdwrmFnPfQ9mWVGY6dKg7whhCe3ITerQZsSuevIvOynGTGSvKnneJxLnFGvfBE+MTcNapyAdsLOKaSivlc=;24:GYFfVwtoeL6aVqM/ZyYb7ChdxkOwuad1NMbjGTG6QUx63evnQtx4LvVSxTNOQR8InfUTCsVDH4J7BMSI8e6Xw0/RECu4m3n/6JujdnbCR8A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:NghFcXTHy+RI5NoPEKCdIwEpsRsdef8rN4+X8As9wUfMt7a/4BoKc/VCPqfwF93vBYKmFHXTGKMgFGS1Q+EZu8S+pXtG1mEwIbGb+ec4btUECwjGjJluX0vE43O7SyY3Uc9ht2yVZYdSREsIjl72aVCmDNa5fwanignu/zouuI7UJcwFTTCDyT+0taMombZAuKIIqSGHRuhqfByNYZsKlVXhup6i3LRdVDMi6r03Q9G61dcSK5v9DoDb5Ruj7Z0z
X-MS-Office365-Filtering-Correlation-Id: 50ed2475-d7f8-422d-cf01-08d5b31b17ef
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2018 06:32:03.7997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ed2475-d7f8-422d-cf01-08d5b31b17ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a debug LED(D11) connected to GPIO1_IO24,
add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 146d5ab..8e6bd9d 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,18 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		user {
+			label = "debug";
+			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	vcc_sd3: regulator-vcc-sd3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -149,6 +161,12 @@
 		>;
 	};
 
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
-- 
2.7.4
