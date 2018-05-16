Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEPEwG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:52:06 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:50240
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752172AbeEPEwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:52:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7d: use operating-points-v2 for cpu
Date: Wed, 16 May 2018 12:48:17 +0800
Message-Id: <1526446097-7111-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYXPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:403:a::36) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:guRwWzKBjhho7IZeSen7JUZfGUIAlWCBiotXmmcAovo/r5gFolhnLjqgtrHSPSrpynm/w2gbuvp/RRMGkb+mDgfnErmWyG4h/0DRqYNr2scx2YiQj1cJgPCfGQy9v6MdfYgJozxtbm7nqwRg++gNkHFxUeJoWMq7K7SKi6B9S2WEMAOaDRCZyJs/d9cM1dQ6xLajU7trjlIatnEg80iI1zsWeyvrOCP4aUWPKGA5ITSrcHcHhIaZ+V19jp1l3z9r;25:6FfNYw9Yv5twmWmHk1VwiiSd26OEcKtufxeDmhMiUlzYrFv+s7xgGrrc74nPEIN2ItZvt0xnyXYLPJmYis2qZX3FXBE2QG23lr7lK9Rl/aMhIzbzI7N+lT3uvcvbL5XnsFSSU7sp59MXphuY3Py0FafSnSSIPzMzU7f7EVh27JWepB1WijuzNbPAB/Xa0A5xwzVXgrmTDKBrmszgIZ468Wj0S9uPz4//PtwILy7UPtUN6eIKce3JHQrYt0hyKs7MYqZSsIhifJjbTUu9DaWMf9dHDOd18wytfZ23eZb5y6SJ9Svo0jkvGQ+aVLmkp3WO94i3pgMD6O6UYVwh1o57eg==;31:qo7frPSQ/iKmTkwBT06IvQLcVcTZH0xPN2atqnfGczJFmonM/HpRJLJOCIZ0vBQldHhsnTXMJGnPZ4H8d04f8yWU9qsbSvLXoj5Ogrf/qMHrzNvVJK1Jyd1RgvM1gpLwFfXbfXAVEGhyoaGTpTKuF3aubzxbhkVPn+UFgtvV1FRF6iF7fqO0WNIOslwXUFFxscZfO/nBZD2RXRss0V9EXunv+iz4NG3gRyVB5mZSX3k=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:9POSkDXAzoP1yWJwOl84pRn5FdH/b9oH3Xc3AWHdE1SCAcv0uChOKgKwffUJLKn4mWkie2/5+1AYMq7Xf4bE1/FVX7Ky0NXl17pxW2qr3S/EO7QqOPBnoVG9Ue0WpOaR3LIAkgDYSqFc70U0nSKwA8VRG46nxkjSGTWTFQWvCUGxpBRIV/Gr6q5sLC/VmP2a5yhoTXu6BR6bS6BP5vUFWlfbs/Uyxg1+UqUH/LhGNbD1AxgKokHmdjmRjXYZfT3XN6MeIyb++yHOoFxu5KI/9RLg/XMs7ur9NqiBzn8BEsvgRiElhnOpbF50UIGomRtrUc5iM7UhyId1RfhlRoCRwJFvtX2uEM0tG33yDKOQIo//3taPGnGV2dkveiqxFTKgpbV09rBKmk6/qsDSJ9X6IP5jtKonMEHrRFr26qi4bE1E6Cndb35WloLs0TQIZwZ/miyheNX8AN8sEFrNGd6TmmarVyZeopBkRLYj3CEnzcpGz4JJDWj969LgGyCzHMC6;4:oR+mxsJrW+7bRL0PqEa/6TYIMhMEUlQTAa1E0q9O4OrUOgaTLJTZSiY7J5SXAKkhc9G5sbJzofm1/r1q/rETwBbyYVz9Snv39tTw3w26HC3z6qE07JqkhYoIkMSWTaJQYATyoQimQhc+VUuTfn8zKmrgG3AQvPRgPw34Mpgti2UErhmzFvsCEZDDMpoNApPYwgmdF4My9eZNnOGDQ1p5/npbXfa6LfUCoxDcLao2vVLjxYrnJ9Hdpx0WIsMOlId3uCuwGKjHj7xcxN1KxnOQwdpbBy5vf7pV2518sbuCz2YRIRTSyjpTqRzUSkpMbGnV
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315DFBEF80C8C38F0480487F5920@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(396003)(376002)(346002)(199004)(189003)(186003)(81156014)(26005)(81166006)(6486002)(6506007)(97736004)(8676002)(16526019)(68736007)(478600001)(386003)(1857600001)(59450400001)(25786009)(36756003)(6666003)(48376002)(2616005)(956004)(6116002)(476003)(3846002)(66066001)(6512007)(8936002)(50226002)(486006)(16586007)(316002)(51416003)(7736002)(52116002)(106356001)(305945005)(86362001)(4326008)(5660300001)(50466002)(47776003)(2906002)(105586002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:i+dLa8KMqwQIAlJrT6svBRbVXF0nvAA9eSGqgxJW1?=
 =?us-ascii?Q?iPKuuhGnSyFNDV4EvEq1gzpcPuGyeCJZ3LUx+eB9SzH/bs3JMySwWq8xae8H?=
 =?us-ascii?Q?m9WOAxX6W3DZMDdz0BIuXpT+4TgGRcIaptk+7E7gMZziq1T4pPDf/MwVE9CG?=
 =?us-ascii?Q?8QiAIx32OANBhpxjG0wjpM8bsJQnpxJC3/CmYEbiqpLfomI/OhdnpuDUcHvb?=
 =?us-ascii?Q?l4yd1QRGeMwEbw5h6ffWFLPb7S0DZ/MkWrketiMRslx5qxu1zxKbmy5iFWiF?=
 =?us-ascii?Q?zZQHKCfvwTKi+ACjCoMpE0LXL09Nnbf3MQNDdk70J225YkT52oqQsU+P3CAM?=
 =?us-ascii?Q?Xapbr9Gv1jemqfquQZpfxD/4UrBHZcHC61OwwhVPMMenP6v06wNKWlbVRtgA?=
 =?us-ascii?Q?0LhHenQIh1wiCWSmAKIp16ya5SvYEZ4SIoort9DXYiU8QIsNUryFcb5M1S3+?=
 =?us-ascii?Q?XHqfOFYuJs3KkXWJogI5w3aYC6pw500FX/eHOdqjMTHvc1QXDuFDLUIgG4kY?=
 =?us-ascii?Q?E5lD0JvG7+MZhrzKiUrzZy6CCa166mAIjndrT6JLlSxxoPPHpgQ31EcUdwbR?=
 =?us-ascii?Q?mryVMmXHKO/yC25kkJHCvQyPcmC2hpyY96vyBvHKZr3wrui84UxW13x3QuAG?=
 =?us-ascii?Q?r3vylBjqONZdaAeFMNXBTW94zVYxjpClxbd0V3U435HT4McbQlQS13T781rh?=
 =?us-ascii?Q?KeCXasymgjg7SwDY6mohuhU69MCE9FOWn2yx2ic0b3vypnIhoLpR5bLT9lM3?=
 =?us-ascii?Q?+WFVnf2OtKR4Hu4rop2MQHnG5cxFPoSq0rgPHsyJprdNA/icnA8pNI72bZNE?=
 =?us-ascii?Q?shfC4acbuHvN0euTbOBWDDQnNFBsO4vFwK8FAUVMsF403hwv9PjlRLEQvKiD?=
 =?us-ascii?Q?CgmKNm2h2kJGGOB/neCm9NQbcQ3cM6NfbDpgBZsDtGdZ6jYjOvNHRhWu1B4k?=
 =?us-ascii?Q?TmtN4ufa5ZavxenwyDQ/m65r5QfxmgS2Gp8lMp86u17tze4YQNPqUhbBKwzP?=
 =?us-ascii?Q?UYE+W3thbqu/CrChN0xrKkHjq0RSpprpkridnnKwgOM/efFCWd4ejP+ddpCM?=
 =?us-ascii?Q?sFDbPHH3WVDndObg5A71xF25dTFo/6fGmhIsLpHOs5GuWRNA8Gj9zmfsMpRr?=
 =?us-ascii?Q?WslEf0zvYli+KEfCAbBbsJIr/8tYhL3RSwf+gH/hdKoqKlqQdRYSg=3D=3D?=
X-Microsoft-Antispam-Message-Info: JcKrms9dNUFhBA4TzH3A1sVdj+NXp4lAHuPqd5dJaoKBcUB/I16STqu9opt2HfeHNLP3ZKydDwLR4oYKpcEc6uwIUzkCxH4zgZ2xFNGiiCC+UVOPaYhkxdDzWHaixMqr1A0+CvWDfA1Bcbze8/d8GtHhLV8vBrmeSRnHOAkh2GV3B+DmaKqSMHW2/9Jb/gdf
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:VLAA4ok8BJRnXBgUlGXuH0KZ1KsxbL2CoY3odwRhprharJs3O8KTQglpX8RxgRXMQuV+Fa1jN2sj3wkpalA8+w1Er/W+WAUOFHPh3HFlfEGUg3sePxD6P7GxHYxnFeWWUVVntDRqf3ng0Y6gJANbcOS5Bwxz0N3JujNzoWQ/XPIT6ufMQympRh0NueFXE6rFe5JaF9G+fVd8XO5v1gYuLAEPWnn316fPUw+hmTTo79pK92lVIN0MHmH2qcRjwMbQLCjihFNhhtrb+OzVqeekyXtd5D2OfpWt3Z/OmKeAgXSDG08mtfu2/waCRiL3jIoW60yuxmg9x/gGT+/l8kEPGO5e4S4nCdHCPQxsNfjiuFAOP7D3frSIK45i9HhQDUKuwO0fhEWCnjJ9r0PbxDG40S4l40VU9uKSL/6UPlLhLDUHLU63jtcltwZdQpWYVXfU++NEY8eNioznY+TE7Tdxsg==;5:QtGaAsZnKz1H1Yg1zAFjlD94iv42zRbqtIhvY8CtM9aQdBmS94hFQzU6407YhNXQRQRhJEMeOwUmFP7miA3/t+iL3pLYRfc6uztqI5C8aK7EWMZQSeDkV2uCvH2Do53V9Noo72xWE2tG3bJhZ8APNYn73K1eJIzyQqe3gp6VSUc=;24:wz5jJbosuJ5HTEBVZdwyYG6sNRi8pCwB/e1mviVp797VaQg4rOaIHc0cRSOhnuXBi2YtvtuqUr3QlA/vEE2qRcJi0WbOGZEnDdSX/wAeDfM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:poYzsTtpHTQ2QhCuwu3tBpV+LK6bmhl/vjo4pMloMswqbYcbGAqoAdiI45fcixRG+MtRSZrQ268QSpbvdnvw13qNhV4nRZO6S5CulAOQwSBoUOgIRsb7UsOi/AY9QO9GY6zfc7Psw3ooVx7krhLVjqwYrzPcBMwnbcVrvqcbgSeP4anGAV2zYpcORPuzxfynbeIsxxrvLWPAmWeqnUZ77zZdCOSiRT5ujAPlz1EMPD9wFk0hqQ4/q2IT5MqSkBJa
X-MS-Office365-Filtering-Correlation-Id: 6b491942-4ffe-4bc8-cb3c-08d5bae8c29c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 04:51:54.7523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b491942-4ffe-4bc8-cb3c-08d5bae8c29c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses "operating-points-v2" instead of
"operating-points" to be more fit with cpufreq-dt
driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 4c9877e..28980c8 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -9,12 +9,8 @@
 / {
 	cpus {
 		cpu0: cpu@0 {
-			operating-points = <
-				/* KHz	uV */
-				996000	1075000
-				792000	975000
-			>;
 			clock-frequency = <996000000>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu@1 {
@@ -22,6 +18,24 @@
 			device_type = "cpu";
 			reg = <1>;
 			clock-frequency = <996000000>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <150000>;
+		};
+		opp-996000000 {
+			opp-hz = /bits/ 64 <996000000>;
+			opp-microvolt = <1075000>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
 		};
 	};
 
-- 
2.7.4
