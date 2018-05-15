Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeEOJRa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:17:30 -0400
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com ([104.47.41.75]:60032
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752980AbeEOJR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:17:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 17:16:36 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: berlin2q: fix irq type for arm twd timer
Message-ID: <20180515171636.6414cbc5@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:404:a::26) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:sn23UMQ2c8lRVSqBOnND3BHn9UB6kn2uLoraHmp1bmaZGo5HS5dXbFeVORqaXa64Y6sr8oPy+RK1XhjgZ+t3Qb9mWFafwI1FbrrSts2ZOAH3gz52F90cskjxXxNCTo7iEXf7lIYd97reKrzzsjgnCeqoVBTxgtxYqCdfBoKweHu6T1B1koV+IUhCVdzAK0olfhFOQE5nMNZ28QXcVOU2iPIbgUquMjs8kvBEMXAteTPtvSKVh4MOYfBNWH9mDcLG;25:LTBN7QKhFD42ZvYkWcBDOsL20Sszal1CYFXBZJ3N5D1Lm3Kfcprcv5dHQfbKnWnzC5f+JHVaUNOXY6SjbHTjifyZIzK0OM/eHd3voeKppc7PprBVjPySK21ivMiI5GC/L1/ZopNQKJuGj7+otd19SoIiaAT/T0vdEuyM1qTsnHc0DZK3cuZYomDIunZ75wlCbTfDNJ3gQEBtX7uIgPPBhyDkqedf7G+KPaTwZ6JC4SYtXrEJby5c9BikbZy5EFc4vplv2nCuNGWrqpZhnTWobXnJBJBX/Sk9RB8Evm7F6WbMTed7Z66CcQS1tiOAP4kHS6qtIeXa/jVJeFnxPxAQRg==;31:TGKm5v6kw3hYDd8rH88HLv+zEkD96zcTPe7rF7I8TYzNX98RiMcBa9xMDzIj0b3oKi982816xtGQz1eiSi9yJR66KEC5sJekbFzgkEDm/wFyelEDBwrywHUjITsJSk8uZQ3aKnP2sORfDUeYxxTjZptNs9mB0KbSwMXVC5C8u7AYc2RdJC1H5s0Fm82/FHobDp99FGhUf/sXh+1zSjR+IG1WEI0U+QW+NWJwBr5hN1I=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:L9INfaEN3S7HEd6KWmb9FH2QiL5WZLBj1WxVYceAQZr6kOWjOs5L43uM6Duc4tfJl+VRiTHIR4FsmMrc/qV6kx1x/2ISd3I5WfOdWshl7sNTwwUnxs0XYLaVhKsAB2NtHx1k7/mpUdIwFHUuqU9XLzb6IfwBKiJoGJzsrvbIwfaOWziEehkQGAn5QbkTpYeLzMuf7fBt7btR5GGnCPWPEKrcnymz8lYkIVfXnoYCLldK3AeFGMLPMIoq/HSiwgQRtMo5l/5L3wWi+bOYTdUWZF5Ju+IUc92lU+xRPnL5pOV+Hm8ilkIEmQZjos4Ata+tIqvDe1k9Ix9yt69XTl4cAQDLRx4nqj743qm5Tgn0/6mwBHiVqWEvvSjaopjoqG49RheQsVkVUElUWoWeIlRvHn87jfpDUyhMvnRjbVPq4OGBsFybUUt8q2wa8rFdbMdnT8iOlOyPPMLLx+wUkzIAC8+VVQKuGW2pUy/3dq7yAZIEGcubDkUGscS4VaQDO/Ql;4:5ILIvic+Eeq2fujgNdEV0mYarg87PHRiJqxzWkICqjt3J2OUB9rS4nbEZyvihrpseeS/EqGSpZegilpHeDVoLRliAHqLmOEKcfwKU3WIapzpzytn4dEgEZ9bc1frUFl4qPHegN33w9zzFewT1E0DocMEC6P/yVo+feiICrGV4d8fjOserTBATj4i07sELbOwZB4+A7Ny/OHVenFSs16G9AFlSps91QRyXTQaSQUqgNd9gKRMS8HMdeQtQiT1zmrxFMKbGgR7xzH5N/oKs1Hyyg==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2636A2ED69A7803DBC7A9018ED930@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39380400002)(39860400002)(189003)(199004)(59450400001)(72206003)(55016002)(97736004)(33896004)(305945005)(6506007)(105586002)(386003)(478600001)(486006)(230700001)(106356001)(52116002)(5660300001)(7696005)(6666003)(53936002)(47776003)(68736007)(9686003)(8676002)(23726003)(1076002)(81156014)(81166006)(66066001)(25786009)(2906002)(316002)(6116002)(86362001)(110136005)(8936002)(476003)(186003)(16526019)(7736002)(26005)(956004)(50466002)(39060400002)(3846002)(50226002)(1857600001)(4326008)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:Mc3I99PuNtKTIcx8jUVle25HEyGeAieX/dSqvth7v?=
 =?us-ascii?Q?5/Cm4Ckj3355SwsubacPdUwGP2KXOfNM9RivLltrrkKkIgHS90OsEqzkAQ60?=
 =?us-ascii?Q?/aL7wT/JLls6Lrraa/3Ldy5XwnWRQf6fEGzT84A4ODTaZBXldA13EyLjKbds?=
 =?us-ascii?Q?PYWIDPYfZTBF+5Xldwv7w6+nA8pFVkJBY+tTzkKz/X6CEKOyBA7OaSvOPosV?=
 =?us-ascii?Q?1gT+T7tfOgTPA6iWg/ECewe7M8CGUZpIXZB0mZob5EB7RDb5zqLWoo5bppGs?=
 =?us-ascii?Q?T7LPDU3j8POd9s4CmZ7t2xpjkaG7JIHCoEJ8SJc3G2ipDXYFDCIQdthLLN4p?=
 =?us-ascii?Q?/M8zjJ9VYq87iInxizAKPdMVY1ebKR3aFHNTAo0+s1J4E2+UmqG2tRhIxfUp?=
 =?us-ascii?Q?yH3ULBx0M/X0i85HLXyMJAlr7+LNnF1Xe+aUZmQ+UUPiUHhQ5LoRpm//cStz?=
 =?us-ascii?Q?GJV3cmHM+axyZQAsKjmN+E1qxz2Ip6M1j3tG/staXoVckSwYs3zu2gG8mnbb?=
 =?us-ascii?Q?knD/e58EshC3flxlL/WNkwn79i5jJeG8IOttnKcBUNvcmVgw5ao60VvSonJ5?=
 =?us-ascii?Q?mF07/ICADK27p+BgVWaqiHZDtxZHn982ZHe8264WammBVWAEY5Gp9wTvucy3?=
 =?us-ascii?Q?y1rhK7sWo//u0Ijfzddb3cFxg/AXDMLZKsv3F/SJduDSNYyz51+pFvA1HpLs?=
 =?us-ascii?Q?V5kHXuOw3aAbMieFF5hCLKj7YX4pBv52fa0QpdF4m3hCSNEVAIF99dfcDFR6?=
 =?us-ascii?Q?0FrQ/0WytJzBr/FqkX8ps5qqDCsWddm3Ii8bEJmmtcGJ3UlP7Mhwl7yMtziH?=
 =?us-ascii?Q?XLkcGRyKgqGvZ4nSK8u0KgS3dgC8sLM2KHtkW32rEvIuwbJRkyQ5MzsoSEwH?=
 =?us-ascii?Q?38sGBvTs1SQ8bWavefu2pziCVz984rcQSAad/WXnzU82AKS9RkfoWG83znEC?=
 =?us-ascii?Q?Np/dEYTbYBiry+mnz9muVGEjwPjjkJWS4ewePfmPxd4lHxsD4MDuAOt/+Wxp?=
 =?us-ascii?Q?zEHyYUve5we8sx+HA9A14qbAzYqx7ZXKQUxEvqHgCVq4mpnX6QNTpoa4CvZZ?=
 =?us-ascii?Q?5B/JoDtrB/GePu1mwFStkwgZQ5jew6MnyPHhtWJ9GQG5mTvz+CATSzVwJV4j?=
 =?us-ascii?Q?9yq9penX0YdW48/+Eh5obV6F93jbfg1sh6jM190ECBpY4FBsoCJhkS4RaT6g?=
 =?us-ascii?Q?4AMmhul6lzU6lXyBf3ae2jews8a3tVuQlGaW+5VqFIcCfu5WakJ2HYBZ9L7s?=
 =?us-ascii?Q?IhvZPSkOBhVWP5vDyo=3D?=
X-Microsoft-Antispam-Message-Info: sIAgYAJcYtR+9VU56ae7m3v05CQ25jiqPSWoN4BhfsyZMHfYlQd+oGRGc9xBUuetCVmbmTLl0lwZl6YVwOr3CNSnPsPL1EUUorvLVwVPo/q9tT1/an5PAWUEBWZYQpv+2xRKFAdfmFEoeXIOnR+FLpHFTIn/gqU9TPTltyumoWIbsXltEoDShF8bXBcG1Shw
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:1Guj37kdHIvQp6OC0VVg/BpoWzVo7os3xm9fmJU10Nuv5kiPCZefMcB00MuMN6T5oBnXo8dYnX51/d9Qkq4e4ipkbyrmCLfc+oQxWskikR7Hs2M+mJ8ltw0cilUBi4qkJQoQH+zIh5KvWaVrEIOfAUClh4s72jnCFvQWOFGuc0CVQTcYSmifWGK0em3m87TKhMpCAQxMJFUcnxseOmSKU2r0Faxx56J+zGEWG+OfzeC5EJTelBMdYZqZRcNbYIB4bdkKMbDVprRvQq1hqKL2mVRxFAklJ0Mw1kX+zlnFXMMcfgzcDuFiU2ira5MIxFa5PquY0YYqREZYZo62f7Shw2fEaHet2AwXwh/n9dgJS/y1aRDNeY7MyqDcDxNffxTdIEzYOeyL143bz9Ob7Yd8oxyBLcsxIfQT9FFHr/4q5fSKA7h5P+wPISnILmB2KY/4LVWaZCXH+YXg9duM7cY3lA==;5:DA8KTeZoRor3lu4P/2da6iZayTdEDDePy6za+v0ROX92uanJ8XM6crig0u1jFWEHa5npGTPnxqGQ8fLn3kX0PDoJiH0biWVuyVtYzkO2XmzHZhHjNIaRBKtL5tnhnV3EdBpVM+nYEHhDUTCtp8947HGMD84MWWCtH6SJNeYj5a0=;24:CdgqeLIatYg+pPZqSlZeD3q8U1KAxN7cyiR9aFLEPmAluszQEcraEMMe3yX/ekD8h0fPjvoUmz63JCdsrx9UafJyENTXk5KOacxPv4+hmio=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:vSP3zzsvQL/lRj1NkDb2g3rBXf7iyQn34ACQ8xFmj8S3buaP0MVLSjUgusQVy1iFm65IkWHfTikacaH+Q4xj58JeA/SL2tXmXSd0DTZq6Y4dCiHGpi0Y998mAVBQQr3uKwoWRLVDLiRbAKujNc5Oa5VBtsKRS2Dj21xsxuqiFkoJcSqA9Lt+pwCKBUgB15nsawNiKTYYXcRNVM7/4Bj8Xm9vwN6xkeeXHXFOkXu1uc29X0JD4gq3MUtK5CvF/4U0
X-MS-Office365-Filtering-Correlation-Id: e5358f05-a349-4fbe-4b7c-08d5ba44abd5
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:17:22.8561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5358f05-a349-4fbe-4b7c-08d5ba44abd5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning about PPI interrupts configuration:
"GIC: PPI13 is secure or misconfigured"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 7cba798152b9..f11254e70f57 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -164,7 +164,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
 			clocks = <&chip_clk CLKID_TWD>;
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 		};
 
 		gic: interrupt-controller@ad1000 {
-- 
2.17.0
