Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969586AbeEXMAu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:00:50 -0400
Received: from mail-db5eur01on0124.outbound.protection.outlook.com ([104.47.2.124]:39872
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966477AbeEXMAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:00:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] i2c-mux-reg: Delete an error message for a failed memory
 allocation in i2c_mux_reg_probe_dt()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        York Sun <yorksun@freescale.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
References: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <480df169-84e5-8c0a-475a-edd4bf688e66@axentia.se>
Date: Thu, 24 May 2018 14:00:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0077.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::21) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:qVfnCNerXAp1yoiSXNtoL096tTJOFhP+Qtj7gag5p8b/aBxG0VuolHf4VV+QCXoYpAfdn3RK1kKNygONXBta68dNyEZeR0aAYjLpTqIl5VUnrgA5vpfRHF3m/M+C1bGR2tSR384mJ5AlBuGZJFoXom/dOsgCE2OVi4Q4z1M3MnoSST5aPn+EOGpWwondBdSpCbd7kHC3UJcao/3MELcim5kGSH1yRJrwVmk91GNyMmpqF3DSkrm3u89tSuykryiO;25:FBKxZGB4WEN+B52YJpJiyUCS+jIKVyw5/NfDez7eRTewyt+bW33suvDpPa9JcbUrFDWKz0A0K/cTiq7Xp7L+W0JDutuTxdUxpualTOfXsAaSI04rsM309PKIA/oRMiiP593ZXKX5aUH6fDVnmw6G7Y0buuRpn7+VB6Me0umCeY4cq6f6VYxIecjJ8iJ2eI2k5kbC1UI9l5uVROtUIXGek7huu4VhYkgstRIu9ncc6+f6a9oQ6XGWjnBG+80JAT7JNVQsnfJYdKrXoY2TxWch57wUfKgrRexVjMXq9qzycR7nrnDVCelWVwl3SuulvuHzXgOESASdruqx99WReDNhsQ==;31:rOtbWLl44MdglYERUW6CKvzkPCl3sRipVuwZjA3c7j3TzviRR2crJYyCTmBjZL6VpuDiZxhm4K2JvbdtQleVKvKCJbHrVfGHLUyYuNwNGOr8h/9iqkrYdkfB+vxt7cHFxvhLxn6FGo1pHbYd5JwDKmcnQrv5jgSvvjQXatMuiP3oDuLV+dgxBtyDnDJ9XPBqdF51RLi5ld54ke+XBGW9dA7jc1I5FO3KVakvzp2XTDc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278423233EDC0B0E29847AB2BC6A0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42262312472803);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:2wVp5mbGIx8hfggsWMf8UK4yV9zYQ8dM8QSF4/7EzApc5bRb46dzS377CWNjYZMRdUZXBM3RuKbrnon5GrtkmI9OC21rz2htYOTb9lTIN5S+fhHDCgp/QE1ykjvo+AtxfxEa+VewGMbN+Yub1kELBfDuxImRqq/Dzsu5cJTJaAp1izi6wAKfCTkb/wnD7d/8jELv0MFsOKucR2CV0klLB0Vd/lVJY+yp5SQ/U97Nd/SWWzHrjFyOm/4aCzFNgFr/GQGyO+PZ57K/gYCMBGIxxqCz1p/tN0pl1oi+69PVMP0wicYGmTBGizzBKdDOTrps
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(396003)(366004)(39380400002)(346002)(376002)(199004)(189003)(377424004)(36756003)(2906002)(6486002)(53936002)(81166006)(8936002)(4326008)(8676002)(81156014)(8666007)(6246003)(68736007)(65806001)(47776003)(74482002)(230700001)(6116002)(97736004)(65956001)(15650500001)(3846002)(66066001)(7736002)(50466002)(305945005)(64126003)(6666003)(478600001)(76176011)(16526019)(86362001)(65826007)(106356001)(446003)(3260700006)(25786009)(117156002)(105586002)(476003)(58126008)(2486003)(36916002)(8656006)(23676004)(956004)(186003)(31686004)(77096007)(486006)(2616005)(15760500003)(59450400001)(52116002)(316002)(110136005)(26005)(16576012)(31696002)(229853002)(53546011)(5660300001)(54906003)(11346002)(52146003)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6UWVTTWd1U29GRzBhalB4K1RrTjhCQXc2?=
 =?utf-8?B?RHRHY2RESkwrd3VINU1TZksyYmFnVXV4OGJpWjdhbVpEbmsxWkF0Yzl1a1hn?=
 =?utf-8?B?TFhXbnVQdEN6Sm9yVjBWRUFGWUJRU2RJR2hlZnVyQjN0blZySDZ6RDhPa3kr?=
 =?utf-8?B?azV5WDhMTWNNQm5hSzc1c2RCR0RuVFUremN5QWhaNUVRbU4rc0pidzdOelBE?=
 =?utf-8?B?NytnaXJSZ1hEWERFdSsraS9nRGM0bnk2cFdkQzJsaFNJbVNNNDVHaGdIT0lK?=
 =?utf-8?B?dG52bStWVmZpTEl5Y080djN2VU94OTFjQ3UzOS9PWXZYU3hTU3dzR2psMnox?=
 =?utf-8?B?MWs3UVlvWGx2WEJZaTE3czhyRGRMaTQvWU9Zb1hiS1Z0Uk45MVBpalBENG5R?=
 =?utf-8?B?MStrTjhRKzBlR1A4bUVVZktMU2R5VzBBUWtIVThWS29jM2ZtWnd2RktOMVBT?=
 =?utf-8?B?NGsrK3l5NXlUcWwxTDQ2ZENGUkREUUVpdklDZWp6MTFUZW5OTVNCTFpsRUo2?=
 =?utf-8?B?dk1mU3BzNXAwRGxQYmNVVEF0bS9VREZ6OGwzK1JFbnFGdWQzL1hpVVJTUFRk?=
 =?utf-8?B?ellFdVZYTkNNZW9LVzhramdQR0RJalIyZmo1QUk0bERBRUJiN1grRnlzcmJx?=
 =?utf-8?B?b2hyNy94dUJCYkV0RmxXb0I1WjU2T2ZmN2hvbGxIeGVYUy9uWkluMHVUQUto?=
 =?utf-8?B?MWdQQXBuMGZyMFdOMGFlT2FwTit6dEp4QUIrWjNKQU9Jc3BjOEZqcVczbDZQ?=
 =?utf-8?B?ejNTcmVLa3hZeW0wYjFlR3F5S1QyWDNQQWYvWFJVdjB0ci90bURxaHBpdXIr?=
 =?utf-8?B?Nm8vUTJIQzNwSEMvQXowUjY4d29JQXZKaVZyMFBWQjE2S21OdEdIL1NzZ0NZ?=
 =?utf-8?B?NXYvdEhBaHYxbVJjUS95VVlQQ2tpbit0ZEpaV1A3Z0JBWnJ2blBIWS9ZSlRD?=
 =?utf-8?B?Y3BBc1lBd1RGQW5vRWJBR3VJemZ6ZXBrLzM3RmpaMTBSdldHMWNoZWNQVHc0?=
 =?utf-8?B?c2puN1BNcDhYR0xVNDEzVHUzdnJvNko0UnNXV241cXZPVnppMVBScUJ4NWVo?=
 =?utf-8?B?KytWVWltaTVXdHNKTWRxYmNYcExMbDJZN0VscW8xbWJGWjMrcFV3Ukw4Y0ZQ?=
 =?utf-8?B?TkswZGIxSlBOTHI0djZMWmtpQ1VLYkVOTFVUYndwWkVWbHpXZ1BRdGlTc2E1?=
 =?utf-8?B?eXBHWU9BSGZaOXlueFBIcGhFcVRKdWxubmgyVldrNGhTbWtsRXVhdUp3Tk9y?=
 =?utf-8?B?UWxpNDNLQStRNEdKS3dRMWVVcUtOSjIyU2lrM0s2TUYyY0RJaUprajFyd25C?=
 =?utf-8?B?Nkd0N0hEcVg3dk1RNUR5QTZLVGdNQW90VEtLSnB1RjVBcEdJT29kdzdrL2Fl?=
 =?utf-8?B?em1FWm94RHZVTVFNWU4yQlVzcFRmYW9qbUZHSS9iVDBzakttUDIxVUF2d3Zx?=
 =?utf-8?B?ME9ERzZMS2NFMTBSUG5zdm96bmRZYVFVL0tXemo3c0F4NHNMWTJ0dUNIZE9J?=
 =?utf-8?B?bDFvR0pXTEN3UTA4ZHRXcTJXcEVHVlNLdlRGbTAya09mNEN1ODVrMnoxR2xE?=
 =?utf-8?B?Q3VZUEtLa2NucGZKYUQraTR0VitGVlE2Y3pRbXdVcDA0OHRwc0VQQnAxVmsz?=
 =?utf-8?B?OW90TkJpT1dYODlCUEdRN2oyaHJkZWkzS0hnSHkybmVnbHVDbjZhY3pFUnE3?=
 =?utf-8?B?QkN4WmtDWjg5ZUtpRTQycGxiMW1SMTZrNmVxRmtEbUxQTTBHK3FTcVBsZjlT?=
 =?utf-8?B?aG8wQmY1bE44OUNzeWRBV2FLZEJQV3o0NElmMnh2V3hqVEFyRE4xNjl4K0NQ?=
 =?utf-8?B?WDlzaU92OVN4S1ZYbWhiSWhXUXVXRndFenFmQlkxS2E5WFM1UXZsbGFrbUZz?=
 =?utf-8?B?bjFXMnRFSURiVFdqR2xjaExCVDdEL3RRSDV0elRheVNUM09vaGUrR0Q3aE1j?=
 =?utf-8?B?WXo1Q3hheWxLMlFvSkhzVFk3TTF6b3ZzcERGdENFU0FnM3lheU5XVW11TGF2?=
 =?utf-8?B?TGNLK2pSNTF3bkoxMkJGcEVwVmV5dVdXZGNHZ2pYN0xramFmUlBxRVdzWHZk?=
 =?utf-8?B?WUZtb1hta2FEdzYzKzljVTBTNTRIOUlLbHdlTHB1clF1YkJnaGlhaVVCSjFy?=
 =?utf-8?B?UkVJYXRQaTlkQVB6QVA1cVcxYXdrZ0dTMzFRZGl1ZzlrRmk4QjAxbkZIeWV1?=
 =?utf-8?B?VVlDd05RVmJ0bTMvbHQ1QjRyeGo5N2EvS0NlbTdtSmtXU01wZXJXY1BnMlQw?=
 =?utf-8?B?TWN5Ry9ma2R0cmRuVUY1ZjZCNG5lS0xYLytqaVdseUcrTjFYZFQrWWZRPT0=?=
X-Microsoft-Antispam-Message-Info: kC4P4Ts0gBaeFpKP47bHMhAMw81kmoETL7MheER/4WnDm2u3hLUFLUNHfKkvIwSj1gc4FqT9p0IaqeyIKmwg2G1zP8nFhj6xItFDEOr5Ra1w5y7hjZ6kYJKHUC8wEZ+l8nGSk4rTwAP76Umg1oJ74WpxhrEqVrSKAPQCTL0LK5FZIq6eyDsuNspnL7/vDVLR
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:iLJBQlG+Yjumrwi9na0PnmzCqlyNnhtO+WnMyMG6qnL9XEatDr1wGXBwzshwnCHBE/y0xLsAk8xpqGkBNvZxC01+meCfUt/qys2WXuNH2naQBP8mIdrNRQbQZWSjylVQOob+zokYnHZCpZzBLopdMwyxK+Q/UGcDCjBrfknJVBGuCRz8mHjCTuLHFzwKsLWmz3Y73SlUmy4RhUBzYMJBqYUbb9W68+1VxylpPYxtawPMzuYKl8JgyJywA4hO1kZZ4DE0c+ycc6J6Ub2AGg/m34myk1RPe0TNpqK3/QxxUsE/TIwfd1m20XMUBA6k9gGnlaH8eXG/4hBGj0IVZ9BdZrhYrDFxRuInfvU5YjEnBaulhcpJ9uSejh5plDdzi2qp5CxBgLNUWzEQT1cdJaRqhuD282Z5tbY2zfen7ns8jKeHXDGPx7wLzhEhCwx04gNm2JYJ1FIy/KBK7rvZXAEHCQ==;5:mA1/xhtexzK3iCKKXuUjTin0xAkMFJg+cN02hYCRq6NBqsqurseNEx+GKcj9Dk5Hic0/SUN+jR+XGeyvLjq8yYaP1ly3DAQ8qgqUr3m2Epx2MQAGfDtdNrTxlwD44V5O7s81+HIR6FOOSGa6GCX7mAWPZa1GifqJhGAllGEchys=;24:JgNcNdPzQRWYZXCytah2h04ZOYbWn2tG80Cu7R4Sy/5n8xs9RkvvLMeWRE8znNpz2bXFdY3iZxMdyCUlgeHTeN3WkL9MyKwWymEk6tB1Kb8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:4j+WAr+7TmoBmTf6HyBf5NN4eT2rGZSEKufR5ehgVWMw5AvYv5EvSNlj02h+COegz+qwzlZRnLcre2IgzeWtv77rxRnf1CG1u/CCMCFp6CFelBOPE+ej2cGazqnkPuyvbuGDF9x9fb4zmCCQnYQercP3in/allHtQO8VW12lwiraE4VWYGLMlmsFmrZwN9ZCHlpnhv7q5BDyA4BPxNYQNWMrHDjF8TkNI4OQJog3dCBgpQhFqs5bqJ3yngEpa9qo
X-MS-Office365-Filtering-Correlation-Id: 01515759-05b5-4e58-01b9-08d5c16df033
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 12:00:26.2326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01515759-05b5-4e58-01b9-08d5c16df033
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-01 17:24, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 1 Feb 2018 17:17:19 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to i2c-mux/for-next with a shortened subject.

Cheers,
Peter
