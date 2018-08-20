Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DEFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F7B21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="rDTfxzqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F7B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeHTPqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:46:32 -0400
Received: from mail-eopbgr20125.outbound.protection.outlook.com ([40.107.2.125]:36762
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbeHTPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06FTh7VB6UrmdnUFxhQ1N7Nf6j1EZPPVsEZd/yy87cU=;
 b=rDTfxzqF8paiYgfTmVJQTGiyjMPcY2z33urPt2AdSYZHLUoGVx+q7P1DmTv8RYV+kW5HlLVTNkzpl5DXGDNjc9keyIePTScQUOdx7b1A977f43dQO3x9a+hLEOlCvyaTN4QzeXQbVhK6LzyrftBTCMM8vHw1msRmQiG5ktxemoA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 12:30:59 +0000
Subject: Re: [PATCH] mux: adgs1408: use the correct SPDX license identifier
To:     "Caprioru, Mircea" <Mircea.Caprioru@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <209EE0F380CD554C95B3E2532952872D29ABC204@NWD2MBX7.ad.analog.com>
 <20180820103827.24639-1-peda@axentia.se>
 <209EE0F380CD554C95B3E2532952872D29ABC21F@NWD2MBX7.ad.analog.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <12688e68-141f-4bda-ae62-38dd54654334@axentia.se>
Date:   Mon, 20 Aug 2018 14:30:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <209EE0F380CD554C95B3E2532952872D29ABC21F@NWD2MBX7.ad.analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::28) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d23b1f-aaaf-4682-2a20-08d60698c8fa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:T4WWNiDHN00nGecMnCzd1PP1+4UOuga2sqH8iY8WBD+jqwXyp62DJa04b0kBOtrUabKoOf3zmhWG2RfEEyDj/GH0Ncqaw54hU2Fm0OEPmSqPFi4dgJaVw1vd30TiMw7TTsJlOVqe0pl0oB8ai8T4SmTe8AGa+QOoCe5fIXaSKnwjx2KArevpTp1dinfw5g6qkLOsEgEbFDqwQqdLQgVo+GfydXJpa1TR7o7LuU3x481tDXT3pIT7LYfv2tScQ0Ae;25:a5t5t5idE91POGWkWJ+/cbjj64ccUyscNwRFN54FWLFIBlKyFjA4XZic4sXeN0voFaC4PVrq/UwJXS5Ff5nCAKN18FKFdCFX3GHH3UBZ0URLr2ahUCYPXWrlckPYStXKqq3BX5tZ0sLZNbncWlQO5vHCg9G9weds9472gohK2H48pKRuyr1uygduhImlu70FpjOqwi/vBriFIViXfEZv4aDvqJi0Mrrbq7yBs0/SIJi2DMRd5g5bYuzxlVeDnmbBMtaBZdMbCZLcJMRRCRt6+iKaY29wFi3iIpnreYUMJO8Sqoah3sR+Vte1RRGHcuCqacO8UQrMq4I2yExKIHYl0A==;31:nsliYzDuX/JelBYIb1RZFbtXaTNFKlwDDMPsa9I0bHpBCXyhq/L3EgijKTdHMQ1MaAfj0zDVcfXyS+JH8JL3mz8zsdbI8cx9fjMtjoB3ZGWhwuCFMl99Fmbu2J4arYcCx0ji8jyXvuJ12NMWPvm+eHYuWqbmfWV59Xl9gnkfeEssYgSO52npFvQ+Bs6dg9l7ZyoPIr1pmyHWdl/XDoOZj6wJgRyQrJadEoQsn6XMBJI=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24641FF42C88A7BC8912274EBC320@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:qRW52DCHhqeSKKBweT6ceWWvFfGuRxNH3YuSy8aJIdO2PLUy9TDErByn+CdMq4K7y/uOQeVpMdgCDaad0+8EyMQ0ibjTtGIbfWPy5ywprZb+dCRavkUf2D7TDBU7Pf5HY4xZ7jRxhlbCH9mgDzXnO8SQx1PhFEZgWkDvNuBliv061wPSN7fokhRiOjR4gfV+b3JRs4HHRV9OImeVwOYf0qME7vebiar0MzNRXmorkLpQMUcfpUfi4wFJwOpv/9u6ZrJbwkCkgxwz2V/j1LgmwuMpIIsjG0nS1mTIEGC5gYmlvAoJDxSDUjGx2NZ2Ia9t8iawKrROlfkw8H6Cbq16juGKwRP7Eb2XPi2j2iRwQIU=
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(376002)(396003)(346002)(39830400003)(366004)(199004)(189003)(13464003)(25786009)(3846002)(230700001)(50466002)(53936002)(53546011)(186003)(6116002)(52116002)(65806001)(66066001)(65956001)(6486002)(65826007)(16526019)(110136005)(316002)(7736002)(305945005)(16576012)(6246003)(3260700006)(68736007)(386003)(36756003)(58126008)(117156002)(77096007)(2906002)(52146003)(2501003)(26005)(23676004)(36916002)(2486003)(229853002)(31696002)(86362001)(64126003)(486006)(478600001)(81156014)(81166006)(446003)(8676002)(11346002)(14444005)(2616005)(31686004)(47776003)(476003)(97736004)(5660300001)(6666003)(105586002)(8936002)(74482002)(76176011)(956004)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6WjFlb0ZYWWl5eTNGclNvbnByL2JKRWQ3?=
 =?utf-8?B?VlFTQjNraDBzZitkN3kxMitjeElpNy96bERJV0lWVTJYc0ZtaVhuVjJWY3M1?=
 =?utf-8?B?bWpOaW1NN25sV3hOdlRmdnludUxZRXhHOXQ4N0tvYisrWFNidnlyNnBpbVJQ?=
 =?utf-8?B?S1JYUVNwQzU1VHU4Vm9RYTc2Z25Sa1ZuRUhPT3pMem9aNDE3R1lIRFBFZlNz?=
 =?utf-8?B?UUF2Rm5pUDRycGhaZFFZZ0tqN3doN0hpZHdVVXRXK2l5OTNuUmE0eTlvQ0lN?=
 =?utf-8?B?RzlvS1MrVTIrWFpKWDU5a1NtQnZ3elJhTHhqVG05cElmRnE0Q1VFQ293bitF?=
 =?utf-8?B?cDhOdVFJV2ZDQ1o3U0U0NXhDaWpMQ0R3NHZwbDNxMmhvaER1Tmg0L3U3MTh2?=
 =?utf-8?B?WGNvYkdOR0hBZE5sWTZobzRKWHBRbURjWlJRbVkzUFQ2UHNvVWhjUUppN0JN?=
 =?utf-8?B?N2dTNjlOS3ZNc1d5VUR5Yk1IRWpYem1DajZTRHFFME4vZFowUHdOQU1BOG9F?=
 =?utf-8?B?YkxuLzcydTVzREZQR05tUUF5U1dtSStHK2t1aWhDeDl2bjhHK3pqNkdpNytQ?=
 =?utf-8?B?c1BTVWE3M3FDeXNWRzdrb0FOcXgzaGRyRC9ua0JvY0ZYd3VoWGxVYi9IaW0v?=
 =?utf-8?B?TndxM292alBXdDNPQlpoVVIwUTlzTEUwVDVXckJYeTF4QUJnNTdyT1BVanI1?=
 =?utf-8?B?UGViSi9tbVc4RUpOSWwwMTVPK2VrcWEzSWVLQ2RMcHRwdnM1dkFFZDhqaVNr?=
 =?utf-8?B?YUZ6aXVxZVowSWt0M3lwVTVCbEhObFkweGNud1RyeVA1b1ZxNk54NzQ5OFgz?=
 =?utf-8?B?eWN2YnVHcmlxU2RvZlVxQnpyQlZyd1FEVnIvY3pYWHBDdzEwYmNTQ1E2OE8z?=
 =?utf-8?B?VUU4ZlYrbDRROHVqYnFpYURwcEZKc3hWNjh4dEVxQVcxdWZhQjVES0RJQXF2?=
 =?utf-8?B?OUVHMzhlWkQzUmxoenFZMHcxV3VaVnIyZTN2V2NUUUc2eGdTdzRZVTZWWktM?=
 =?utf-8?B?LzdGaGtiZ0Z5YjFsZGZYVTEzaGhrZEhEamxkcG12WVVxN1IzTGlvWmZoT3Zr?=
 =?utf-8?B?K1VYdjEyU1RKZGdBbnhjMG1OaVRXdDQ1YlR4T2luT2o4elIxblljYnFHOVVy?=
 =?utf-8?B?TTBkaG10SUFDQ2xmb2FSNVQxNHFHSzNzTW41V0VmOUxEbUpNaWcwa3l3aUVR?=
 =?utf-8?B?MlRzT0ZONE92a3IrYVozREdjaEUyVjhnMS9TM1NZbmpneUtTNmg2Vndxc0pU?=
 =?utf-8?B?Nk9CaU8zTGNuSWs0ZW5MR3hhQklUa1dYL0d6SnRqM1owdytyeTBoVGRhZ1Zl?=
 =?utf-8?B?WjRYWERCQ0dKcDVGbEdYK1BDanZjT0IwSmdzbCtxZlRuRXhLdVlyQXViaUx6?=
 =?utf-8?B?NnVCVnpTdG9XUi9ZNHNLRklhVVI1SzRqa00xampLMCtjSTdXWCtZUW1ySmlm?=
 =?utf-8?B?djZkS1V3YitvZ2Ric0x6VG5hMHptOHRIcWgvUWR2SnhzcXRDcTUxUWRkOUpE?=
 =?utf-8?B?RE5LenF6VzZocnhueVFNaVF3ZVQvVjYvOFRReVlCandWSG5POHN6V2prcWJz?=
 =?utf-8?B?NktuMlBXRnFFeHFhTkc5bjg3R3A3Uy9UZlpWcEQxN2d2cTduNnkxTlQ2S1Mx?=
 =?utf-8?B?OVI1QmplQmFsTXpMZnZzZElndnM4YngxN09CaHE4cTNvMCtrZEpVbENxWDdJ?=
 =?utf-8?B?L3Z6NGxtd1hKUW9RWU1Yb0hTV0xwSmxtVFF0RHRYdzljSnZwSFhZVEdYTWt1?=
 =?utf-8?B?VjVuc1NpRVhRT2FrS01kdmRnRUlpY2pqL0d5SXdIK0RVNG5NUE1zd1V1Qlll?=
 =?utf-8?B?bzRuNE5nQit0Ly9WK1UrQWpGYTdEUEhDVWpDd3JVak92MFpxbW1rdDBWOTU5?=
 =?utf-8?B?MlZ5TUV4QWJjejZlOFl2YXVxQi9pRW50WW1tZ293ZlRRNUpUSzVFU2dlcFlQ?=
 =?utf-8?B?d2J6SEFJQWFqd29wb2JjYkE0YlhVdUxyOXdnTTdnZVYrL0J4cDI4ZERZbVB2?=
 =?utf-8?B?WElmMURpWVhnTlhJYm85V1piaGxOeVJrUHVqTEZGeWl6N2Y5bHlsb00vaUg1?=
 =?utf-8?B?MysrMCtXSUptWTQybmZxQnJwemlJMTltbFZuTG9abS9YcGc4TVplbU43cVl1?=
 =?utf-8?B?cjFBZz09?=
X-Microsoft-Antispam-Message-Info: RkTxu1RODPVTJV+Ex3foge5mhdi40OXQ+yzmGFOe3Whhb1FQdtjIvsWJmWXgnU0W+EOYHGLGP5OFmDSErZq8ylqSbhedzla+rrP+cZv0IvMDrlPkSV8IfCfklpAn1y/qTVrDusn0iLmCKlirVKFvbi06HbTPefcIjhbliQwzJf813PX+WBFm5LHJx7lownHnj2I/PyX6pXvCkhIYqEQtTuAZfxPLvb9iEFeIuxrWoeQk1FnCEbsirlOBgUw1y6HTHCVkQvnNYWo99v/3pAHbLbQKjp8xoyn0UPNjTNpskNVs3uxv208qmW12XiiZ1woVDZbEi/j8boCSYgNx7VitqkuCqks6yIgfmICi+R6Qs+8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:gLzCq8ikhTCLPj0uCqjtp556dmSn0/fRWXHYi0LB/3Y+miX5A/cNRNxFkiHxJZoNJkRDMco/DZFg4D1O+jsfkt9IYoYpBzDHECngnHA4TRsMguiq2G9/1x1ipRtEipjU9Lrmgl7VQvJPNsk6BNM/RRXi1Axj8r/AWgap2nhmkq7LY1er6V8ZuJHDsSGA31hvKYqYRX7IkyMjZYORXPAQUHTXh4F7zyrCQqRkaZy4HNNHRW+eFY6oqS+R2Os5IDhYGGjqLyrLaraf6iQZpLCjPBhTikdxguEAFyc92IoyknRI+1yY8FaehZwswBYfSlBgbzo9RxtQmwWoA/JEQQV0Zxw1p0w8aNVyKlGUCgQLMGwIPzr643EdKJuOo+0sYbAtH3uNAWN39shG4U/vxJqNZ201idyVsQ0n6avX5dczxU9V+bbfhcLHlFbVEnAvt7rfiT10y4KwrqtmyDxag4xwuQ==;5:HFdmJOWAn16Pdox2gFU2l2fbF9LSyLCJPc+59+tkICEYYuuo8SiRmbDqrc7bCV/xsZXXQkUAu2g0BAnTFGo6Y0ab5udvHsNvdW7eOnS7HKh/tSmqtEuDmuMmo8nZhuY8K0A3X5xMUxwAovvkWkMdM5XdfrSuOdwA164iRFSNZYA=;7:SCKYE1J+8Rs4hFv/QQY6t5OcWCRkIaXuD4P0bSflM/douRWt5bONiHx+pYoGQRiu8bB5vxJlobQBG/FxjPIt1egW5XmHVngXPAVBxgzZeJK57Ty3Lp9dwSjVwKvQlw6a/CyPPw8E025YDe+reV++kWGKM26ay+EaK5zEmVcBJp1c9jUXCinxBfa+REM0+hLd7fl0dfAEo2ojHyOikulM8xBb2jh5T8/R7UWM8gbs6H4cQKpIz2PAhaYstHNyQKJE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 12:30:59.3735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d23b1f-aaaf-4682-2a20-08d60698c8fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-20 13:14, Caprioru, Mircea wrote:
> Ok now I understand.  We can go with GPL-2.0-or-later and MODULE_LICENSE("GPL"). 
> We are pretty flexible regarding what license we should use upstream wise. If> you feel we should change it in some other way we can do that too. 

Good, I'll just add your ack on the original patch. Both v2 and v2-or-later
are obviously fine and I don't care either way, I just didn't like the
discrepancy. The SPDX id is normally trumping the module-license tag so the
original patch feels like the lesser change. No need to stir the bowl...

Cheers,
Peter

> 
> Regards,
> Mircea
> 
> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se] 
> Sent: Monday, August 20, 2018 1:38 PM
> To: linux-kernel@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>; Caprioru, Mircea <Mircea.Caprioru@analog.com>
> Subject: [PATCH] mux: adgs1408: use the correct SPDX license identifier
> 
> The file is GPL v2 only.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mux/adgs1408.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> On 2018-08-20 12:16, Caprioru, Mircea wrote:
>> Peter Rosin wrote:
>>> I just noticed a discrepancy in the license annotations in your 
>>> driver. The SPDX license identifier says GPL-2.0-or-later, and I 
>>> assume that is correct and that MODULE_LICENSE("GPL") without the v2 
>>> specifier, as in this patch, is the correct thing to do?
>>
>> The file should be v2. It might of slipped from the final version.
> 
> Ok, so I read that as if it should be v2 *only* and not v2-or-later.
> I.e. the reverse of the original patch. But since these things can be sensitive, I'd like confirmation that this new patch is what is correct...
> 
> Note that MODULE_LICENSE("GPL") means GPL v2 *or later* (GPL v1 is not on the table), while MODULE_LICENSE("GPL v2") means GPL v2 *only*.
> See include/linux/module.h for details.
> 
> Cheers,
> Peter
> 
> diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c index 0f7cf54e3234..fe0377bb83eb 100644
> --- a/drivers/mux/adgs1408.c
> +++ b/drivers/mux/adgs1408.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ADGS1408/ADGS1409 SPI MUX driver
>   *
> --
> 2.11.0
> 
> 

