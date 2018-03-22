Return-Path: <y.k.oh@samsung.com>
X-Google-Smtp-Source: AG47ELvxglvURmr/VMtrGvgQkuTn9rybMBuYTSMB9uQhw0Xfr0VUAeUL/68o5Iuiqr3Qk0kba6M7
ARC-Seal: i=1; a=rsa-sha256; t=1521709498; cv=none;
        d=google.com; s=arc-20160816;
        b=fxysEeBTrqj75MdYSA+b2XXzJ7UD1HP/u0ZfOlxPZHLtmKLcR03CrWk6RzIzUjfTzg
         9btZViTKpqYciuDVM6bzHD9y0cXKMrkGt18n7Aqk93bx7b2AS0kKxR8ECpr10GZrdn6V
         1BvVWbduzh8N0oSPRqIpPgyAohw6jgiYwe82uM5XS2GkGfA8GHp2dEYhb91KI7Z++HkS
         D932HmTkCkszMxt8fQM2mESOI1Apr4+AirFhx1VPDz5BTWJ2/fhtuzlx5S7fUs6RMMOT
         UyvJWek5CUrYx4Hv9goB0yooh/lYDM7T41hFIbpDdHFSmtY8eknsoXig5PNCFi3l13+Q
         L+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:to:subject:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=98MnKlOxKzDNMB5ja8ZGWHMU7eTmvpQGQzSQRO/8J4A=;
        b=hVKOs53LXQHeyKknX1wszz1GvUwbDI9rkcAs3GCwDSCdbjSMC1ynvdYZ9ADniUPL8G
         fh5G2PhudB/YH4hAIjcFFZS9J9gSuLhICVgTkS82CvJOpV02aRdssYfErAZQZkOc93uO
         bcblKNyxyj0jS6Xp68VsWUMbdSRcZDtR44dR7gEFXmqOMk4IaHhXrLK0dW12mFzweeMH
         YhWe2XMU4IkxvLnmnml3T4pbctZWmx8bJ0gVATO1xhmnLRjV5CPexbQtQPS863cnZfUn
         JL30zWk/hWv1aUzep7vmnQkPVZg1hRuPinUyWOVH69CoHWlo9zttJ6aT2v7q6ok19iRq
         y7vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=Gp5AKfT+;
       spf=pass (google.com: domain of y.k.oh@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=y.k.oh@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=Gp5AKfT+;
       spf=pass (google.com: domain of y.k.oh@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=y.k.oh@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180322090456epoutp04f3f0f99aa0a4e6e4f39de49e24c854c9~eMrltf3z31488414884epoutp048
X-AuditID: b6c32a37-433ff70000001029-72-5ab371b7d1d4
Subject: Re: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: YOUNGKEUN OH <y.k.oh@samsung.com>
Message-id: <48d2c42a-dd04-23fd-feaa-0d90d62b0626@samsung.com>
Date: Thu, 22 Mar 2018 18:04:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180322084511.GA6211@kroah.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmvu72ws1RBkc+m1g0L17PZjFlwwcm
	i623pC0u75rDZnFmcS+7A6vH/rlr2D3Wb7nK4vF5k1wAc1SqTUZqYkpqkUJqXnJ+SmZeuq2S
	d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
	fnGJrVK0oaGRnqGBuZ6RkZGeiXmslZEpUElCasa+C7NYC17yVUw7Pp+1gbGPp4uRk0NCwETi
	Tucb9i5GLg4hgR2MEm8+T2WCcL4zSrQumMQCUzX59lyoqt2MEo1rv7FBOPcZJR4cbGQFqRIW
	SJE4OO8nI4gtIqAh8fLoLbBuZoEiiUkX34LF2QTUJab03GMCsXkF7CT+X3kGVsMioCpx8+hN
	sDmiAhESC6c+ZYSoEZT4MfkeWA2ngJ7E3s77zBAzNSVefJkENV9corn1JpQtL7F5zVtmkOMk
	BNawSTxofswG8YKLxOVjsxghbGGJV8e3AL3DAWRLS1w6agsRbmaUWLO7HqK3g1Hi493PUL3G
	Er09F6AW80m8+9rDCtHLK9HRJgRR4iHxs3UhE4TtKHF0y2wWSABNZpKYduES+wRGuVlI/pmF
	5IdZSH6YheSHBYwsqxjFUguKc9NTiw0LjPWKE3OLS/PS9ZLzczcxglOclvkOxg3nfA4xCnAw
	KvHwZuRsihJiTSwrrsw9xCjBwawkwntIc3OUEG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4H
	pt+8knhDE0sDEzMjU1NDAwsTJXHegACXKCGB9MSS1OzU1ILUIpg+Jg5OqQbGpvMHv7y6PV2U
	2+JD+Y/UGzouNoFhL06ycs7taoz2999h/axww8bKy2cDd61bWrTqYH7y36r8eu8v8qWZVaoT
	jtzunpVtNc20KrNwAruDbsGOqO/bpAMc5/8TMFpQ1/+I9462girPlVsab7esmvXc7o992rMt
	N+9y/Pr3uU5g8t8AMVd39/+hSizFGYmGWsxFxYkAE1uh24cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t9jAd3thZujDOZOVbBoXryezWLKhg9M
	FltvSVtc3jWHzeLM4l52B1aP/XPXsHus33KVxePzJrkA5igum5TUnMyy1CJ9uwSujH0XZrEW
	vOSrmHZ8PmsDYx9PFyMnh4SAicTk23PZuxi5OIQEdjJKTP13G8p5yCjx4UUrK0iVsECKxMF5
	PxlBbBEBDYmXR2+xgNjMAkUSzYv/s0E0TGWSOHbmBxNIgk1AXWJKzz0wm1fATuL/lWdgDSwC
	qhI3j94EGyoqECHRuXI+C0SNoMSPyffAbE4BPYm9nfeZuxg5gBYAzZmSC7FLXKK59SbUXnmJ
	zWveMk9gFJiFpHsWQscsJB2zkHQsYGRZxSiZWlCcm55bbFRgmJdarlecmFtcmpeul5yfu4kR
	GNrbDmv17WC8vyT+EKMAB6MSD29GzqYoIdbEsuLK3EOMEhzMSiK8hzQ3RwnxpiRWVqUW5ccX
	leakFh9ilOZgURLnvZ13LFJIID2xJDU7NbUgtQgmy8TBKdXAGHS1vojx2N5dxoWavfcNnhqb
	C/hXmZ59UKTz+Pvsjaai+98mKtRon43kP/Fdss3NfE/1MxP/p8nybeGy4mXVjUv7hT+YFPBc
	fW0cXp3PrGUt4fU5QeFkXI3t6b590TKKXyPvzLuwLzNKqZxx3/MTX49PE1jDYJPwaOmKx3fZ
	A5adYM6eUWOsxFKckWioxVxUnAgAtS9ZmGkCAAA=
X-CMS-MailID: 20180322090455epcas1p1fc3afc3e13e2f843169620f90b080459
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180314021710epcas1p3766602fe312f87d916cab69af2acf203
X-RootMTR: 20180314021710epcas1p3766602fe312f87d916cab69af2acf203
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
	<1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
	<20180314135804.GA21350@kroah.com>
	<2f2dcf3c-2432-3dc7-5fd4-f9326ef48455@samsung.com>
	<20180322084511.GA6211@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594877629570662898?=
X-GMAIL-MSGID: =?utf-8?q?1595628059204653931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/22/2018 05:45 PM, Greg KH wrote:
> On Thu, Mar 22, 2018 at 01:37:45PM +0900, y.k.oh wrote:
>>
>>
>> On 03/14/2018 10:58 PM, Greg KH wrote:
>>> On Wed, Mar 14, 2018 at 11:17:05AM +0900, YOUNGKEUN OH wrote:
>>>> Cleanup checkpatch error:
>>>> ERROR: Macros with complex values should be enclosed in parentheses
>>>>
>>>> Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
>>>> ---
>>>>  drivers/tty/serial/samsung.c | 16 ++++++++--------
>>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>>>> index 3f2f8c1..da9bddb1 100644
>>>> --- a/drivers/tty/serial/samsung.c
>>>> +++ b/drivers/tty/serial/samsung.c
>>>> @@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
>>>>  }
>>>>  console_initcall(s3c24xx_serial_console_init);
>>>>
>>>> -#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
>>>> +#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)
>>>
>>> That's not a complex macro!
>>>
>>> Please use checkpatch as a hint, not the "truth".
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>> Dear Greg.
>>
>> Yes! Of course that's not a pretty complex macro. However, I think it is
>> important to make a small effort to modify the minimum standard,
>> Checkpatch ERROR, to ensure consistency in the Linux code.
>> Starting with this Checkpatch error of samsung.c, I would like to start
>> my efforts on contribution from a small point.  Please review it again.
> 
> Why would I review something again that is not correct?
> 
> If you wish to start out in kernel development, please start in
> drivers/staging/*/TODO, not in "core" kernel code.  That is what the
> drivers/staging/ code is there for.
> 
> good luck!
> 
> greg k-h
> 
Dear Greg.

Thank you for your comment. I'll see you soon with a good patch.

Sincerely,
Youngkeun Oh
