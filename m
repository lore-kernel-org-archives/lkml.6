Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeDIK7k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:59:40 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com ([104.47.2.139]:22208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752369AbeDIK7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:59:35 -0400
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
Subject: [PATCH 1/5] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Mon,  9 Apr 2018 12:59:14 +0200
Message-Id: <20180409105918.20792-2-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: e1f7efaf-434a-4e78-93ed-08d59e08f965
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:AGAjXvaG2m2zsYGU9dDB2/+fz9tCAB8a5hkSWDpkri0x8AqmcDb3Rg5CQeLXDCX7dksk0OHVKdhvkkJqgC759J7/FUoswRcY4gmJoiig6Nhwv4dXYkzEmmijb6imUv1dFBDEeWPfetL6FY0JWcYK04qd0lnT3e3AynD7YByXB+J+FqCzhK/deD57mFK3s1DWejucI8RYFiIbCAJcQYVhIQtR3ulXoMmjiQ5noz+i4p9PyPp19iIx5wwVtTio+lc+;25:5VT/AW3UV9DN4mnmwg7MPiFFaujdjhYNHYyn8+qabkhzl1opspDMTtlsSbpEZEcxs2pK/1gS9vRBvuGhCJDUwBD/WVtaDsNbgQE2VRgOrXNRoejrhU7YfVkqp0QnbzoXDG2qQJVATddoUf7yDSDM2OCr6mh5kyMspn+4P4PLE2pTUazZpA2yO3pufH71l72vVr52b522OqJHutSPZRiidPC/jNfdvnvCKLnyQeVFTkPWyf/9seuqgXGlNDzJ8B0kPVXSeTIelL4eJ7EJlTWHzo/0dM7mpSVF7vZruRMQ0bWIAEu5XxUfV8MmnZjxaDr2Xa4Zel3rov7w8mWIi3nubA==;31:0lfX5t9OhQTYJclMKnbJXzBDGMhI8y4bhxZTIl+thikH39CW0hVxD79r8t3k3OGqTqFedHWq0kOzo+zUlafs9Nbti3vPtv5smA7YuYYqeoJE9tvcuOWSJsWbg2+LHZqTpGk7BHsWukzLcGF3t9dfZaI7GrRKubqHldx306SlcpggFp0HqlizR/y+l5tFMALVmzCQb7vTeGrwoYToPx6KrrujqnI6L469e4s2EsIoOWg=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775FE89D83B6DC4334B9A4FBCBF0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:/GpeLYlSjPFaGSPzxhRahzJ6mRGJKmajJjNblv9ywhVFZuJtsrCtg6XrHGDrKh04zwrYzznJFZQOwAVAkqpBs9r6ZIWuRspCFy9yXTG33l6ghvNhA8OrPlEb13cRmqMfYmtWDqCMI/eDYqoQprblZoxgNneXcCFssZHZj1nWzpfp57HsS66vnLO/uDWJQWdc1jyaZpw+Epzpe0tENNuOayB9hGBpL31lA5gVc9EUyIoFJIhIqytmrRIg2V5xGKHugJIVlf4oEUCA3JGEaEpCIw==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39830400003)(396003)(366004)(199004)(189003)(86362001)(68736007)(26005)(106356001)(478600001)(186003)(2351001)(16526019)(2361001)(74482002)(446003)(48376002)(16586007)(50466002)(76176011)(54906003)(386003)(6506007)(316002)(59450400001)(52116002)(51416003)(6666003)(6916009)(2906002)(6116002)(1076002)(105586002)(66066001)(47776003)(97736004)(7736002)(6512007)(7416002)(305945005)(11346002)(53936002)(5660300001)(8676002)(3846002)(81156014)(81166006)(36756003)(8936002)(476003)(2616005)(486006)(50226002)(4326008)(6486002)(25786009)(956004)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2775;23:VoD97itZH/01xdgY/jB3YzeJHiEf94+djFL5+QR?=
 =?us-ascii?Q?vQw6L2gh+lNG1xW/bNX9qjPIPqLzxtFpU/x1X7o1JUCm0PQF8HNRFT6KSoZy?=
 =?us-ascii?Q?1HFmuISxHNaCqB/QrUN6O1r2mGzJakTBcM5oMsH+8LuawFiDezhCJNGH2HVL?=
 =?us-ascii?Q?enUXvHyJ2I9OlL3f4yDOH/e2po6Z/7nhlJOSsQc3jBxOlgk+DsCVQWVfoWN/?=
 =?us-ascii?Q?WcLFNxx1Oi3TcN+P4TWlUMPnuRTdZ79VQUHKeSfVteOYjwDbB9dKuLHxYHs2?=
 =?us-ascii?Q?X5PwAQQX5gUSc7ufMtedTr4i9qT5UAjz2hbnpJy/NYTz83QuWTTRS9WwmIDm?=
 =?us-ascii?Q?TqWR8IYNTfOJDr4fyJM16kzRktnMobs0LxIcTCKeGL1LbTbeVKtuzKw1JC+b?=
 =?us-ascii?Q?UeAY1UJQKwn6nYr2oKqBZ1FtAKYPkG86XDIZ3x8VeJrnqHfXdxS9HAy9SWIM?=
 =?us-ascii?Q?ZQOWROvDCvvTm6fvX3U3AUIfuoKlaXYFJsrQ6+QBNIfu5uo+ZhnPFt07hVD+?=
 =?us-ascii?Q?tEu/6tschkM8hJTafo2epuQmhtES74f+eQQVoLeH4keIBc3FlZ0zJipmzHXY?=
 =?us-ascii?Q?a+LtMiUpdotD96E9dLFj/mcgzWILMO58HrKnf32m1OFqyINV2QHQ/v7r28AU?=
 =?us-ascii?Q?3rLZVoEhLgpHpEzvidqokz+OBTJPHkghBe0wDe/tBdJhVmOHGnWpMGUU43k6?=
 =?us-ascii?Q?gMd+DEsuPHTbgpfMUJYkG4iRFlkIzBCBblM6c4mRX7AM0qtXpy2tKuZBgAUD?=
 =?us-ascii?Q?iOwlyKQX8JWGRhcPo2kmDV0fUiY/J3ojNmSx9GbXci4cIaMiKW4WeWAzpJQg?=
 =?us-ascii?Q?mWefAJq6Ka8e4DazWnRA/tYCoiUIK/Z+V8QIcerCnv7oPVggDm+0Fce9/x2l?=
 =?us-ascii?Q?695onRfc5rKS7eUK/i0YDQPvzNIWSCuTWqN00JFslQ8H8x8K6GVrEVTRL+mo?=
 =?us-ascii?Q?KzfWXat0LfGWGYA0T1NX5ZJe6R98VaGUE64HzPQ1339tV4LltMFhOkyKx5U4?=
 =?us-ascii?Q?iUf1if2XfwkPruxAn9RnSEX3g8OaqrCd1v6UV+zl7hTxqyKL8utRdUj7ca98?=
 =?us-ascii?Q?p/S1Ha1bOn1FF/b2BlKsJpNG3ONcMF15YWfF/U1BY7XZC5wdcnfh7ED9OXEZ?=
 =?us-ascii?Q?lBEKTWitNFCgBGwAGz1tpjoS7bXX6+sdAZkzjAhYvUQhvULPpvqdWxKyZgo4?=
 =?us-ascii?Q?zafTo//a3Nr9Fmqm9O9jZutXyv+s70mvvPzNOUPG1st9FntJNRgLh7mPyK+t?=
 =?us-ascii?Q?OJ775PuwwML0MOTR7AdHXvtUo+DFlJWX2XNQZNkGoFJfXgJ21wtohSQ0iMxh?=
 =?us-ascii?Q?urSVLUza2h3jpxL2b6ViWtvGDoybZTCLyTARjv2cUWyYw5B98VG/J2QXP3T0?=
 =?us-ascii?Q?//hwmdQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: VGcotP2SBafi7HaMrpigCG2hnTYEBEQeA8AqEQYJmKGf70x54+fIxfcu9PeulN3w4bGDoynSLAsi9fbwMddDXFtZE++UUd+UXuwx7Y/wYn/HPjz67ErGL3OlwDzsrfemdUxiYvJsoOfI5ae7eq7ZuwYgOgZJjTpcI1lw+q61CPz7w8+3RqThx0Awba4iA55/
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:aap0WRp2yhhj0TxxcJynAw/KOQFANT7zCram3L2c8B6zLycAHARpOu4iqRQzKndg/dn9PrfsbN/YP03yMohlIHcbe+vwAPhYam9Hg8WvrZp2J/byQBEyx6O3xi7VQ3GGoebsgUM1DHNfdCmuOvJEwVvLJeJJQ9wl/jKSCnIwDfsfbXZLfuaQhyesVpzSdS04Xub8gapjzMG6iCSdUFJxkzb5yA73ostpUroB9/5txTF+EQzjML6IID7EwPqUKkdsU9wYKKkFY+L1cmTkr7SJo14bppVGhWV7KFqGAGpFgmlYBMyQOAwkRX7dMBuJUE86zA+ZEH+QtExFMd5Zkouqyd1P6MvTQumUr9U9IamGUoZU6uZ4nNJFsPvB1BP02ay30qaAJC1C/d2ZGj5F7fW4BqJfdL+ZjQoM8J99Y2qYqJz0sQdjqM7bJMrX78N+KLOBJIy9INIoHiL+LJBLh3X/jQ==;5:g3+CfsbHZk2UazBoDIzVwiA0zBTQFxan+cbN8m6o6n7h+6OM5mJJGmPFzc3rqXg+3SwkjAfxPL9Jv0qip95nVCnvaz7g368/NwtPt9g4g3U8HoBjcmfT1ew0OvPmVpALb74+29HQvLeS98DeqAggI00d8/f7Pq+o27pCBZehHOg=;24:vTG12E235WJJt+dzqrI7b+FQV2npv/pBxYIeiG6M4lQdvOQ+tS4OJK3z2gU37Sk/zyUuzBwZKi49xfadcpNBHHzIqHX/Yb/6ppkn/pwZmJg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:GRyGfD4ONdjDYLck2NmBhQAJUNiSpDmQdSDxaksOaRN8+MENQFIuvhQkp+sjN2pUlhCtA0+kfAStRWCUVkjolP0netxQtLRS0du5k8AXrGrIO1XJUBb1d6HGhvvLWhonuLDa/CrHT9dtBdHVHymeoMWAndPdiTxBtCG+gDwuKqVsMOTaCta/ZjAZS51rjqPfWJjk6zKBfFf8hfiv++GijB4Xw5hE9y9witvu0T3csTE584Oc2MvqPnOPevTHncg6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 10:59:31.7653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f7efaf-434a-4e78-93ed-08d59e08f965
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start list of actual chips compatible with "lvds-encoder".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..50220190c203 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,7 +22,13 @@ among others.
 
 Required properties:
 
-- compatible: Must be "lvds-encoder"
+- compatible: Must be one or more of the following
+  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
+  - "lvds-encoder" for a generic LVDS encoder device
+
+  When compatible with the generic version, nodes must list the
+  device-specific version corresponding to the device first
+  followed by the generic version.
 
 Required nodes:
 
-- 
2.11.0
