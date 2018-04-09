Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDIK7p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:59:45 -0400
Received: from mail-eopbgr40132.outbound.protection.outlook.com ([40.107.4.132]:43972
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752369AbeDIK7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:59:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] dt-bindings: display: atmel: add optional output-mode property
Date: Mon,  9 Apr 2018 12:59:15 +0200
Message-Id: <20180409105918.20792-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::37) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c461efbd-1fa8-4b2c-4e0b-08d59e08fdae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:u+1qogVg0C6Sep+dHze9Lp+7SvPuB5FyVN7G7vhf5oyyVzmx9EDEiq9TsjAIECm7oPTIp8k9mUqrGl9WcVUrG934iXZkeFNVdonEY/t9T0rBjAos5fgXCZL3i5bvayAGswzpSu3Hoi3VDXFOeGP6Ja+WHC0fd0EgxQTJ3Sjsc4ntNJCK3ZvRpIWRr66VyTicHnI/5S6bMo51X9db9xLeb3gpoz6lwJmuM0iX6DaySsWwvJ3D1rxowd+2xKEJxxNQ;25:F+agnSm6AQvlDMRnz5l6KGaHTKvbv9oz0IuTGmzm+4pUo94WcInfbdM8olysu15MezJO3WFuBRZUzwE1UXVvI3OAHZNM924JicQOVRYE4YS016F9Vuh3jTlxjTP+EUTWeK06P5fbv3THaV66ccj20S98lqZwq1WnJn1LOYSc1jnhjxE3HKOT4e+Lz8taGQ8TfPjHvNW/d5vT3S4j5stuzPATFS7eywnoGL+G8U1DP2WayMLCoqiTUL1hQSnQoV+BhuIlp5ACSxtIGw+FIV1nRK4SdDWKdaomecGssOoydSf//0trSCWE0TTygnjdL3r/T4sEr7ssBzjIq0ug+zWRhA==;31:h7YPAVHn9dJ/EQSHt/6TYD0W5Z3o0FyGjsT3kDjhNbjgsKyl19psHT/GCnary3ajRs0GBIX9XSWFJr6lrarFSJ0ZuAnjYONeq+FgAXtcCnCHpvY/Ej1j0jhsBKPsUv94DJJ2Po8FD/wVARHxI3B5C3N+/jouWjKqzbb+mjGrzol8FveuC5VsA/XiRjtTSzyEBgMTic0finq6CClzp7E3hOyXtMPte4yyvfKXVbulG6Y=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775EAC48539D41BBA1445D8BCBF0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:lNCtaEM/tg52nKZKdtj52rf3XKNMzaXG78h39Fpqiw25RgfGsuU2wwPpUigAt3yh8eKG22gKsiXI6Wu9glf8B9zDlcdkTmsL1kzJLXCCHFsDt/5YCTuuQYwHAIcD8KNXs4TDAJzPthAi861XHOS8m0KODgrTFqJ14MqWBGpKD+gPgN8UPOCi4MYVtCTAWS0RX6t/MyXtp0MVcBrr7FSl4D8u1lXGj4Fsx3QdNF+5JhUSyof97KQbU9FOFYWj8t2ka8LjJcmHNRTlN+6ncA9o7A==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39830400003)(396003)(366004)(199004)(189003)(86362001)(68736007)(26005)(106356001)(478600001)(186003)(2351001)(16526019)(2361001)(74482002)(446003)(48376002)(16586007)(50466002)(76176011)(54906003)(386003)(6506007)(316002)(52116002)(51416003)(6666003)(6916009)(2906002)(6116002)(1076002)(105586002)(66066001)(47776003)(97736004)(7736002)(6512007)(7416002)(305945005)(11346002)(53936002)(5660300001)(8676002)(3846002)(81156014)(81166006)(36756003)(8936002)(476003)(2616005)(486006)(50226002)(4326008)(6486002)(25786009)(956004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2775;23:j5UFOmxhkN20D2ZAcDydSvtHKuQ54g1By4MysU9?=
 =?us-ascii?Q?yAqSINDrZmP9Im40UJ/2xYUGmc15SOSRj6lajsDuT9VuCLclctFacodcxOYY?=
 =?us-ascii?Q?ToX4tqQQTfxIzlH+wzjtLtMGg9WqC3h011fmPV6rzzRIkGk05ZQSUiEWPkBF?=
 =?us-ascii?Q?/1+FmOFVG2b7kG0qBWYtUomvcgpXN/9J5jpV8XTLaZpYDOyxqGfly93ZZ2LS?=
 =?us-ascii?Q?6TwHSZPRAhV57aD06TnQPX3soZmDPC6HLRL0JKdTTTIXU6n5hw2/W+W97cMN?=
 =?us-ascii?Q?QALMSFN4JzLFh61Ga8uCfepkUCX3xNeliMM6FL+cWb1q6ByAiwYTBmiNzKaZ?=
 =?us-ascii?Q?tC+KU2Cjn8m8cH4s1aim8xoQybp/qzy1IFY22dHGr2zlygZIHgzCQ75ZCdew?=
 =?us-ascii?Q?ZvC+tl/UzJBZe/ijFHLtjYf/PXuuvLilmvbXkUl/Sh5/qOknMwyqHQV7bdKD?=
 =?us-ascii?Q?f1eGHPNB6LCRMpY+/FrRnW1pLdl3OOTt6CIjE9OjLTpa1jCB2fezc5ShX9UK?=
 =?us-ascii?Q?z6q6ziYw+GmxjjzAyqgj21JFG+hXp3RMd9+sOmdPg34PRQdYzK6aw4abEp+a?=
 =?us-ascii?Q?FN6G7Oqw7XMIhYVuAoTk+62gLNI8lh77vIZajf0Ej9y1thk2IOgx1k2/nYxC?=
 =?us-ascii?Q?O+cXid5KOLkfGrPs0MXLKaYoDQ5WMxeR2edAb2q6BZ8ubfVrRIrFf1QRsLy9?=
 =?us-ascii?Q?zaNgwa+8qJ9Ov3MagUkrXRaJPmwZidUmT+2AtmpByI9cQIawGHxzWqbxm8YZ?=
 =?us-ascii?Q?pSWBVtbzsq+5nMkTYI4l7NW+4lERYdVtpTbT1Q+a4ulOOnOCMVPWpQc8Urwg?=
 =?us-ascii?Q?vyB8Gmzd9ztNupyj38eKtX//tlG3xs0mHE/48s3iSeoDDwwPcCpuyqXI7mKZ?=
 =?us-ascii?Q?EmyGQjTf3Ez/bW28HIQGf7jXGtvy5lTuAJBRX1wsSmzsex8n1RwEq1djpfO4?=
 =?us-ascii?Q?OvhXgaJrzeKmNQQhF7BITxM5pkBfMYzoYuR5nMPsd2nOai55qk0jF6eKcCug?=
 =?us-ascii?Q?QmS+rZekBH04eGjTGwbLAkAocQV486H//wGuoVEFRR+j6OeycJIZL+p//JTx?=
 =?us-ascii?Q?/uc6spVIJKpJBwvBc5ZUJZlqDaaJbxhu6iMoxSDyI5OL/pgLpWsaY2H5Z3jN?=
 =?us-ascii?Q?5Jxt6yl8r6JsPGzov7+B7p/kEdT30DMHm2ukOu0wIVrhf4OYU4ZpqGYyoWdR?=
 =?us-ascii?Q?oA5fje5jEwpxojYmnNPXoDWdEyfNdHsSPoxX0kFHBeO7u/53PCeqiF/PZlJd?=
 =?us-ascii?Q?shRZpLXAulMaayRLU2di+ThsG6FVtdL4tx/ittGKJLXCG2DlMCtV/YDUCvKV?=
 =?us-ascii?Q?PawNEfV/pjlSTquisijVvOY0=3D?=
X-Microsoft-Antispam-Message-Info: YDj8LXKYf/Z+kiQzbGiLoBTc2hfnlPHdiLd3FyPl7iec5JC/Up+I63H96qUPSixQ19Znb2/Fv8VDXIUs7AZw6QE/AFDsVibif6Nuw1qXCTohvS9+YB1rQQ44ZgcofSwHrFLLBTW/hMwj7fGGa+9bRB1CMqYLsx8PCT2WGS6ubP7dZLkWnKs4oa09kRe2pS68
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:HqaM2gkxPiYPA03OqbslbXDRVsKdGf64Wi3T0dgNFHCfF64e/fft3SKvm5FXagKjs11DFV/iOOkuXFO4G8uXKxVtl3RQGpMI10dFH8HntjtQUqFUQw8kCrhVnj1d0fNxs/sP8SqG75mWqI8PnU8RiyHXGtBd2TBLn4wBlcZx+bpeeuEk3SvwyQ8dzCmMG80K9xctH+ByALM5yJnQ/6kPK51D1w0hlJXgBuuCBoTu6OHVj6pAfh8I69obeu65wkX9BRwAHoMnr2TLOzGbb9HPypIRCBBVPmqOwDUC9b4eIfV4MG6r6YjmXq9mmAkPanKVknLysFR2o/AEsDSR04sgdZBnqlLQqDI29MIqhbGs8dNJr0wZEj44G0LTRF/wcFb1kWqwvhQgcyuHji7tma0uwqR59nPioLYO5N0sZo+T40EEUxpklrjTuC5Zgtq6sgLeEKC+yYGS4KwaikYkDyfYvA==;5:Eb8AvdkQkqCr9GNgaHEkMXobSyiQZoK2W4UolehKj2jIcvu7duOCqfb3XhUakZoojT7sl61sqqecNdIVIBmEIRxNzQ5Ieilzlk+4hkJJQnjgz50DtoMrio8IzuzMBgBmxegWB46UAPtylhdzHyvf1BDVP3T+FNx/owBQFu2Ze3I=;24:I0aaCCG6zH+QC1QgxJY1Zl2ShZVn3mtLwsh8FB6T4kqpxlw4Ob/1j0DRRkZHfVvJzIb4LrbCQgSckAmTZV3eaWwMpFt8MLvKe0XHVshLbFs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:pncgv3UAy9DgoNLBJNQa87mC5nnWWGDE9KvyQI0FgTkJdZY8w1lAGZFtOiL6D4nURBNB+gBrtp26dKZxw0QGxafMxZC5XDQ+zZSbmWrMML+SqMyESs9NzW4AlLmSTTdnXpYF/WuUwcmb6SuChhRaWAL599WWmGeOxJokm1KWugdYFssObQ9/leHb8omjb9L19zg3TKOKGbBQ0zGdfwiGaW5vQl7odKnwk/unK3IVMHrFr/P3qP09tpn/FjJN3HUH
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 10:59:38.9529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c461efbd-1fa8-4b2c-4e0b-08d59e08fdae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful for beating cases where an output mode selection heuristic
fails.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..dc478455b883 100644
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
@@ -10,6 +10,10 @@ Required properties:
  - #address-cells: should be set to 1.
  - #size-cells: should be set to 0.
 
+Optional properties:
+ - output-mode: override any output mode selection hueristic and force a
+   particular output mode. One of "rgb444", "rgb565", "rgb666" and "rgb888".
+
 Required children nodes:
  Children nodes are encoding available output ports and their connections
  to external devices using the OF graph reprensentation (see ../graph.txt).
-- 
2.11.0
