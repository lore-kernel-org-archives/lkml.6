Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeEEId1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:33:27 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:10909
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751158AbeEEIdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:33:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@freescale.com,
        fugang.duan@nxp.com, aisheng.dong@nxp.com, yibin.gong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 5/7] ARM: dts: imx6sx-sabreauto: add wdog external reset
Date: Sat,  5 May 2018 16:29:21 +0800
Message-Id: <1525508963-7986-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:ZG9sQ7eVmJ66yTuUoRlSo2nks6HPEuRb8o11nFr7I94i8VO2dNs/OCwW0HCHTwKjCJP8wNFaxHD+U1zCgvHUg/O63zlFifLYwweKzUVAnM2U/iYBPa0aVJAmFUblNhSc8ekbcrYBRvTlRptHgEVdrGOBSngqHh/8UxWPImM0VIneP8yYT4/m4JY3VVe3PEf9BvsdLZRG/I9h5zRj8D6/HHEg1kRmm6WFcav6ZVkgF0gf2sxc0LqofWOc08ss6D8k;25:2680IAGoI/sy3I9mjd8cDi+fzLD2Y01AH3boxYuSeRSGwKbSQ2Vchmol3HYFDKm1AV9FEsTYB6xEDwVujdCXcbKZuaM0qooshNuOf/g45lpSXAvYq+y+HamTQ5tC/E7CcugBxqrWQDSY4NWqupkrtMYpoCLv7VEw+BdRelI5wXG4Mq395RYOPJUFgvGeTOGPH/mRW+RnB7Z5H32go3bpdG6X4SMXa1XVGuKnRvxUqjBQc+YlPF5QP0fBzX6l7wBdu6V6heQrVNoOhtGcasxtG/FBZ982j3/WP9xtYr8j9cAEWILOm9cepqtfqR0PMBaGiODqQa2dVFeujYtBHZ2jqQ==;31:1Rnnl8YwW+q1zyvOmBxxF3i82I2+ibkfu2QLJ1on2r1Avrqgi5FlXoTHTRD4CU1HfSyl/zLrYib5KHpqGdoH+Bwdaf8YHIc1n/n1dI/g0lF7Mdt0qrpLp0k2Ddlq43GkOK2CD1bQyz1K6+d9N87HaZbtq525TQlvYlRsQzKE8liEe7z9feL26OryeVwxZ87ll1EAg9MVGmZ2/Ps6stEyaWiRXdMCICMUwLa2C7bXMSU=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:QfMz4XoIny4uZAx0iQHfeLKtivohGaZnnn6EQnMcrxUAWTtQm19bQd1GsqRaIpcjuDTHqookIdoNaNuHnB/f1dWC/hGXh/fW0kTeYYORWt97TVH4ETfc1p2o7hY6hBWVNXvQSkZbdXpwK2lJcqzt1cilIcvptabFbyZj32Fnj0L2jCAIT1xGy8V4n5eF53/lpM+WL3JCskTSBsjhjJWMCQ8/3ZnG6CKa2xmLcyQmEJGciu4bqdMFBgpiZVb2jOj+j0niOQWhkFBdloNjFaLrV+lMnhTIDE8kGvt1+BxSkv33vaFXBLWyVz4jixlMYvdNzL+3Ji/ztXrYkBnMQeA6sc7YhxPGqgr/TAFcWtNRxMau5pVxpp3Y8hsUPTYTMpaHR6un/3v1smLj+gZrvtSoUc3QIs15HDZ6n0IRkpIsvSdcB2bFwr+76XYE72iRtUwGMh5XCNvDE2Rj/lS5argcuv6QMB3ZBm8edQqp25Rt3WWrjLFKs/SAqDB2YbJg7RiG;4:S+hO9R1lOFYguKv/hq2iBp2PgIuofwu2NKG6/V6gQuGCCAJbv3ztdDDA4JXsBKJguHCfFjaqWMrNzKN7KBwLYj6/sTAIjtcDS29IEfgi458IXe866wnk52Q2u8/VNetWOWhtjpBvP24wCLQqI6t/AO4mTM/55YqGfTtTdlNixVlctZOL/5daXWESO7n+xsrAcf9So5e1Geq4/aHflSFaKAxJTinK8Z6sKT58Xy/UBNBgPD3S+oXqrTWnPri1u5t2kt2QGCDDKGLzcWqAoCwxmZAE9RVqMDpDTKq8j7Sm481b5v10vAl0b+Tf0T8WTZyr
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315B69D772C8DA94B28FAE7F5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(6666003)(53936002)(81156014)(68736007)(6636002)(7736002)(50226002)(4326008)(6116002)(16586007)(6512007)(3846002)(8936002)(186003)(86362001)(97736004)(8676002)(25786009)(16526019)(66066001)(50466002)(52116002)(51416003)(478600001)(106356001)(105586002)(26005)(956004)(76176011)(305945005)(47776003)(386003)(2616005)(5660300001)(316002)(81166006)(48376002)(446003)(6486002)(6506007)(476003)(2906002)(11346002)(36756003)(486006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:bq8auW1M2syclFqUd6f7LZXjYpG8CprwJy8AF1ioA?=
 =?us-ascii?Q?ogXGpFU/rXNNMVvAtj6EEQzAv6/tFyzeiv0tbIMYB6lLucFpH/cFqEJbqrXb?=
 =?us-ascii?Q?lFgtjRlmE7rqjouDPTzOpi1O1OYbGgfqx0pRPSYnoKvIazKBIQQaGMp76pES?=
 =?us-ascii?Q?lsvWSPsye3KWOA2w2nkppfVXNAC2kOD8M9pLf4GX4B3MCyRNchqb0yZRKVm1?=
 =?us-ascii?Q?/XAQnQr8T1nJaReEbtgJX0zHO/Gj5EHkiazP9bLp1M7Ha8622qOcmMHIdcWb?=
 =?us-ascii?Q?VhFMCI/gYKHcNx5sraSMVLFZyk497Tx0NzqjsDFQKHVBObRXwhA78yLEq4pj?=
 =?us-ascii?Q?GpkJfmaIn3BkEFjn69NaBBpLIyytArygOtr8hO+eKZHa1W5u6X/prK6RXktZ?=
 =?us-ascii?Q?FxPlbScrVrUw7cMFRlR2/2M+zUAk4Ry7RZKyG0RmESZUI/7l4Mi3VaJmp2XC?=
 =?us-ascii?Q?IJImzLzE7w7emuP/5omSW41PgfYpIo8Zd6J98lT2UlRF13ZQQ4F7Zt6/5clh?=
 =?us-ascii?Q?RRX5qQLFAN0v2l5IuMhf2aRW/oNmJMI4hwbKECY45ZUkbY2/cQuTFKxiDTPO?=
 =?us-ascii?Q?4m47EmyfWPSdYse1wx1DYCZC+6XIK9MYmNn0VNlV3mVoHzuBUQmaygNbA8xa?=
 =?us-ascii?Q?1bdJVLU/+5D2Vf45xx2Uv4c6KMdXCP2Hrs5jJ9LV9cOyW8I95eQXLT0m068S?=
 =?us-ascii?Q?04bvifcqSygd9CJETb3eLF2M3pXy/ssL5HsthqdQl+b4taSEmo1gWosoPzrE?=
 =?us-ascii?Q?UJhEjEmSa8toGoyPzn99fQ3cEGAMVyH1bz/wMQjt6+D9UPHRy1JuNzGHe5U0?=
 =?us-ascii?Q?kBwgXM2CcQR2aorudGNJdhtnwhhOAHVDEOHsgZ1zdQg7R5MytvSAjnxvM4eR?=
 =?us-ascii?Q?wg00+Jppwf+0ExnwvG0gKozpXhK7D8dgePlJvR+lgbuj/UHr/6wSjljjWxU/?=
 =?us-ascii?Q?5aQgd0lyLUk7vD2CvXzmsbZkGXPYj9cyzllhB6F3ji0eqICykKVpwgqeSrKJ?=
 =?us-ascii?Q?F2yXYqLe4goJCD95vavLt6jJ/fnM016fmBEybuPQ5c8YbH5ljsVWi8YCMf2T?=
 =?us-ascii?Q?6k5M1gjIDa8WpqFHKdamA5QodwgZl1OeU59IFh7GCW+MF/RUygUSQ95pS/QI?=
 =?us-ascii?Q?pihvGWNsPO03pbs99K+1cYbf/EQFkmrvwY1BJMEzlvuyJI1XHtjpEx1aObMZ?=
 =?us-ascii?Q?T5lCQ7oBsgvcyS2ZylZ+XhFcTmmiFQia7A6?=
X-Microsoft-Antispam-Message-Info: yVppaWWW4BgxzNeh4Y/CwRnUAyQSEEkHEu27xOOPiPCN20myMf/itqfqo+n/iiElfAVYqoMXMMI2zcJ4mtNKaWPHo2AoCO0gNpQx7NDdw8vqZyC9wh6v5I2LDfDCvSU8MGOdTb3Mn8UkQmXaAE8iJOkbVqCS4xpBPmacK1PugYdMtuMnC4AdY5w+sH0OWKWQ
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:wjdyxPvEr92nELMEfI/S2HdNJbX8DQatWOOSxcsmRUjQ1sXpVTdrE8D/0cK9GVyagKwjbDv+7yhjTAvag9EzrHsu9TRQbVCG+GvkRjy//Z8mVcSv8DbMsXuFA0djB59Qjwso5a7LFzG4T6UdmvZhoepxjqHj+mmvdT6Zx+kAYxEIxsAzMzb9n0ehrohXt0/CqqflfY6xXpe2v8Z60iJlMcSemNkPN1pS+5t8iAI+8mPfYnJVRZe2m6H7y0ONDDR3tN29PlsIs+xOwsQKTxuWyCI+1z5AkXKJhf0qyx83iKzY5pv0O4NZ+kEmT9vHD5INegwYeUhTOJis9cl0Fl/F1PsM3I+MWoPwskACSyIVhRpddjBxPt+Bxa3MsNHCbBoWIXy9O4PcYt4KOiCAuI/d+QdIUX6kGdLUnosUPmyGKqcZ2kPZ3Z8BvEDnPnLe1k7zDqQ7jMFmYwor3r2iKeTtCA==;5:Ov2KCV9g//itaKvywYiJSY2xmE4Fj8CSv+uzjMooENG9Ypy7NKJVn1fUDElTYjsxT2OW3IRtV+pq4waH6TOu7UHfcdg8yRKOQN6DHqg6AUvaYjbQH2bc9SDbW6I4Lo9Kv/KXKbG3S5A/qfynoF3LOC9DUmRc37eChYdtrixJPT8=;24:+ID7rXtP1JefEpNSTmLC7LC25Tu0m8+9TXPRLei9SMu8JELZ552FPGVhhBo3XIZk/hy8edF1zaldUojamqZxH9AYiugMjMDvUlj0dAUMrgU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:1Ro4aeQuhMWeNMNxadPJ93EBrrpJJ4owoiOZfj1YdOeY5ie1l7NKdGjfu9rKRk55/+wfX9Y/+/GUSfzVzwarXvDaKlTR8Xx0u0GLpehRAPNtvKG4re/znXs83FqIViRLwOaIjSZk2iZuaBqKcnjS8qFEI591psx3hZJQVC6LweHYY1WA2kktMN9+GF1yBt0O1jxK4Ky4TsBxgi4wUlDKJJX54UBq3fZn3HNzMrNeJwzZRk6w25hCoA0I+jHTYCEj
X-MS-Office365-Filtering-Correlation-Id: bb3022a1-54cb-404e-32f8-08d5b262d9e3
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 08:33:12.6747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3022a1-54cb-404e-32f8-08d5b262d9e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 7dda741..13de77b 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -232,6 +232,12 @@
 			MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
 		>;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6SX_PAD_GPIO1_IO13__WDOG1_WDOG_ANY	0x30b0
+		>;
+	};
 };
 
 &i2c2 {
@@ -370,3 +376,9 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
-- 
2.7.4
