Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDJPlG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:41:06 -0400
Received: from mail-db5eur01on0125.outbound.protection.outlook.com ([104.47.2.125]:53941
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751604AbeDJPlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:41:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20180410141125.4477-1-wsa@the-dreams.de>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
Date: Tue, 10 Apr 2018 17:40:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410141125.4477-1-wsa@the-dreams.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR0402CA0008.eurprd04.prod.outlook.com
 (2603:10a6:203:90::18) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46bc24f8-16cd-47cf-f3db-08d59ef976cc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:t4FRM9elabfslSysUrgsYp24AWGt6WDKE5B+dS5deGuZD47OUA/8DJyJAjThy+FBYDr7MpsZ/muXeT3gHXcEtzNBg3zEbM73BznEauoPm/Pk9+Y3pxeeXWg/UY5vnB5jFCBW9B3808uigBb02OnoJDUjTMXNYY0/jrzfQ0I+Eg6LOM0aczG/cBzlvhlE++dXziOA8nh8jlmAdBPXA1KyoQjve5Cw2wFYn2RGi7Esq5brEMDCF9xShBOTFG3mjXrf;25:SUZ2p1pUqt6sK+uQjx+LIcv88ypftq3VQ1El4fBud4kxOg4TclAQo5O/fY9hMoolbu/ztQ97Fcs1oXIzRkKzpx0qNRtDyW5nrgDb0IVsjkJ4Dy6PWn+OP/upNqHehoDuIfwbWJqAzU21AMDslXbIoVSxPWDO2EWXl2+4ag3hX72sOW6kZ6WgGlvXS+f3WDGGoxm8M3TOVQgNnVQaolnQVBSh0feycI47wMGo1ceS3Zxb1Dtig4iZOA7YqKGnP6wi8KPEzjBkEg9hY1u6V+UZfgYRLCsEaq9lNYItu47kSJ/B8diKobNG5si6E5jbP7IrlAwSsG5W+9xeWQcA7YGxlg==;31:YWxMvCjV2kSe/e+Enw+EfQGr6dlPJs6dAvgJrj45hgVT39xgu1AOe/LWs55ZJ1XOuho90EPE+mGjGxQpOQWwTapBKFYwGEYSW95aS2WedIsQflrWMbOnd8fwVCB//CegkH1kIU/jk2ZASVJ262jCdmCj9Gk9J/NO2e72Dep3ILRQhtt4MWy04ZZasEmRanHCbLOs/5YkpD40hr8czRZUMLhic2m5b0qFOhEkaYziCOo=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27772E6FFB7C6D86D3C8B01FBCBE0@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(15185016700835)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:Ez3rfgylZOjRi17YCz8DuPocfL6swBqxIHTyCwZMPKoX8AE6NViYJEYe6t12xVIsp7rYfyfu2qhlPPsaPqBE1MjJCja1vTt7GVXQtVRT1p8FOfQTb5gucxMQbASh/5NOLSNTSBtcQ3pog7JQ/JkznfeA5lQ58y9IV5ZPavB9a5WvpnaHIew+e+sXCazx4+bO1ISAI7Lfq0chd6F2w/BMCetujc0+AVIaOJ5idzC3cU+p7GwfpZ5rB8Pey1/F3cAw8AfXzizV73FKlqed0JjeKkd+wop45K8k4RtcmYceNJr+Mct4LKblRVPV+zNKYg2RHoimuXlhsc3udEQS6e0QolmMOwxJPaE+dJDBEjgmpVSSvZZj2WPXkQc1Y+grm8dT
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(366004)(376002)(39830400003)(346002)(377424004)(501624003)(199004)(189003)(316002)(16576012)(6666003)(58126008)(476003)(2906002)(53936002)(6486002)(6246003)(229853002)(4326008)(36756003)(305945005)(7736002)(478600001)(486006)(230700001)(25786009)(3260700006)(31696002)(97736004)(6306002)(117156002)(66066001)(26005)(16526019)(77096007)(74482002)(956004)(50466002)(31686004)(186003)(105586002)(446003)(8676002)(11346002)(64126003)(106356001)(2616005)(8936002)(86362001)(65806001)(47776003)(5660300001)(65826007)(68736007)(2486003)(52146003)(23676004)(6116002)(81156014)(52116002)(36916002)(65956001)(53546011)(386003)(966005)(3846002)(76176011)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzc7MjM6dHV3c0ZwRUlNa1dDTzJ6RWQrNFpSUzBJ?=
 =?utf-8?B?ZGtsS1orczR1M00zbWd2cFpiRWhHYmExakllVkVvZTVTYXp4TEw0NG1pQXVQ?=
 =?utf-8?B?OEczSmZubzhpTC9GVlVqR0lkNzc2NVZnTEFWdGdNQXhiZ2FGVjROd01GU0F0?=
 =?utf-8?B?OWNQVjJsQk5XYkNVdWN6aXdDbzlKZmRYaTBtdVFaVXJETU9XTXhlQnZVWFpU?=
 =?utf-8?B?MHhWSUcwcklmWUl6aFBLZmxsNmcveXZjUjJrZ3FSUDNoZjN1Q2g4aFByUnhF?=
 =?utf-8?B?SERmdEpQRVpBRmVVNHJNTG8xaThZTS9nNWc4cXdqb2xoa0pMaFM2eDBXTnBJ?=
 =?utf-8?B?MExqd1ljbXpZSVBwbnVlbTFRYlUyT0dOS09uZzBiYW9VUEtxcEtlNGdWYjZB?=
 =?utf-8?B?L3JpeFVzY0lyamE5SlpaUFVpZ25EQm8rV0VDcDJvNk05NlF4c0JrcHVEeEhu?=
 =?utf-8?B?NkltUzB2MjM0cWtFR01kSnBRMGZuNmV5MG9FTjloNm5hZFFtSkpTaGgrMi9s?=
 =?utf-8?B?UlNqVExsVVZJdnY0SmRIeU1xcFVmT1poSFBkbEdFZlRtVVU1ZkluSnpTLzRX?=
 =?utf-8?B?M2JOcm1LZ29PcDFmNTY3c083V1dqR2FXVlN4OUxCZG51dUNNQ08yWjhmcjZE?=
 =?utf-8?B?TWJ3cEFpdnlwZHJCMUJIRzhUNkhjdE5sM0podFBYYlNEVGt3c2pDYmFpaEs0?=
 =?utf-8?B?ekR4M3VFekRhYlUyTWlKMkdXUjBjYkZSdE4wbHo3Z2VWQjNqanhqc1lyK0xn?=
 =?utf-8?B?QThkdGtydGxPakYxYkJmSDRZTmp1SGNGSUJkNDlIRUhvNjh0UEx2NjhkSFQ5?=
 =?utf-8?B?TzY4dlhVVkkvOTJjRXFjWkFzUWRDcXA2T0ZINVVPQ0NmKzlwQkg4T2thZEps?=
 =?utf-8?B?bVJ6V1BxQ0l0eStvOU1nQkJGdUpndVl3dlFYWnpIWW5nYzkyVEV2MjlGRW5N?=
 =?utf-8?B?RExkZEtUTW1kYk0xRUVRVG5kZHhudk45aUN4RlV3aUt1NC8yQXE0SzZZYTlL?=
 =?utf-8?B?NEtNV1FIcmxHcFJ0ZXJEQWZ3dlpjdnJnQUFseDFRR1BwRmNwVkZyLzBub1lD?=
 =?utf-8?B?ZjVxemovdDVScmIzUWI2MXlzeWhSakN1Y1J0RVdvYVFyMTZhcU1qNGdNbjVa?=
 =?utf-8?B?R2lJdDFVdlp5RUt2a2VPMlk3Z1kyWUxJRC95WGRocDlralQxYWJJSzlUVFE1?=
 =?utf-8?B?cnVQUnk4TW1ESU5KZERVaWl0RlR6anh3L0FrQk1kbWR4ZkJqUU5aajlKay9w?=
 =?utf-8?B?d3BVSGZ5TE9kdU5vbFJyTW9KZkptL20rR2k5Ny9lWTFjcFNjaWxWU2tkbEZx?=
 =?utf-8?B?VEhVUEFhWjY5VlFkMFFCVFRvc204MmM4bFA1MlBLeExrNzA0VC9NSE10STk1?=
 =?utf-8?B?WUx4UWxoRjBuNlFaWnBhWHkwdm8zdWN4dno3SG5tdXcveXZhTFB3bTNFQlJn?=
 =?utf-8?B?S1lNMnhNWjRFTko4WnN3ZDFFZ3JLQS9GTURCcHlhcE93UW5obnRiVGhCa1Rk?=
 =?utf-8?B?UFBZZ212VjRMM0dpek1oV0U4L0FDUDU3RUVDcWZ5dlQrcE1pdGFtOHFFMUZQ?=
 =?utf-8?B?ckZtNFNLbUtCam5mRW03TkNLeW5RQkZhdmF1MUNPUEpWTzhBSHB1YU8vRlBh?=
 =?utf-8?B?dm5DVVRRWUoxTDBFbENDbHNFRDIvMzNUeC9xNDZ4VThLSUp0VFprSVhPMXVM?=
 =?utf-8?B?ZjJFV2F1aGYvOVFvZmc4WGVrL0l6cy9CY2dRN3NkSnBPbXk0L2htdERQM0x4?=
 =?utf-8?B?OWdNLytYb2Vkei9KRGdxaHczemgwczBrcHNiNEMrdHEyYmRoa2VTMHZaa0RB?=
 =?utf-8?B?V2R3SnJlZWVDeW5oc2NpbjJ5WkNWMTVJVTY5SjdTZlJ6bk5qWXFITCtJVWUr?=
 =?utf-8?B?YjdDNXhpL1Zoem5CcE5sM2pYbnY2amtuQ0ZxeXRtMnEyUi9ROFBheVkxU0h3?=
 =?utf-8?B?anBLc2VKYzNLSmZUZndwRDJlY0c4UEd4cDBUUTNlZ2dpVVhaUlVhVjB5SDI4?=
 =?utf-8?B?QXZsOW5Fa0I0ME53NHEwUEdsUGxpQkRITkppUU1PalIwek9qQlp6SmtZU1E5?=
 =?utf-8?B?VE03NUtwcVJjblhoeHo5NEFIa1JseGFPdzBxamowS1JYdU5jK3M1d250SVZS?=
 =?utf-8?Q?rDdZxXkgDVbvutwFxnFEZrUY7BDV99DrGSVhWqrODs0p+p?=
X-Microsoft-Antispam-Message-Info: a1nSI6mKbwiWNGKTVW/k1Rc/zo66c+Ryw10Awz+nwUhz5tiZTo0oVYvNzhJTnWa5FluekNPZBUIbMQyTv3sm92KPQpxwsyTr6UBf8p2U1ymY7Yh4tPCUsffXRMpPLR5z+IsCk3y9wDG3WMKqKpGv0s54P8djr9ypbg0w+42OuoCIu1X0uqe31RM/ubIt8C7Y
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:2S4/vlvVnmkq+I4NXdy3G0WmY8ufyR3SqvVezmtbtmoR2/cpoZMCjyIdlZIjzD1G/TlgimXWM9Tnd4xQG0zVess7Xev5A7aGJPlGi2l7kGNW7VVwwj3wSJaf8sguKWpkvjfRm75z61Kb6MRp0pHQIwElu0XIbbsoLjdw7XX/+QSdnoUGRyZmUJGyCQw/Cj1KzSdDA/YQ2xllrPwP2MEN80me0U9rlVS7YVlZm2AppbZ+k75llGt1GkjHRJcWxJ0zCNyupWEnsH5eLkJ8UeYqHfenTR2nB5vySxwUZWlSMPj4Sa0oa79aQLBKdtC/WHKkpwywnw6NCo8Ku0WO4u+iDBjDNaUkYRMG/jLamWE8eadLsuy2F+W2CbGoCubwaIgn67McGUa8hxvKSV8UaeqcVpvBLoUyTLA+Hmg9RMitNu2L/XPQbEDUWXSWULpsAFq0T6aQKugnaYzSEsg2p9lfMg==;5:7M5rkxnaEvNWZxHamkrICzgcieGlviQBs2jzqVPVB0T/qHBFyl6BUnAe0D+GZufMttfTxjSBmnR9zQpMUQrgHfdF+DjR5NZMI4TPuqLQvQLThDHrmO08/xt6PBgeGvXHK5UXeQP3GMZ+GgD3F3zYZhPSwrQjZ19dWDZSEUIbpS0=;24:/IwMLKKTu0U/Rqmfpp8F61L93xrk8NdDnVPhxnPP7d8cOBilqDbLYbWflPYUkPYhyGRYDhcqLmB+3fLr5BaIQBvrzZzNdro6feQOlQtL5+Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:Vph9IArqfx+lh2WdvXAQMBgr1u6W9VrL8CPLtdrysK534DkecGwUPJHo7vb6yuwr1hHMRQk1IIFdLLgt0HpdCfZUJzSO4SW3QRNGXRQiS/kES5T1Ju7QbGuh5Ve9lAS5B59B/v2RJxW1igRITz9s+8LKrjsUjqB8y0GjgYAI5/C5TKPE5P9Y7NSM04vZkJYtDK7c6VbRj5asaZkhgPiYTWPCqKQhf82vd9BWHr70W9ZFqbBlA/A/fAM1uJo7qQGn
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:41:01.6231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bc24f8-16cd-47cf-f3db-08d59ef976cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 16:11, Wolfram Sang wrote:
> The number of I2C host controller drivers keeps increasing, and although
> I had some success acquiring specific driver maintainers, my bandwidth
> is by far not enough to act as a fallback for the rest of the drivers.
> To reflect this status-quo in MAINTAINERS, add a seperate entry for I2C
> host drivers, let the I2C list (= community) be the contact point, and
> mark this section as "Odd fixes".
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> 
> Joe: my tests worked fine with the file patterns; yet I'd appreciate if you
> had time to double check them. Thanks!
> 
>  MAINTAINERS | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d296bdce328..2f7ccdcf76f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6580,15 +6580,23 @@ W:	https://i2c.wiki.kernel.org/
>  Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/i2c/
> +F:	Documentation/devicetree/bindings/i2c/i2c.txt
>  F:	Documentation/i2c/
> -F:	drivers/i2c/
> -F:	drivers/i2c/*/
> +F:	drivers/i2c/*
>  F:	include/linux/i2c.h
>  F:	include/linux/i2c-*.h
>  F:	include/uapi/linux/i2c.h
>  F:	include/uapi/linux/i2c-*.h

Hmm, I think you are ducking out from the i2c-mux-pinctrl driver as well.
Was that the intent?

> +I2C SUBSYSTEM DRIVERS
> +L:	linux-i2c@vger.kernel.org
> +W:	https://i2c.wiki.kernel.org/
> +Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/i2c/
> +F:	drivers/i2c/*/
> +

And this includes all the other muxes, i.e. those that are "mine". Maybe
not a problem, but what do I know?

Cheers,
Peter

>  I2C-TAOS-EVM DRIVER
>  M:	Jean Delvare <jdelvare@suse.com>
>  L:	linux-i2c@vger.kernel.org
> 
