Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeD0J3E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:29:04 -0400
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:31824
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757171AbeD0J27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:28:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 27 Apr 2018 17:28:32 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: berlin2q: add interrupt-affinity to pmu node
Message-ID: <20180427172832.48840c3c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:604:b::33) To BN6PR03MB2626.namprd03.prod.outlook.com
 (2603:10b6:404:59::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:cyp9ljKsYV1fSDx+mKPY6PNJdY2ahpgSmc33CdSyFTYCBqAkBR1/EvRNkmc0muD0TLR1uGVs9b40++pAOHJWRVIrYubVUu7EJb1Y45r6Gm7UiTlaMJv0tyAT7lj7MXIcL0k1TDkQz+G8Z6/EHZTk8EHixiEt389VsL3WA8zG066AfMO+vA9o6ulYiIxWhjt9RbNF1dbFkLtHkISWTI/gGtdZxU90APJsYePNLtULW+Igl0sqR1HdqBGuT5bLTFb1;25:CSvbEVSQ+lVAAaWw9g4LjGTcNhWYBaRqwFZV8TpMaJOtxvObosiECtge6f26htWaBaDoq2plBxGS0yR35r7UiRFu7SJvvtFoAuvg3wcWGSML4d7Pxpvvr89vMggwtVHWsmhJfmHn/GRobL1iQZS52PQ7fSD/pwvqawtMzqpOQkKSKkUazDM54FJ/D9gtqLk9DTrs8VOrM87ztcR3ru7lFkMO5gKAU0inyWTx9ZJt/jo7oji2+EmxCCmvgqMj3UQQ64fhc0TwQ9WcOyGlKMm8YJDWYITFZQpK7YEbrCRatBVILtDoHNvq8iNdTkTiI6lnRkZ8wEiPqgrfMZ+JdMWj2g==;31:FrKd7epQ8gN+dLpG5+g0TwZCf8wfmfL9V/idTJP08u/FoogmcTfXNuUKtCW5OCQwdeKnduo3E3WaAD1tE1jsZZE5jQOZ+r+zjXrc9UMK2GzT5PZZMLgvr8IGbq6ZOsQLv0hvt7YheG/iHDDTbK+YNsP9Meg5GcQwoxmEfXSxNBrIKReCjmiz3LpaO5hXxqIVnWjpGQTFrLl+QFv6xUEt1/3dG3Bne3xyAFANDlC+f04=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:hobK+0ZroHvH3WvqKokiJ58Q9DWfIQDloZstK/H8aOCXh99xG75Qp4BKJCusIuKVQlkyv8Cqk3Ca8DXLIQxs+YjIxp0p4PCwMTqvEp/xbIctNOvo8m9eP3CvHHT5CYtVu6OOWl6N8FMh7TZ1JjB0WSMjuozCiZV8AjMnm7pMzLWLvbftc6MP2HayZt6dhQlmHHZ/sLnUM6/VisraNgte/XS6gQ6nqhW+/nLMJRoo+bAV/joc1XDrXfzMqeEWdeFDRgw8vpuTuhlXCMMwVJTe4R25MI931CqhMQ9n7yDBTEuRzd3ojaRySj9kiWL9/W2+6OL86eJbqpFgLs6dTHwnfi4fYT5aq0zPBzIn0tkBDPheGHrrRo8L6nE31WdxgLGXOl6dDfc+0DRWyAjkbNpcA8Lue+SyToY4+zxO+X3Jf7YUvXuJ+GY8kQC0hwSZd9KItUmc1aUdW9RYTpsAPfj2CJ+mpgqzfV9TnOvQzyaBOOXT/0WFngQrXACqFYfB1Sc9;4:VQ/dDJYQt3gZzYKT02OlmL6KjV4mS8GM0XTbp7ljpcQVpCL22hTduefwgirpqGxRF8Xq01RoIXprW5nZ7bxW6MunkvLzu2X77rPpLULzy0X2Rkso9LKOH0HdNol6A66ePlzbqDcvFZ9jSTuvz+NDG1XHaO7W0/tLFRAdhmemaiK/W7UHQwdv58nyIURWijIaDTK8yHsun1SKnU7/pRxpajqTAwSlM7cN5XV0N8L8uSbDKyhklLTXUv9tLiD2oS6ScK2TenJtxEJgOFuaYY3v7Q==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26262131C8125901156D3A14ED8D0@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(189003)(199004)(50226002)(25786009)(105586002)(8936002)(1857600001)(81166006)(8676002)(316002)(6666003)(50466002)(81156014)(110136005)(97736004)(26005)(68736007)(59450400001)(386003)(6506007)(72206003)(186003)(52116002)(7696005)(86362001)(478600001)(33896004)(4326008)(305945005)(47776003)(956004)(66066001)(7736002)(476003)(1076002)(16526019)(39060400002)(486006)(106356001)(5660300001)(55016002)(230700001)(9686003)(6116002)(3846002)(53936002)(2906002)(23726003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2626;23:oGRF/1MAXbm2MaEOEjSiVOMHSzV4ef7N7dHm8QNQW?=
 =?us-ascii?Q?i2n8e2IUGF5rAuuKLMzb7yMl4Edix/jHZORW8h9Yg9D/49mpnZTkd7z7PK97?=
 =?us-ascii?Q?ySIIdpr4jkCgODcoa9bQ2JKb6x1GbQsifTL+Srm6yVei3rV+eeQCNbpy8OaH?=
 =?us-ascii?Q?iQ0F3qY2xgl49QthkXql4V24qDIfPTW5JZEU3a6HjgIJTVJgMY9dPCNGAMXw?=
 =?us-ascii?Q?jQ/9/hOzBYOSUkEJ4UycUS60tR9yLcN2EEUk0pc1L4MX/L/DyR2RDKmteosi?=
 =?us-ascii?Q?wG9IV4p9kojVlW77EECBnKef+MGT8BZ7k2LuLPKBSraQFgpIdbiUbqVIYlPQ?=
 =?us-ascii?Q?fhpENehfy7VnUhQIW+QrEBbnA8Ql9nIjpr09mWAr1VJOf6tYlk3iselowh1O?=
 =?us-ascii?Q?wHP0jjF26dzfU4m51lkgswXe+hqI87BLqPEyUPKvKkNV+3G6AKHX8nurg8e9?=
 =?us-ascii?Q?9h4UlbaTiPoyC+9ZL+i59Rt7l9qypBmVCdVUFlE+5ngSK7/RzLXojZ62XG3T?=
 =?us-ascii?Q?m5sBL9tieAun+owGXiQvF53QkFFnZ2i3bMG1vaARBB+CQO2SOtEDHqc8jSbd?=
 =?us-ascii?Q?8+CrZ88u4Yvf7k73L3m/WWxh4JDSEFlvXrbi8HGTNBstDDr64gWKYqpUGCyH?=
 =?us-ascii?Q?96/jV+w/3ggqw3gH9elwEIcT4Ne596AXuaqADkapDWeTzP01YV90nzivHB86?=
 =?us-ascii?Q?qCuUDHaeD2tUjDlCNm1CtP/k0Z+LcBe+ZzrWZ8ASSS/NAzUsGkkrpWSrOYKT?=
 =?us-ascii?Q?C3foQnr7uPbAfl70nIKITzbsK8/MC++vu7oVlwZd6qYUsSYYVXZiUufcj++i?=
 =?us-ascii?Q?cE5tGGRhQFFyiVkXLVxGcP+RqmSXyhs3cv4oSfNE2WUiYuUYHJ/DbkOUd7K6?=
 =?us-ascii?Q?r1eyt+PffaDVESr6IxZ55W8rQyFYWoRZXHRvFGV6wG+y6buvjnZgqerHiGts?=
 =?us-ascii?Q?hFRc4si34badxqKPM/D1tqDLTFJJZ4LR8uaiq2H78PL2jqzOZ1z7pxHhebP/?=
 =?us-ascii?Q?GgdueFDj7FTmssWSzyXasOoKEXKIDQC8MTWU/S2/l8B1i0T4XV6HnBUisAmY?=
 =?us-ascii?Q?kwyJvcJ9HXepBCxO3HjkiJ/obdvmymrggqWo7bthQre2j2ET/nE3a8oyPKcF?=
 =?us-ascii?Q?0I+WAGjcm04A62j9PnCkCMjG6DDEFajoXiR5LDSRfBKFHphxofOm02MqpoXS?=
 =?us-ascii?Q?6JXexGsYMOjKtkRdVRmBu2o+4HV1kQ9pHoUrnVCF24EiDqT9VcfhnHjMQnDF?=
 =?us-ascii?Q?FpAJvqDjXpRLFiaBms=3D?=
X-Microsoft-Antispam-Message-Info: SsmH6j1jwW8WmORxRmhgpE2cD0upg/ym/f1nUCUkEjHUp0hxPNxs9Hy/ntP+6eag0vtUMpLLep62KnJukzz0mWAZwpmePNQCObCZjg/9GBm1vPjtxsH8P1VWPNer9ctlUrIBT3RszFAnObY/fLZESVUytIjcWwNUu81RMCAKm1G7gjeU5RRbzJZTizGk2Zq1
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:KwcsRcKi7RVXqQMQp2J7bOpCJMzUFAlbecmQ8NfGPygDSIpk8Ksj/dblEfOaAhb4d9HyQhg2xAd13L6BeZaTDj+Id0mqe2qBDKfsdTHWKGCSk8w2+C1nnfrJP9Dx9i/hBGLogSL3Gv4Tt/OwA7OLcXaSOA2kVkhb7J0VY8bAo9WDhnQ2l5KKB8FcJhGIloeF+nAloL+fM0iHsnyClbiUjzI88WaciqnRTOeCXHZ+rk7kUQwu8rIYzLxFEOkotW/swLwmCEbtMrFjpiiBIHJMRfnxlCWfUd2LMvYYdGiv6QIyAuvW/P7oFVne5YB4A0Rwn1ZrJT+lUM+dAL6ndgihwOVqjFBEjcd0sWJRg1nwFjdi1JYG6tghCWqbpyKo6d1Eh6WDd34lxZaiOQg3WLBHFHa7c/AxExO/89G2zc0WrysoC+39LWf2mT+f6um0Me8w3niV6RhXLntv00XETIdVog==;5:eqQPj9K7sNEq9fhFOj2CPsAao9tE7W/YsDsYnIQf67mymsAlBAjMNYt1Ha1Q/9yzR7W3nbJCQsOYhwvAEkFIp2sICNVfjN/7EOn6xCAGr+YK65B89JjKgkzXcV1V7CGJ1DRxN6xQrQiC+F93y3l16/RDenv26ZuxsbjptZqTO7k=;24:RCCAHMyljJF3CzIomjkZJYdIIj8BDeA1OrVZQacL5rshvM/jcReLJl6wO9wdUVdUqXg4wqrM+KIipYsHCb1UEsWfX7Xg842IczJnpfHjFY0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:aI1C+gImyC+44H7DH0wMBXg5dXqP9lcwaDlNqDiR67ssQBSTiygQ5fwBVLkKAozeeuc5J86gPI/CaS31DLXIo25OF71eIwTHPfkuguBsjxYZWEfZaBUxpeyzLe/6c2psHcH4u1iQXBUG2qeqkMXPKmeFG2ECFK/G+fUXAIxsG/iS0ek8vdXophctbiuWPTF1FwF3Ku45FC9E3LaQYQb1Vp9LKZqOwoor1ZWnMFL3EegFSqMy1dinDGMiUuKGMKC8
X-MS-Office365-Filtering-Correlation-Id: a9dfdcea-c66b-4065-1f98-08d5ac214d51
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 09:28:55.4127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dfdcea-c66b-4065-1f98-08d5ac214d51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt-affinity property to fix below warning:
[    0.429642] CPU PMU: Failed to parse /soc/pmu/interrupt-affinity[0]

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index bf3a6c9a1d34..e23c49ae3ec2 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -53,7 +53,7 @@
 		#size-cells = <0>;
 		enable-method = "marvell,berlin-smp";
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
@@ -71,21 +71,21 @@
 			>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <1>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <2>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
@@ -113,6 +113,10 @@
 				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-affinity = <&cpu0>,
+					     <&cpu1>,
+					     <&cpu2>,
+					     <&cpu3>;
 		};
 
 		sdhci0: sdhci@ab0000 {
-- 
2.17.0
