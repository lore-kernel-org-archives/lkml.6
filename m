Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELsJPf6aJ0hZ0mcsl4+j1c2g2ShStFbdY67OjpyPwEb2O1rYzPzAgjFOeeZAdavbn8p7jizE
ARC-Seal: i=1; a=rsa-sha256; t=1521457405; cv=none;
        d=google.com; s=arc-20160816;
        b=Xowz7AvuQUL0ITqpzGhyREomiWs9et5PmW3z0K9+/xrvOnD0Wzr8qHawUlP3aZ+l38
         LushBxxk/iimAxnPJJ2IVGC/FxmaEWr9DJxYA7bCr+Dp6dseIspKXAw2HyhJ9d5pwiHo
         5nEIyDQLpdGIPYM+fp8dAu33GYE3IjLs7hvTVOXrcZefWOAZOHgJzLFiJiC42MnlpYUw
         wFzjS8TqAddVcSbbSDHvAM5nQJdDPJp/DOKH0OhlOobkeQRrx22bqfzkYKb0X1ZFcQpF
         VSwTk4hddcQpM7IojxFlux5HfpX5U/hafQzK4fwZEtJxkRtmeIJQZTAdrTZsmqaGGZ7y
         uDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=lnyO7Ae3JSevmtd7oe++G+Ss7PHvbE55Qr6RHNdcGHw=;
        b=lTy/4cOj9Q0pfv/dafa6rHaU2JEAdwPsINSE9lWAJZz6IGgTpyQHQJoKahSq2mv5UH
         j1A+kQN0jvh+JQbWAjILQAwIzY/NlyB8VQ2xgzD9blnJ75vRZ+lpUh7twFCpif6LC7hj
         cSUjaX1zc1OJB1i1nPIdEznc2gRDpD6fNQCHcjKYN340GWFIZNoHfJKVnXFvxyg7/BuM
         SaznEIGRXnoMjNrREk3wPVdBaJbUrGqIs5widz+Hm17DHyY/AZopSeGDicbrKqR0JiVl
         zjaGjioRkvvUtHylN/gAzheGgg/bTUdtYDtcT4cm2lozrPPuHkcIxgLpN878jkwXkNp6
         TElg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=NroQ005m;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.104 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=NroQ005m;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.104 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL
 boiler-plate
To: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180319091721.18193-1-brgl@bgdev.pl>
 <20180319091721.18193-5-brgl@bgdev.pl>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
Date: Mon, 19 Mar 2018 12:03:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319091721.18193-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM3PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:207:8::17) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 474e98c1-eb8d-45e0-21db-08d58d8905c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:7SG4ZnyAWwGF2WHrc75Bhr+LPt2J6oOue4FPW2QV3/SpohaiNxXViW0BOivKfs/iCr73XeqDzIpDQ7Cu+fztV4kUBj98L3gLpAfWgPULnlWiCpAU3s7KOfNrB1FOWNCVpTrYS+vQoHcLj10lCl0935AF62ClxYGnDLHUUO1KMxRBoKEq0FIH8tLqO5Qqxj7Kbsvq30swFB6mjYcePkbSxguy2GKFjCK6xTA5kMJm3g210YC/HVh+2XCLH6R3p20f;25:AZcW32qUofGEFQuGX0YqzusZEmJMiT3wX55qCK3RxbXI+4phK5xepWoSYi81I6tk98iGSv/ZOUq6nK3GCVNoHgO/No/IYGnHJR6XSCyaK+JB7IYdU+/hYCb100y8yaPjVl//jlguHfnHIisO5CNqWEzzDJzeNLyGry48YijKwcBNmqg521C3IVxZXsCU1QIewO+dsDZTSb0Kr+oVpH3y5xmhU/8GQ8bH4wv1QRnbBnpUgl+ILvVIM1z1Khlr3g10XrGbL8L8PIADug5JhjjLh0qDvQ7Xf8rjAzuWPi0rNo58sa1c0UqIsxoK+iWmnMzd6QAzE/rKSlCC0pNTiDEdIg==;31:9d2p1y/9Uh+rlkqoCQZR7rBhkqw/Y154jGP5e23xUF+USYZBuqrzyO+b5pq5fLHzzkPSueWPrzk6B98eQrKaBMqQSIKs+H06aYeeXfarslKdNYlQewfetOgVnS6T5NMP2KiUYc355l5TWcc2ZN9idtRLOrFMgvF/02BPNKlOQXb/+hrqTZ84+Or456ExQqWgRzmOpJAct2bSJR/CP43GPkK7Va8QPD1H9g2PuQ8lKvk=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277871F37ECA5E1AB8A8C09ABCD40@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:DELHgSDX7CTrNHyMj1F2SjzywsL0wd2EQh9BetPUWqimGQ7czhSlAqsHRs12YB3a2xwBqVpa/zkmtTjYG29BMxm8EbirabK5pJsYIvXy1N1v/mj7mt99BRZtCHHKHt2NM1E1cqo/HdK3I39vs8FSoAr87CuAgzW0H9pIzVI9/ve754b3vzXqbBgqyXFiIu1XDwV8qXv0tY+XLuiwq40xAEqTUpCXtXuplP2+WStfMjIYFgvZvlq4h+RxkYgOKDrFgcVMLybDLa8wZYuIYicutOkyGrCMkQiIu2IYAGvv9Hy8grpLsXOQQfZW/tOgWwiX
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(346002)(39380400002)(366004)(39830400003)(199004)(189003)(377424004)(65806001)(117156002)(8676002)(106356001)(50466002)(6666003)(6486002)(8936002)(6246003)(68736007)(105586002)(229853002)(31696002)(230700001)(65956001)(31686004)(86362001)(81156014)(53936002)(2950100002)(36756003)(316002)(81166006)(478600001)(77096007)(16526019)(186003)(26005)(16576012)(53546011)(386003)(5660300001)(110136005)(25786009)(2486003)(52116002)(36916002)(23676004)(52146003)(76176011)(64126003)(65826007)(7736002)(6116002)(305945005)(66066001)(47776003)(3260700006)(97736004)(4326008)(74482002)(3846002)(58126008)(2906002)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6ZEVMNHRHeFhSQ1BUdW5RZFlXN1FLUTlK?=
 =?utf-8?B?ZWNVTC9IaGtKT1o4a2luOEtOVmU4R2NIeCtDOTVaRkZoUU1keFdLdm8yZnhE?=
 =?utf-8?B?ajZZV1FaVm9vZ3JQTExSOXZ6SmVtQ3UxVkJVdWFXR3MzQlNWRklWSzd3ZGhK?=
 =?utf-8?B?NVYzREYzVnEzTUFhTmFZV1pRWUFXQXZUZTNtMTNsVm9mSERkajhDaExrWndH?=
 =?utf-8?B?d3NpdFlQQ05zQVExVmxrUmxiL2cvQlJSVTNqcjNGbDVPYlpDYmV3LzRtbDdZ?=
 =?utf-8?B?STQwY0FBV2tpamhueEI1TjIyQ0FGbERwdEU2VXVlZ1RBTEY5c0JwNzlnWXlN?=
 =?utf-8?B?SGhzWUxlMS9yZkN5SHFEcENvMjYvRFBrR0xXRkhibUhtSUtBK2tnOXFSYUVZ?=
 =?utf-8?B?Z0syczZ1OG00bit4M1d6N21Ebm40d3hYNmV1ZXdYNExQQ2V5Y3NoNHZaY01H?=
 =?utf-8?B?VURERUtQR21GcXNNaVpqQjV0QlNhTnB3cmlhRFpDRXUyY2xRWk5QTFYvVUk0?=
 =?utf-8?B?TzMycndPZ3cwZWJ6VGpYelVLOXRtV2Y2Q2gwckZETXRBTVdnYmVVUklxRXZW?=
 =?utf-8?B?LzhFWkVMUmQzSXNVT0J4bXNPNjMwOE5GTzloMCswaXcvV1V6SDJOVlBhRTM3?=
 =?utf-8?B?OWFPOTZJUklzdGdWcnl3ayttTmJBRThnUGZOUm1ZdTc4Wjc5eXppMkRDUTBV?=
 =?utf-8?B?bFExTVA3V0gxU0ZFRG82cFBYaGFnZTV5SWR5NjBsNTk4cGp0OTFzZzhuS2o5?=
 =?utf-8?B?NzdvTW9MYUZJSHdXcTBPZmg4SzljTU1CbHd1NUNwZ1RKeDhmcFFLZ2lqL2Zl?=
 =?utf-8?B?OVQ2Z0VaY0ZwQzg5dFRsS3JsbE5VeG51UXk0a05uVjBvb29ySWdtb3BGdzhC?=
 =?utf-8?B?Q3ozM2ZEcWt2bmtKTWwzWUdhNW9FaHRpWVMwcnZLSTlDU0VJRHY1dkd4c3Bz?=
 =?utf-8?B?SnVZZW1hRVRXSTVjRDhWMDM2ZVpBdEMvTjlkWmUxZnozV2g3d2VYVUg0Q1Mr?=
 =?utf-8?B?WjcrUllSbUFXUXp6OEw4UVRqUVJXMWZEdFRIeTVPV3hnakFLV0VYbHJrNnRl?=
 =?utf-8?B?UHdMRnk2NW5zQjdGQnlBdHEwRVNmZE9CWWJ1ckVpdHpQOEhaYVVEaWNsTVd2?=
 =?utf-8?B?cFMrREhGMnBVcW9TMWxmNnZsUjBFV04wRlhXakQ2Q09GeFNLMzI4SUJYOTZk?=
 =?utf-8?B?S3c3QXQ4cFNjYVhDei9FK1cyNGgzcklJdUx6Sm56UW9mZWZMRjJKb2Z3UXVO?=
 =?utf-8?B?L1B5bFZQUEIrQ2lZREZscDNhZWQzckhhVURycE9MUWFpZWxtNDZyQWlzZHBu?=
 =?utf-8?B?Y3hkdmc0R3pTUTJUQi9paE5zeCtTN0xTTjU4NEs2WVpxWXdwcjhSQUdlRGc0?=
 =?utf-8?B?REpCb2NCMGtkN095RmUva1dPVTRsTEswVVdIaXBtdHdrQkNIRG5oQ1UzcE1q?=
 =?utf-8?B?STFRRnVDUDhleExwc09pamJJMitORGJzZWp3NFVNUExXZ21OaHhQa1E5d3Qz?=
 =?utf-8?B?dEJTY0ZRQlZwTUdYM0ZTVEpQYk10dE1DUFgrRVlSNDY0b2swRk95cThvQjRD?=
 =?utf-8?B?dTJNMWsyQkRna2EycVozdGJISVBGNUlNVFF5bHl5blp2Q3BZcVZBSHhFY2sw?=
 =?utf-8?B?aENSTXlXaVczdE5VSko5NHZWTlVuTG5EUHlVeFFIYzVUTDdLU1BNdnh2S0p0?=
 =?utf-8?B?ak5jam1MWEwxOXNXc1lzQmNEaEEwWkhQWFI2cm52L2tEb2lIWWFSQWZZZkhK?=
 =?utf-8?B?U2dzR3F1OE1kb0NFUlZ1VVZCYThVTEhoR0R1Z2J6ZG9KcjRUdlh0VmQwL0lZ?=
 =?utf-8?B?ZHB6bVJ5WWNuQUx3Vy9oWUFQcEtZaEt3NVA4RHZkVDVxSUNjWkxkMTYxbFJv?=
 =?utf-8?B?cmgwdmxQYm5qSjkwKzJTS2dQdHprd3hBRHI2OXBnbmR0Z1R2dWU1SnAxTS9v?=
 =?utf-8?B?d01Namd4QmtFTzVsRFV2OFIxNlFhYVpud3BHZUwzWCtyWGZ0WDFDRGgxOWRl?=
 =?utf-8?B?akVWZTFhQ0h0bnY5cUsvUWxSSksxMGFNOUVReXl3PT0=?=
X-Microsoft-Antispam-Message-Info: rbQKL3CqRE0FGQi9O011fKa6Q16bSXHPTKPPRrJut/O+617fFjf3KZ3Mz7O4vj/R8QJy4Cc7n6uk7O6UanI8BDs63mvtM29ho3k9L2g5mwx2FQmDpm6lCT9wP3rq1ejQlbysiA8jykmJFxdyEvDYhVVlXQ+K9RMeQnkNY4nc6T/t2whaK9x3CZjn6BHvrAuQ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:nSjRFMiNhNnQuRj9QSSdIA4IcUPZoILJGmq8D8ddUSO0XiWfywO0hEWnUZB8bpkV1F0+mmosR1D9VnwageK9+81j8lTiccZCX+2Kqdw4dLPAfVo0vL1TOSUzJ62hmNYo6RVxTJANxmsUfgH0PVdjyN8Owv9cCyVnqKh7dESLKOMZ9DOpiJbI5glBAZmU2K13rmQ2u/rrYBOfBlhn19fkBPdWdN5IyBFJjJFsOV7MV6Ef5nCl02gM3QGTAUiQmonW20TPBTZ8H8XgK3raP19W6NSyzymVJJ60BJ+nc7aVfmLGIsyNHKCMhx5HWmweAmPp/vQt/gvq4LufWqZicbYnVvOTV18Z/Hi0Oej3CyHdljo=;5:WlNuZtbmLRNozk3tEwA5GYwkAE7oPSPSYvy4T6UIMB+ngrizJQnavP8k4dr47XDD38p+ZK5PyelqKkecvQC8JUG+C2UcLNC5+xhS9JGV2TJ/kQge4Zx5SuuGUpnrXqmlqoY8XHONfpvBFY/BREs9ZD0RE+TNIMQJFJ6KdH+LM0w=;24:H6Wh+A48+nxHPWF6IkYAd/vlu9rcNbOBTasGwD9IJ8Gry5yc4LUJxv2K3203dxU2MuTuSY5KCdG+pFWzagI9w7HcYeZzdg6Yolbh5h2dRnU=;7:0GwI3PxBklLTGD9n/bynCXjrgb0ZVK7ofM5KKF/xSl5qpvgLpAL4hTfRfHZ7mMoE1wt4Iq0wuK43W88BQ25REx/LDYGRq/hhwO4cOomTyQZS0VIzPQI/1PhGRuH8EmC0hJrkhA+xKzyNbuPAZDLlHiRv1yU8F1qwmKL4D3oHuAKg/VPpF+Dcq4ph5F4x4xcD+LOjxeeunjV2YD5FkPKgpkBEDRnp+Cu1FWoilcCTuQygEwjshW16dk+tc4LgBG7b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 11:03:18.4674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 474e98c1-eb8d-45e0-21db-08d58d8905c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357056282465424?=
X-GMAIL-MSGID: =?utf-8?q?1595363719836077292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-19 10:17, Bartosz Golaszewski wrote:
> Replace the GPL header with an SPDX identifier for GPL-2.0.

Great care should be exercised when dealing with copyrights of others.

> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2a4154eeb1bd..0e06201d33c9 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -1,14 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This should be 2.0+

Also, use a // style comment for the SPDX line in C files.

Cheers,
Peter

>  /*
>   * at24.c - handle most I2C EEPROMs
>   *
>   * Copyright (C) 2005-2007 David Brownell
>   * Copyright (C) 2008 Wolfram Sang, Pengutronix
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>   */
> +
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> 
