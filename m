Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeC1D1I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:27:08 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:19376
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752004AbeC1D0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:26:00 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <Linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 2/4] clocksource/drivers/imx-tpm: fix typo of clock name
Date: Wed, 28 Mar 2018 11:22:36 +0800
Message-ID: <1522207358-8388-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
References: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131666811596419754;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(39860400002)(346002)(39380400002)(376002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(16586007)(68736007)(8936002)(450100002)(106466001)(486005)(126002)(50226002)(8676002)(81156014)(77096007)(105606002)(81166006)(104016004)(50466002)(26005)(6346003)(486005)(4326008)(6666003)(11346002)(446003)(47776003)(5660300001)(36756003)(508600001)(26826003)(2906002)(2616005)(336012)(54906003)(51416003)(48376002)(97736004)(316002)(72206003)(110136005)(86362001)(476003)(356003)(59450400001)(76176011)(53936002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3109;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD008;1:ySdOsRjs0Boz12x3KZ+jxGwAkacEbtAlgkLsUIpvIXqyXf7ngnGIdKfxwCXXCeAe1QZa5GqiSJQKqMnfE/aqv/FEhhUPocxTb7oZIhqOsop5l5PGbbkwimOVO1SjFapn
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 763b8f31-c567-4298-514a-08d5945ba05e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR03MB3109;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;3:xxFsb71JgJ3fi+0CqJCgcqqQZya2nifZFHximMZdkmIJxhanDar9m/I0s8xG6V7Db9TW4BqAWhNoUxz+9pg+dd4S9zvIeVplmRyC3CHAXr555YnMRaz1nwOjmEguYh05nvzZLlghiylyvPk52htogZGGSTGBNBtrd/zlxDfC37LWtqqnKClkKer9xU7l4FgfrQsrEmeATOWcMCuW6QVR4filPvkwf5yb0Mx2pr6V8Eg0gFhE7x3j69kZHRJEXFK+cH7O15/h9emmQV1s7iA1LgWKI29eld53xhViPJpCXG8eIrlQ9j4UsWWk9GXrz5+Lfas+atBGu8vyno0ZqY5Dh6jAXg9pe0nmR/R8cmkDAuw=;25:J/rCfVZIauJl89N6N7exYlMnO2AzwXJppbUsseMkr8UBlYIPDhiA2CgEQfkEm4e641N5x4QB1Sm07aXfDFIn4gPphFxmZyZ6YnAjm6TS2LxaN0D/aWx/xPgfxjCt0tomx5U6YVXZFr8Be2yjF5F4CmPsYJCJABzruupiVAvPfkZ0KosYa07t5ipCriSLaiv1dxvS/KPzZPyLPDVDI6rG6Ee+rWzjWATz3JhpVgw0GCM9VuAWE8B2p9RNWVA75gQFpLOXMEIA+3If1YHR3gSQ0yarTcXUlRX2rj85iie4Cufu6K2YS+2HbYl7pm6s5omAjSKQR06giwJF5F+q4UsdXA==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3109:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;31:z1jhCYbGNvR5zyX4XgHK8pucY/hJaBcwOEb1uGcmF5zOle2m/X1Q9O3roGgZTNWKCCOKHpndLte9lEbMTc4/7R8a3IvCFOBeGiO7qdl2Pj9RRnK2CK+Kgkx8Ls2mPGtt7PWa5/FyGhqwL4DBibYpb5WWnLcEPsz70ntSnNkhPFCetIeaoaT23w7DXtxWe1z+qJPhHdVNERIGFGw3tkeJWfDE8iJ4Qvhq40A9amgk5PQ=;4:VU8MW78IVGQOcrkeift1uzgEG+kncVfUWdQY0ntbesiCLB5g0Ie5/SbPKz8ZKUMfIASgVCsEJqdXI76R8jLah2MowzGQbwVaT/Q0qKX4FJEcCGoF9aKA6i7BsrWJzoWb+f6M9734di4BBMvky5hIiCQUAhnoHajDpH1ngYPhVa/gGRdvu7JA46As+6OIKXz+prlfJBap4i6hbokGvUDnNAQaN4kt1F3YQFfC5hosWfAY8i9cvqrPEmzRXw3it+/gcfLxiJ3DDQx7Mrrl2G8JkXjOUWnfEeQjCC1gWt25EsEikrUov/zx2kbit9/s01KU
X-Microsoft-Antispam-PRVS: <CY4PR03MB3109D8E6A090DEFE74C962D7F5A30@CY4PR03MB3109.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6096035)(20161123563025)(20161123565025)(20161123556025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123559100)(20161123561025)(201708071742011);SRVR:CY4PR03MB3109;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR03MB3109;
X-Forefront-PRVS: 06259BA5A2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3109;23:R5fYDzjnbsgCfG+xRLXQ5t4j142CE77ENMuGmwrur?=
 =?us-ascii?Q?Hd2XiJ5Nl+a/pVKBe9FMh6f6WKmpYbnHFyM0Z5e5yyc1xI2xVNapSPZx2E1Y?=
 =?us-ascii?Q?WtVsiGY3TwB7FAZOXl4se+8rWB3hGJr+sRjD2IQ9Ve69F2pMnNVGo+YI30tS?=
 =?us-ascii?Q?DujJ1rNg0pJEHzyDQ76hwCBrpAVXBrn5+KT58IkWZstm03vw5AzWdwpqcUjv?=
 =?us-ascii?Q?9rFSA5nuV5/ZCUkXO6qTO/0pIY5p7mFXbHYo7VOGZQlpuq8OhNRh/w2n+kQ6?=
 =?us-ascii?Q?H8nlZ6oFZpBdRP/rAT52cZ0aUi/7NPubmmqUi5tHFAN5swC6REoSlkVwye9d?=
 =?us-ascii?Q?oYDrJDrJNkYWUR3RQe++lKznNNBvoXHHDxtkZnyEQ9HflOEFI3fq9KM2j6wS?=
 =?us-ascii?Q?GMmmVyabQPAMBxBdVEOcT8IwC5xJkChKs+miXla7dVH7XFe7Gj182ngiLCB9?=
 =?us-ascii?Q?3cE46pyTfWXi5FSP4+1hknKK7lINSapJflMPuL0pAGEUZY0pXGmQcjzBs01h?=
 =?us-ascii?Q?b3z4YDBC/0vZUQUqb2RdWzDspGc32qvSrrWI8y9eVlaz+hiOMmJDgF9pzdbo?=
 =?us-ascii?Q?SkRSDdOK4faeC7OJA3Lv92RfG/58A6+aMklkEDHkFn1x88h3OnDaDC83GyzO?=
 =?us-ascii?Q?Is3DQNi2NEdtcpjzYbgev2Pxhc+fp7LYo4i8O+vtoaThNdLRiY2dVI4Wn1dt?=
 =?us-ascii?Q?GwGW0BT9hz4N1rGz134sHAtGpmR0mpW3Guur318j9dRYy0ciARYVu9gktHbr?=
 =?us-ascii?Q?UsqMGkQaonTcKZoY/wuD9aVS8T5IeHH79P2rmqMaJAdBMKXf4z2KRqcDBmu0?=
 =?us-ascii?Q?8K6+0+E9FHyBTQHZ21g9GHYFWhJcIvooPIIvrBncuktLq+pwobxMQyX91uIW?=
 =?us-ascii?Q?OiFHJ6YIACZR4kjJBrnFxiO9iGbrJ26+xkAblOezA/zCVYUe4rwil5Z7S1D5?=
 =?us-ascii?Q?mpDSqNInhnMjkyJmt+0Vq+lx8LWcgmTGcujCziplLkDkJFgBZw6nzszOE8B1?=
 =?us-ascii?Q?28Zd5AH0OpSqwFoPR7YoCXu+NNLhOEkT/YcRs9jDtKCUgRO2t3dLk6MYMet1?=
 =?us-ascii?Q?gpcq1NRPJk+sTeP5twl8EKrpqEyxQJU2VgHS8fB6WvGtKZBN8W+2QStPTKYw?=
 =?us-ascii?Q?ubZiRnsYpuwVZb8l+tC7hG1N87FcNtsvQ74UkMQaWqfTuNeAqSCMGkOysJp3?=
 =?us-ascii?Q?JO+N8x492sCa69uGn/HERFfDmrq02yih8hqSzdry04y3LYXI5yLMGAXAqbWe?=
 =?us-ascii?Q?bYMuz6qUNwht1AfStZkB46XWIpp9fVzdfyz684O?=
X-Microsoft-Antispam-Message-Info: Lg75bksWiujbi+Ys1Fzxi8ZpCCvhQacJskA8oFOJQOIuyj9HrT/dzNn5xiMfzGZielUYlnckjFug8x6RpT9z2lLufTYGmLOJ0zIPTYbg2sDzUAZzkwulJGIPVSQMlmKbxCvXSnoboXH82LLjhZtfmRF21zIJBxyWcgxm1KmHhExdzwotfQNmTSRJm2RTPSg1
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;6:zdNdhPyYcg4TlCPc/FUnGwxwngqfsuw8n9Ti1F086aAP4LjUssSWJyBWzed2Wojx58YdHw+jqoNzURMQ2Chj+E+SVeJ2kx2bAfNovir3pqfYUlGAKjuAdMwjIHn4sGrYKRYTEzfFiHsP0kY3uiPFjYhrBryEilBaZm/cxDjWFnymRM7t327VHJilyX0euOKIfHOL42TejzGPkVZekYqFU0/UI4D+iYR5wPRFrwLdKOxrMniYdUTmTZk8VMxNPUjtrryh4zxaVdhInSznDyULjZ8ZACq2LUYWoUZoXoi4KFGekKkbQiQuBvkFEcK6Dh271TGmTi0PucT9mm3bhzI/0KdsCfPTy5H0BLWp2uK066xVBqkxrvHNRyvTKS67BvlwDJeylSkqA9zCq+Gv6FngNIGpG8qYP682kAykUJ/9L28FIs9cdH1tDbGJHWkHnqUVlDh/FDqYq4+iQBJW4Zw/Og==;5:v6ipzTq3lZHeYImYuDVnBUMv2nWI4imKAGsg+HE1RlFqHj3lrjAACWt/TvA+e9Y3sGFMnno5ARq141hi4yyjIhtkeeIGo4jsbEY/OLd9Xoi4YDAQ+d9ciOpNaNuE7CRUMuwbr/ObqqP1shLSEnWr9vNDdrCRRKu+JfafH6E5600=;24:4cwoID0Ufi65pYsITW5aj8Yc3g+017uP4aiezLgjZDgUgv9GypD92+Z7NebTW+c32zJTfC7caDgfIPKD1x+naTWrSsKzmMJKR02JTl40AzQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3109;7:8GWLe8nXtTRYNn0j1LWa5YAME/RZT/Y5LFrF+O2ybTsgGWqHkjB0CPvilq6sr3cgpJle75XJAG1sxis7p7D2V+2cwMZ+kLfjo9QA9atPBnSyf9wAUnirqzksNEA5yyId6OOaROFCVqKr2ORCK0vDEWU+pcmI9I4UXiSSrTNYrOss3XBquJ5O/ig0OJEvXN7Bu1RFL/hPkEXUnjtBeZnMI0FxZYw82VWFXwBE5GCfmNyyHAMHzbc9MhzznbLFmjPw
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 03:25:59.4547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763b8f31-c567-4298-514a-08d5945ba05e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock name should be ipg instead of igp.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 21bffdc..3f97d49 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -179,7 +179,7 @@ static int __init tpm_timer_init(struct device_node *np)
 	ipg = of_clk_get_by_name(np, "ipg");
 	per = of_clk_get_by_name(np, "per");
 	if (IS_ERR(ipg) || IS_ERR(per)) {
-		pr_err("tpm: failed to get igp or per clk\n");
+		pr_err("tpm: failed to get ipg or per clk\n");
 		ret = -ENODEV;
 		goto err_clk_get;
 	}
-- 
2.7.4
