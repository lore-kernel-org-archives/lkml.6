Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeEFGdP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:33:15 -0400
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:57952
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751158AbeEFGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:31:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, fugang.duan@nxp.com,
        haibo.chen@nxp.com, yibin.gong@nxp.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 2/7] ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
Date: Sun,  6 May 2018 14:28:08 +0800
Message-Id: <1525588093-29994-2-git-send-email-Anson.Huang@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:ijF3U7VGBoBo2zYjiV0h0wE3RJaC2AIKwhAWBlUA1BHs+w0Zijqi2Wns6cvaH02tvfDmB/XUYIZb2c0t8Ju9C8iR9Ia8fuLf99cBkcLZ5pR8miY6NjCewNx1gjCg94zE2aM3e8/iyHapxL+7c1UyKBKsbTYNqhLQatEnmjiYLfGq+udwQgT/yp77TvWato1D3uG2CkHFgogLyg9kUlkoyzyxWFevbluDeln0p1aV+ZygFTPrsNeS8+JSn3+dVanQ;25:FPAUmA0ce1nbTsNne1OEczfbETH67qN7cyrILol9GHIrpiMXmuchR2uBKkOfoNkAQboRyEfZaNJ3z8HgH6CPRAPq0yf1psKf0ElRDMQlZGZkOnPzNyu/dFVvS++gyF1YwSVXiuCOu+xj9kem6B9UzK9D2WSqTW4HMC7FBhHmtGhPjucAbObcPRBTLVdltVjhsaPSb4k0YtZdXQC1ygLl1ph2E8S0akk6vlta+4Ol1fBqbMIMMq08/i5F3v1CY0YQsjD+ilmU+/w9nQrP8iAz2d9jx2lxKNN2on55+fCjm9eHjksSQJ9jt1dLdgXGaVHYPsCbaY5mToWtsOIPUqrFhw==;31:iShE1GwkIf2NjR/VjiMM9KDtpX0rDo/Bpvgv4NjgqjcCggku7PM19X7Tpe0k1ujSnXdtGUkKqGTk820WeS/dVyxJYUuegf0Ja/pGgDd+p8qARHH9s3OKiDEN3TTDPpT/+tlzlGXzodQkuJQRBayixwKYozdUi3rEo9U0fr+/9S2DlXuTfk2I9WL/sLlZay1zZNbsFgIIw4Gydp5Unp+i7pBOSMog1IPQozYDJoDd7Hs=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:iUjjv/5jRVWwPxOs/+TyuuGbaAOdTl9Wk43iO0VYyBjHhsHdRQzc5J7O4CqZ/vDURLbImrBBGeBJReLIXSZwVDg0AFJAl8KnvyObYOkTzlLtQ2LZsC8kR/QysbvrE7fb8snBXfjkjnAFfT/DWFRUoQGl7N00JDSWnFkxaYgFyBbaU8bGA+bnlznyczJN0gNkepMZCtTL+KURSP5H5rRd0r2Xv2U82RTHuvVz/HR57It97Jar63XcIo2z0A3Ps30B1QAeLA4kWnxc5+JbVw9R4kDDUCyRXAQ6pkLtxjOCJfKNGh2cfwTeO27suNE/5FADcqv8iCC8/UlowC/kL0o/vib2pLkbyXresJlYAQOtDWNGefrHY8hN2WTy7iKc4uNnC3P9gHrw8uLdOGBLFx3Zdq2ZxvGSf7/SCTn7OS8YrvwveYoLVUJrrdyOOee2RLJJKnykaKQrpyPClRcXLV3NI0OWC3Pj//QgaxBE/ANqHk54nlQfqvT7IADi58LRhb2b;4:M9jWWX7g9IUUZNIK6WNi9FIqdgwnpCe8r311zxamt0WpddGnCO/0GW5twM+jjEyry9PtDSQNovJgoOhSgVtXrdIiUQ1Y2Ba6a+hQYsVd6S3GoEmCrATrxaDvTZd2jFIWmUj+Uq7A9c79cY84Wt0WjfGpqJvNwDL/MvYJCiUClQ144bT/ZFHpWh371+wkeAYu35JAjmUSiclTsvwiaDHARtpG+AbWJAWZG3Wg48LGu7yiVzB8X5bYBG4FvfduS+t4mVLtxXWaVePD1DsYdjrNANyGmIShiUXI0gI0eVY7XQvFG64T4hgJUBWtXQCl+dzH
X-Microsoft-Antispam-PRVS: <HE1PR04MB132328637F35999B415BD7F2F5840@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(189003)(199004)(6486002)(16586007)(6636002)(6666003)(81156014)(8676002)(50466002)(25786009)(81166006)(47776003)(66066001)(575784001)(5660300001)(486006)(86362001)(316002)(68736007)(6512007)(36756003)(4326008)(2906002)(956004)(186003)(16526019)(2616005)(26005)(476003)(106356001)(53936002)(11346002)(105586002)(446003)(48376002)(6506007)(386003)(8936002)(50226002)(6116002)(3846002)(51416003)(305945005)(97736004)(76176011)(478600001)(52116002)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:OR5Hw8BgVNfFvYIEjIncp520eUnWqK7JCIV/n/CUz?=
 =?us-ascii?Q?GIk0VfiW2hWzb6iYDbSmO66s6chgpA5Bpa/rhwAINq8onn7+4Tg3/O2J/tYk?=
 =?us-ascii?Q?fSLi1VP3eidBwhaqQrqTPoIJRrCTV7kuvPrOlIJcND0ZE8d5g2aTCUKMx/Dq?=
 =?us-ascii?Q?VZxe1rOVTEBkzwH6WRi+k5pp6UVDvKam7vdgcBPutbqulW5/laOyC5UNxVat?=
 =?us-ascii?Q?o//PkwOCoYR03h+GOmrGPnh57Uev00qMVnzr5Tqm8wJR+VS/p6tCzfUtQhEp?=
 =?us-ascii?Q?wufQRVF6m7RpyH5t4y18SY2WPkmDAF83QqQY3MzKf5WkH0kkLkCJqOz8Si4d?=
 =?us-ascii?Q?PpIpxQTLcVXSCv5Xas5HhGCNDZ4FyU1KWJarY/7mpbawsRnytvLMiPoxO7P0?=
 =?us-ascii?Q?2vefyie81P81GJSMYCz+GqBO6LmhJTAGqdHa+7T73g0Gw16IQHHrV9JKzxvZ?=
 =?us-ascii?Q?RJJGDAu0pX9xKGKg98bDyaYRFXx9Tr/N9XUboBIM2LabsH92pvyYm0kDTlCD?=
 =?us-ascii?Q?WN+Ip7srFgjBDmXm4dOhCKOD1u5cvus4bR8UC3qKGTt+anF/2wiGDO2aw+dK?=
 =?us-ascii?Q?fpFmY0J8gNXS77pJqq6bmSjnQFKjoqhawKvF8HoqKfnPE0lA4s2iiaZvlYfX?=
 =?us-ascii?Q?OfFswaGosVl2pFlVP5gMobVKMnaacTQhRCS8ETPfY+hnv9Dt3VGOMouMZWBp?=
 =?us-ascii?Q?Ttld8LnUtQiZJK/66M6bJ+vNGd3zpry1X+eOE8K5IfzTzhlPUnvOxbq/V2Wc?=
 =?us-ascii?Q?0byWPMnnDSe1NI7ByXxOGFA2pY2jg+rJserH+Eq7j6WzRcLYJgpgeiSB9fv0?=
 =?us-ascii?Q?L8TWmA5WNAUjeyPoUHSPiIh77wUnVNPtnOXJKUpAVTuDolTBlRL5P4yS+pa8?=
 =?us-ascii?Q?/g4cPXzioCx7invprKusC4zwa+lXOe88FufIMWOFRrvoQhwM0fki4DnnNhVu?=
 =?us-ascii?Q?jlkBmUyR5/d/SqwKXIYPVSDc4tks9BhS07+rYN7mQD5+z60ySdMXpV6RaNIw?=
 =?us-ascii?Q?nJbfEgeJntAiIxZ1fW3ozEhC7/NMdaA7csY9VTXnJ3RCe/KJAEQZCRWap5ar?=
 =?us-ascii?Q?h7IBCsP7CV6fvgmGHcYW9nQVFKh4l710HyL/VU+ZDnsrfRwyuxk/lfwwGqAS?=
 =?us-ascii?Q?7kaNpu1etqFfJtbJGrSYeExkt3D1h9e/K/ReP/mqbuTlyVl9A2PXD+L9Plgw?=
 =?us-ascii?Q?7EMZLAAZFUq3bErzeFPvUm6AWMHMs1k2AYTAWTIU0GavSVSDyEHHM958w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: D9fWp1r13SV7Ar9z6zW8IYHG5sbKmLxgKFEIdBnZAV1xS0uVQHZ/5KFTg4bFh1mL61R6hPDxYN1aefKZASGQe4BSPxL3Z5RPK6Bw4OS1lwC8CarpQV7RdMKtgQgB17EDyavEP1f1Bt2+U/w5BVb/ATXvp0O1Is0/HQ8NBXhOMhg4j7IkNhOSIR92bZbrkCUn
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:T7DxTbsjS9F/Ja5BOg/YG0J86SoZCHWhfP2EVHOYLKGPMNIUkaRZMvO+UnjFeEzoicKX6dISIpCPvdZjejDX5+CeTVcSvyfi4UdFlZyLw/LwYFx0fMmhsz3nhiEmjz2OIP1k8aC+1WkYsjafq83vTjesP89PCT8B1/dGFQcWoxgO0faishdfByayccTRx19Hb0ZTX8FkQ6wA4bTjdx5J9VYq+SV6GYrZmrj5UpLj7QsLKltd7DcjfScAmyXKlTcnsW4xdS1rPNb8Sd1dyOuL4dR8HhZuLQXNnonKTmCONtqVY/zaYA5GCiFaR5NdzjwR2tyrcmnemYkqbYUlUyouIUHfT2gBYXAivmRbFR0d5+FgUm3CkGXMJ2oLLlN6r22bYJ4GGIUxdd3JDHXqv20mStdNKDTP0QIJF158+4LxoAciz/RrjOPs80EPJw2PwcxO/FcLZLMT0fEqWYC/mWIncg==;5:guxk2Q91qryExRJ8wJ0bUgJfWkUDU4PrO4/8IHRKidx3aZoho/7xaGK1IgmlSqrJG3Raznixz0zDWOIqO1daiiykju/JylCwnMq0EDM70zhViBd9LtU5DxlKFlxc2OGGP4MjVqzokPOA0IDVKydIPwaeW8AgYmc+p/IGnHjvqnc=;24:cjJL4X2tOOgxqfycInEMcD8twK1tPM0PuqjnHi/e9HMvSGTyvkaF+o5XJ3mh57+cOQ4A7LiPryKMlGAGI9qiFenls4DNObhdbQ5VHHAmZCM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:Nxder/sEpHnoSpn0UNVMsJuOVmARwVt58QCghnbRkB2K8POqozDSaE63U8XD6rZs7baHcVpUXHNnx5CRebWme3OarEgDsermEn2CfU4DgbZ0gFy4wMhctHST+3RrqpJVu7o4jLAc/NDZNTBjhLush6ACnP04OpMPbmu/cLACUhKHIYVyjrF0kN22MzT7d8Gg7gDrDgnDWiRdWLDkBsW813KKdORnGbpEvbHd6k2MzVvENErB9/as/Xb2J5Vkh4es
X-MS-Office365-Filtering-Correlation-Id: 3a74d76e-0ef3-4e80-8f0d-08d5b31b09a1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2018 06:31:39.7988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a74d76e-0ef3-4e80-8f0d-08d5b31b09a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX7322 IO expander support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V6:
	remove unnecessary sign-off.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 1d8cf0f..ae253af 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -254,4 +254,11 @@
 			};
 		};
 	};
+
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
2.7.4
