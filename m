Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeEOJWO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:22:14 -0400
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:44352
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752406AbeEOJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:22:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7s-warp: remove unnecessary cpu regulator supply
Date: Tue, 15 May 2018 17:18:15 +0800
Message-Id: <1526375895-23633-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:404:14::34) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:DN2mgTSYhUc9zNSs6TJ9lBwEKaTZas0lzL7avhdI4pWw8pymA5Ca+jno/tBDJi79M4SNTVIZ0Eq37T0ZbC6Slayo8Y8PkfSEKgouqwHBAFX0r4DDV/ZJuQh+xWpGWdMgKM25U+J6YOlxR/cIsZXlj4ROGFcahZ58PbN+y5jV3WMmxsHSiX4wyit/fEbmv+onjp9mE75fEGluenYZRUHbsMliT8Uy4dGjTQzRX218tnqcCpZeItLZEAQ+gpZTkF1d;25:5snFBYF5x7jlhPIGQc6V1EXD/HYPdkNkWm1noulQtlxpdTa5EmHskQoTf8lwSCN9FxEdBHtcS2PbGn1pfsvNHGDoU96upa4lAGEQA9vbQsCnUvLH3A1KpFBz4++RHOoiljbDwI6MS9QO5hmsOSwph+/6A+zqrR8+OacrrYmSAMF93ElmACvlCfDaItliZQnpsR7QGnmGL/ZfQr7FNnYhzdL2Mu5/SyVTsV4vy2uDjmw2IybVM04uLzXWjijTbpalQJWdVS4clescKN75UkhKPJsyxVHQ2FZZ/CDQZnEeE07L4Fx5+cM/iBcRRiY7tZcyRI1ill6Jslpa3DscFshZfA==;31:y9o++drxG/jK3IuZvZORmEmoU9BJXSfYl8avc1Fdp9NejsywjyCsN5sh+b5608F+Wg+2FGkLKNHqkSkRIwqtS6Q3EfNPhMFAeiPBWS9iy9XylP/rRS8vuwl9DoVtu5qwukphnYd9WCrgzWgxFiIYsY/4q1qBQxqqW9OCt5cS5bJV5F0E0hG27+6w7FTv4jxryFNMgQ52ya8DWQ12dUkV+VpfLC3VVSiYwZjbp4+LaMw=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:HlPv4nka1r3HTNa/W5PKspa3rampfhdQFB8PsdeOwmsCw9oDfWZNR6fa5xIIGc0DiC6Rt98cD9ClG/lqQ2AmE3qraV0+SLiFMDAtaheebxoJoA7gJhj0nhPjST0IdFNVtH+BIFEhbPJckAN9PZTIG+WcZBULfR1qoIJYfsQSw3Iz88JF7l/QQK68O/g8jurolM6FGMEgBoswEipUvMF3jFFPkJ5ZFHw1eWUWRQKvJ2wuEFudjNCdixG5lF9DvOc0OIw3J25/d9ObGgz2LpClBJG6ZasGiRxA73LqUc034FDxzaZEvsmrMLSuzOL9vnXOvJQWORnLRxiHIn0Se4DRlWxF9J/k53EKV2HdfGU/On9jU0q2slA/dOXlR9H+9OefTxbeYQLV7F0PvSr414l0u+unjJ0fRy0DYmAtAswsR1PJJzvOoy0WdNyzYvOPQB2zqAgeBG8NhI4kvUZwhDDm1YVYE9Bvz+1sEKhn91MENMTRjkMtdjqOXuUSimzhBI6o;4:QgDNcty2X4tI9qGWfpwK8xN0lBxzsrx20K4sYzmCZQ4mU7kBt5ZsaIR2xiKAVOtQoqFmyBFPPYIY8i0xAxejPVtJ3pSYWgC+UuKltg+jU/nO20ZdXTPJvkJSCbQ+hMvsT3a82c0SMZuJvyMzQToLN5Z2M5NFyzn6jOFtFzdBlk5pTK/BKtP5JVMaB04FLMB+5a0yn9JiU4mTJhFeaTnqlCNkkDRsq2f/t9qQcpEdu5Q6+DerjDrd4QZeGw63Z16AV+svbJyCCTLhIRlyCyLJXlGP1oPVACvnygdKVc2qtBGkD4z4voSj4BaVYOw7f3B4
X-Microsoft-Antispam-PRVS: <VI1PR04MB1327EAF8663F95B4468AD31DF5930@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(376002)(396003)(366004)(199004)(189003)(6486002)(3846002)(6116002)(8936002)(478600001)(105586002)(106356001)(7736002)(316002)(16586007)(2906002)(305945005)(16526019)(186003)(50226002)(25786009)(386003)(6506007)(48376002)(50466002)(1857600001)(8676002)(81166006)(81156014)(68736007)(52116002)(5660300001)(51416003)(26005)(4326008)(6666003)(486006)(476003)(97736004)(6512007)(36756003)(53936002)(2616005)(66066001)(47776003)(86362001)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:eh0mV55dD6L1/v4XShwzwde3Ks/HrH/u663xmKnbA?=
 =?us-ascii?Q?UWxzayV0KLIeMsUUip5/T1dAvAmvfqNkYNcsLOmTD2MQ7Z5QLHzgrzO3PJ/k?=
 =?us-ascii?Q?/YQ8gCDY50kpSJlIJB3Qn+n49kHYQT3pdS7M5Qtbj+K6IDwI9tYLmZ40hkcD?=
 =?us-ascii?Q?L8sdDeAd4TasX75tfSVjt3pw0WlI62CBYvzyBpGPUT+mQ8U9FqHIdJciCd6D?=
 =?us-ascii?Q?by2VPzCIRiowdrxmOVAl9rTbgFE9B/EV+Yt6Obi44d09oX9VICkOcbSW2Sps?=
 =?us-ascii?Q?QM+VXzp44ZctMLorvgWs/uO2f/qcob8BKCd58bCedKEtxFndw4sNMXgVSVLk?=
 =?us-ascii?Q?zuaAot6Zbf791OhZnuWLkSPnnKfQUQA/KQA2Kpe4CKOaRAJrwidzUU2AnE/E?=
 =?us-ascii?Q?MQHUIv3dCDNK8gV06tq/C9Hd9aWFF5EZROUTTX4gC5KP6/WGFAkCak+6UQqd?=
 =?us-ascii?Q?vfj+z1uNjebaq6SNENfAptspdR/OrsP8csAD7KSOVGB3IuUOuo4LuzZ4WNjm?=
 =?us-ascii?Q?E03ZAcAgobhO1iA6HYRXieEqWKJos3Id8gMNfrkOIY+2VO26/FX/2VgdTEN2?=
 =?us-ascii?Q?zF7ov2nonc3+x+tfIHjrbqBqetSScH0dsufArwm9Dd90Ya9oQmhCMlNNwU/T?=
 =?us-ascii?Q?fhTHya9q+ZjrQZnHd+RL+dmFWeD/GAYwnH1u3e1Xoiz2E9VUCGbWdEbhdmd+?=
 =?us-ascii?Q?xuMVFG0ko5U4n0SAj6Hjlg6uc7oWVysxJPofVuxqqKVjh7SO1zuJRJGkqY45?=
 =?us-ascii?Q?GO/mw2Se5Dfg57SKBuY0Qs0y/xrkOjbJH+Qu552pnhDSDC9L49ZgO2QB/bPu?=
 =?us-ascii?Q?RkDrpi51ROSUlQhqDBKuazsR0esV14EXcvO+YZACemTD+qzp7EfEvXnL+ffo?=
 =?us-ascii?Q?mu+Omng9BG7xQIuC9GAJx28qqiRRXouAwaIvv4l3SsRBcZ06z43zzhgPqo3R?=
 =?us-ascii?Q?JBl67w/Pqo/ZUjK0tn6HL0kE5tukJd31C4uvHyRrgrCweZ/ODMd2HXKTsRax?=
 =?us-ascii?Q?ezw/ZHWhq3aMhGcEv2LgixTzONkaS58xL7gSUIklRVJY3GLTkS1GplTGl0Cu?=
 =?us-ascii?Q?LcG0kc09h3vnV20UdPf4oOFFZz7J5pkXZQYw7s6xK9TPURdiuKRjBNPxVaAj?=
 =?us-ascii?Q?VKG5yZt1ug=3D?=
X-Microsoft-Antispam-Message-Info: QyS1noVEH/l+OZd9y8Ya6lG23q3dyvjN+4vkKQVSyzUMMHFhJb6qviqP1i5DA4puW6blqp3ASRKdVFFf4UvKzkYmdy5fjUDGaMi4CMsofDN+ieq9/gi3N+ppFTE1IeDqaOzYZToPjMuzc4SPYmnmItdJbTYiu00zx2HD+q2yK/9jMvlOuP2DwKHOkmxrwrh3
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:p6RO4UEupNZdAZ4THN5aFI9u4LEgjEjn9XGW6teKWGDFCnwWPh5zsnN1jlQYepzTotqP59E8iDjkur9DDBOP/ts51g+UuYh+3ZQX6tYceFsjoSJtpsnZ5k8TiCiLUjX98pZolsPZzlKK0bPeNcFJLoII4btz5fOylHdk2IlNeepuOenw0NSkNMvnb2nHAixlp0bhPITFyDWocyUrwFQX9f2BxtSAUnNRpiSTvY9+W8BDyvdxq7i13HAy4eqX+x78vOB77zP49hSmtNLgfRbO9IueifSStPoXjXY5Y/midc8y5BQ2KOZ8B4mKGrifU09TEa4Nr7NyATk7MoeyLD3S3zpyApOzwevRJ9f3LJDMnqbb0p6qty6n07RyFXfum9//frbnzxeKTOlO00AmsH7TlVEegWvaGgUbUtWZsbOzaF4uobCCydlbMC3o5R3QIo5KhvdF2gxaXYMRVtDGyoy4NA==;5:/Pi6eferfLOHfHsibWVp+Qye9pG9zoUMwFIzgVmEaS7Wd+HN9LQruDt9SI+bbzY9qHFR5t4ekV3vuf2quICJTf770U4gWoHIA0iASuhwYPDxp4GgCEUyB7tsK9krPXzK/2omyuYNAZhUgNoUEQJsIc91HStbhfK9LO6k7wVzN64=;24:1xzcSCnmVe779489vM4QNzQ1uV/hUwRBEhR3fE9WICisKU+2hfefolAU5aSwzBJVqY+0O9okFiPv6A5PhUAzshIzq9zxU+JzT6jmcYhMXQg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:zXZuDNZmRVi4LwlNxf4/eXYApV4aQdLNudVTBt4fp/tvoR6Njgdpl4MX0JDWU/Zo97XbVYBbf96nqyTGwX07BHu0XTw7Q5rTKmk2BfkRptjiDatU72jFx61w5i/69o4d+RVhuDNm91QgKABwnAzpVXORxWkEQMnIN8t7LwPEIVg9KS9e2k2I/q/bkC6lYGTlRYJsF99viiLMR/uDSG+RiAx8OliJUQy8yc3eAazolHWQs7HC7x1GEVdIbfCwqjc9
X-MS-Office365-Filtering-Correlation-Id: 17311eac-1bcb-443c-00fd-08d5ba4550fc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:21:55.8242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17311eac-1bcb-443c-00fd-08d5ba4550fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7S does NOT support CPU frequency scaling, so no
need to specify the CPU regulator supply.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 8a30b14..fa390da 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -113,10 +113,6 @@
 	assigned-clock-rates = <884736000>;
 };
 
-&cpu0 {
-	arm-supply = <&sw1a_reg>;
-};
-
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
-- 
2.7.4
