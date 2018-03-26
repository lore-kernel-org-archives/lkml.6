Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeCZSTQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:19:16 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:18272
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751964AbeCZSTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:19:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com;
From: Martin Kelly <mkelly@xevo.com>
To: linux-kernel@vger.kernel.org
Cc: Stefani Seibold <stefani@seibold.net>,
        Andrew Morton <akpm@linux-foundation.org>, trivial@kernel.org,
        Martin Kelly <mkelly@xevo.com>
Subject: [PATCH] kfifo: fix inaccurate comment
Date: Mon, 26 Mar 2018 11:18:23 -0700
Message-Id: <20180326181823.5536-1-mkelly@xevo.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.122.179.226]
X-ClientProxiedBy: MWHPR19CA0060.namprd19.prod.outlook.com
 (2603:10b6:300:94::22) To SN6PR0102MB3422.prod.exchangelabs.com
 (2603:10b6:805:3::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533ff541-8303-46db-7589-08d5934613d5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR0102MB3422;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR0102MB3422;3:VbrD4caUT7/6oM8xiN5tdMkdfIXRq0qivVgPRTA1XStr+5RbPaw/OlhUB/xo/mMCrklNwbrvi/pn1AKBrXfuEZjnf2ahz3W+4M1Nfh1nuadwdoxRzleGbNLLW+jW17V4mse8WmxVMV++azGhudXdi92SbaDm9Rce6J7PwR3l7EFjaveRF5IYNDsJwitRVW46VP8qm/Z9uvDrZhP3pKK3e9j/Jy8byXGTtvEllwPMllERIQgYzA9yyZQ1npExRcS5;25:XQWNKFdlcH46gHN6KZkyNfMgi6gs1xq8muNZMiRk2hGtl9j3QjOZBHkNJQ2nzfTmn3MRPd0/2T7TwbuKjvYtd48KR3YKvYbqxxoDVSNWUMeuUxwEQ3LB8Li9BdZNhlaE+h7HcgKuFNex+2YcpqnnI0/w/k5eXbwEFDNbMxSCVjvNEjwX0bFQ2xiaznsZcXcZgWhHrVEqc4KF8DkNDahfO49h6xXu6JrHd/hGfPKf7q1+y1b4xtowd0xLpFVfW9Pb4Ah/BmqpAb5VDs2CJK/eeOoeGQdKyqFFsYpl01PbUbrVM8nr0asRQoTQlZj/SKzjJBf1kdbArwxXT8fsCotubg==;31:GhI20zGfexBkz1BtH0BN5ElGS0v+wv1UuUEmXylAlYVtrqBssad+hqOjZ/pUfbEIbDAq82LXRmtmFDUGRiMDcu8lMT+rj/wSj0fjKsu6PM1Ega1t4EXugMIMnvPDroPPGKzz7YDAUdTciE+piA6XaUOrbCv/pEEcwhikAm8zpZwh4u0lZn7fQQlI6eDkTHJEaLdaT3dC4Mqzh2v4sYP4y2x/fP7BNFeznHP6h28oBzI=
X-MS-TrafficTypeDiagnostic: SN6PR0102MB3422:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR0102MB3422;20:1mpwF4ycuOOKGT2MxRY6MUp0ksXr44sPAKjBwH3NbQjm4TqVDhfvLGxzkkz5s7qD19bB3ZpMzKx4fE9Xw+CXTfarW4SHdeFvxzRPTwfdNZeaNOI1hsCWjnLS69uFbt0btcxPlYz0byk+TvFxxyspnqRnq5QV+RiVvDR8Qcghe3cFMK+cNnOBrviZRE3DFFo+QLAIthWifl1R3cOlTSEQSSzTCk0NzAEsOOmnE8Rf+qFRVVGmGJalwn9MvwyU6mh3kati59mRGx8Ms/PqIomx0hbEkREKqthuJ53LxtOM0fKnG+UQfC+0pa5mmzOLJQI0Oi1m09llBAUTOZqSEEm0N56lKVEAFFr9abBsWAQiH5zEfuzQllECFCvM7MhjZFJA6f5UfuYX1ku57g/jl+NZBcDa7rKGoFt1F1CguBJOGi143b+a9BjkTW4V7xa+Uf1IG+Az1xf7TJYY43WF+zwgQvaOsFRoaAZVzjRGaQbPE4ktiShp5fiew3UvJiURtJDQ;4:YF/CZ1ZMOXV5RPZmr1r71JcTH3LWZIINddWR0RwoI3eccN+SNfZwcAEimNC9auHH0Xtr5WO70cGz29WVzn7ALdOwFxO5OH0XB6FRIca/G0K+RPy9Oh01Qsjf0BFC1pvoD3g52rhAnC7WO8KZrtVzP37z0OuRXDfHflf08o73hz50s/QFCvvYyUrRuHAsjrAKstm6mdOWiyWRxuz4iOpSyAmv5VCNA9cGToZDduPV4VrL0OncCuOp2dD+LkaBqcvuMbXHbP6eBdyTzdtP/8Ijmw==
X-Microsoft-Antispam-PRVS: <SN6PR0102MB342279889BEF836ED91AD2DEABAD0@SN6PR0102MB3422.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:SN6PR0102MB3422;BCL:0;PCL:0;RULEID:;SRVR:SN6PR0102MB3422;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39840400004)(376002)(39380400002)(366004)(396003)(189003)(199004)(105586002)(8936002)(6116002)(478600001)(3846002)(2351001)(186003)(6666003)(26005)(2616005)(386003)(53936002)(16526019)(2361001)(36756003)(956004)(51416003)(59450400001)(476003)(2906002)(52116002)(1857600001)(50226002)(7696005)(1076002)(68736007)(6916009)(575784001)(86362001)(5660300001)(7736002)(66066001)(47776003)(50466002)(16586007)(48376002)(305945005)(316002)(81156014)(81166006)(97736004)(6486002)(54906003)(107886003)(25786009)(8676002)(4326008)(106356001)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR0102MB3422;H:columbia.corp.xevo.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR0102MB3422;23:dMgrXcUn/Q+eK80kGLIoQcplNlSiEK4PkEhZePR?=
 =?us-ascii?Q?94Dnz0l37n//aKsJ25DjPTpHD6Sik858+WQUflh4B4e48eVw1ZVVDbB7lwe9?=
 =?us-ascii?Q?vzrSfYg1h4tDsgMZzwtE9gT+2j7nD1JxtIqnaywnYnGMTwmBV9ze9CTNPP4Y?=
 =?us-ascii?Q?1gq0ANJqWaoItz1EN7mT5e5EkvgUYRA8GgjugckpuYvh9oLkVQf/+c0UgZyr?=
 =?us-ascii?Q?T7zbovhnxAqrm8jQPuikhwu+F8JDUqEsFHk+m+/PrlfN7r7pvcI+fgY1uT3H?=
 =?us-ascii?Q?Ra1Prhsno4VwObTi/6KIlHx8gQAURZKBAIgGzCU8CTXWHYjSwHsA7BMGlGVN?=
 =?us-ascii?Q?Ut9hA0w5aIVJBb+dIe0TZ/sy3mKkZoKBu0iJWc7Wfk4xB15TSbKTqtQ2pxAO?=
 =?us-ascii?Q?GjThn/9wMEM1ulbBuZGNBYVSOkK3ImFZlntwAsFMKJFMnEUFekDyI/W3b9bc?=
 =?us-ascii?Q?pbCEsmQ79JumVKouk3Fslz38FL2sf3aBrzJTwVQ9mbCglWIBze4IuK6PHJ84?=
 =?us-ascii?Q?WqFk/82dMASu3fQpkk9aqdbl17YTFtf9S4neLIBZLYrHsgTUUhllPMGoAtQ8?=
 =?us-ascii?Q?6vYGMNsI3ZsV8A+mHtX19d6CTSEM0XhKFN2Tf1wr9ZUZwsyaoM+a7/Ol5dkC?=
 =?us-ascii?Q?WqfA3+/Ypc7GaRkVYD/XrBt00sxFsqTkivTkDEmSnhvK5afClSu9dPOhu8e0?=
 =?us-ascii?Q?Elkq7qnzqGpVORUBeo7xLsqBP0Y7TebmxvjBigBegLkxVEcfzDlH/KnawLGn?=
 =?us-ascii?Q?hAtBo2ts6aEHc6acR6KNVlbg4AjtvUJVXIXVjugRGyB2/+I13O2MG9xjtold?=
 =?us-ascii?Q?nLqGiz7CE+lmHc57eij92RSHGnbSt67HOI7Zugq+dc0d+uoZgzmXzPeGddEo?=
 =?us-ascii?Q?mRkspQCPCYAaTceXCSs4dGGXjEtdWK3siBbtLWwkBZIOx1ei3rWOVNsKOfnM?=
 =?us-ascii?Q?KVfHxQ5GEZ0V5w0ZWuw8f9T4E3kREqTgrgGy2BG75GEIJ+GLM/O88KbirnEP?=
 =?us-ascii?Q?E/H0RSRIES8wWglRjl6qM9gpurcRuAUf+Z5+EgtMjAGlWMD3Q70UCtEudJqE?=
 =?us-ascii?Q?nTy1r8SbN69+k8+GmAdsksKwF/8jRC9Ft71qsrWUyiZGzEg9/dlAqFTBB/fM?=
 =?us-ascii?Q?TEcny96MfdeYw9GcDPno7PnCiU2Ltv5BdeoO4hDHQsp47mMPI7oksmHaWoZt?=
 =?us-ascii?Q?fbY4fWgWF3cD4K/HYXYxymz7l/jLQCMHscu+3QqvLTeCmETyzqsu4+V9CkBH?=
 =?us-ascii?Q?RF7rLwo8Euk7IyI/u/gjL4jK42fxuOfoB4/OBVVMYNviHyyngPTSDQDbFOEZ?=
 =?us-ascii?Q?ouw=3D=3D?=
X-Microsoft-Antispam-Message-Info: UiHgN4Hp0lY4pZjucYjnAbD0ubwp0RXfBvHOpyszYSWOdFnPMil4rwe2J90qC0PSOIkXK7LboP9DJ1iMrqhyDXYmHu+q6oslRCJ50rmc+XuAGohxFIgMoCgG18KYGPOZBb5LCkzJsHeON45zcWeGTNBC4BVwCEu8b3cQgKkXFKBn9VrOkbLbP9wzc8ep5vSe
X-Microsoft-Exchange-Diagnostics: 1;SN6PR0102MB3422;6:XZZKgPyq8n/oLVVRasQ3DGBa4cU/yL2Mh+c06BQ4dhrX8DIJTTrVY2IH2XXMzDxEdq6p7EvOJrStnTB+dQhr+wGvRi7hKBSLnomW6XYS42jnhLXN158rc/+dya0itFoSI4i5Jf+gOU6UpC6okbXFjpn8A8oxWVcuuHP/7LASSeOdjCh7vIta4IMmAWCfks0UsY97FCqch832kMZ3VO7dyZvYHkjePa1rHQUfK1MRI6thV5K8U/VXYAN+waNoXrssXkzt5LVvBREILNYDy5MoyB/SXuuIfKTiW5gaIakrM74h7RCbZhC0b/GBOecfmVvPHYeqJNJxQw2Y3pDgV2WSjFJuuDcojIpGQ64W5UJVHnJTG1ea6chGBbc8hMGdQXi3IANPic47tBMhKUv7DIHwdn2J4yFw5NyVdaFAffDIUBCx5ZgljfQ4F8JjDsr1wk18ancIC3VDDmK8pbJuuEgzTg==;5:m0CtkGyLZ4B03MXjfLeMlQoi0uCBZX6UWIimRE9/ZYT1KllWBa+VVRkjrAn12YVaT1FbWlLs34ZI5PtNZuMZjJtq78+1LcK1Hb3wThOAGBCAvzAskU5v4A97RzuPjUUT7zcuUq1WyrEwrqYQSvcY0VOReBmfCm2PO67tSuNB+jo=;24:Ew0IXWfNZfHgHe1z/Mmbwwjrr/D9jPIypy125kZMYfkUkeU8z0LVccJG4DS4f87z3T3FwJbYqZYv/4COfKr0Y+5a3S/iEe3s+UFu+nPBlOg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR0102MB3422;7:voe29Kj+oXkyCsq65OVyctz2LNgkbiH1hs3WkYAPbKY47CL6rKLdDcpHfWReOQ61JBCWAAVEvb3Pg7eQvgLtJKiFurFRvasZ++rV2KN/i35c6VElgY0j73aQe07FzGMwYf+NdxEYA7p4uxdizBITsY3i9OC8dvrHNIdZ+SxkXBx9R+5JMerDBTQHDEOxDqAsShTGrYN4FUtjNghtIl/dP6gTI0aJLRBOOFKVJMq+KuYdYR/zOOoqpj/TIvgIqoi5
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 18:19:12.8637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533ff541-8303-46db-7589-08d5934613d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3422
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in __kfifo_alloc says we round down, but we actually round
up, so correct it.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 lib/kfifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kfifo.c b/lib/kfifo.c
index 90ba1eb1df06..b0f757bf7213 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -39,7 +39,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 		size_t esize, gfp_t gfp_mask)
 {
 	/*
-	 * round down to the next power of 2, since our 'let the indices
+	 * round up to the next power of 2, since our 'let the indices
 	 * wrap' technique works only in this case.
 	 */
 	size = roundup_pow_of_two(size);
-- 
2.11.0
