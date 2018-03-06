Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AG47ELvSn1dMZIbEwPCHc8KYUYJdFvv9sLRwivZqFu59D5y6OeRmFNwi/WHAh9Lam8uw9f8o/rw8
ARC-Seal: i=1; a=rsa-sha256; t=1520332234; cv=none;
        d=google.com; s=arc-20160816;
        b=os+3hTvN32nDGVYO7A1Hv0Y4/WKaR8NSLIb8XlHHUVIItyDew7emM5/nVdo9ugWyZ5
         mk5uEvp15cyHTS2JUPzWuZ9pjDKSP8Votp0nsafXn2AQZpE0XhrAsG1hQbfclqFr/Oxa
         R0zIvpexGU7779GVUJ06sf3VBe3fwYATKIFjZLNVcIbOUFSDfmjY6t6aOF5c5HneB8gg
         HbJTHN3ITIcJfZraM3rtyANARb4z42zC6rNu8IssxjkU7jhgBeNoES1fpcrc5Nb1lL8c
         W+vcPiaZVc1HOy9qzoPdlAQYkyrVv4Y7fq5XP8egx76wknxmw+ZCLFvhhvFHpY/ViOkH
         7Qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=RB/2JJ9BEE33RsxlKZts8cn7l/OdwsLjzfoNodX/Db0=;
        b=xollrs2DawyUytaDZN1t0zAAcLXmew4xtvtRQ1QRmOsUuQeCc+sfyvx8Gg7gOtVx/f
         +ZUIRr0FAfG+gF3Ir22W5tRdP9JClm8AoXxEqik5MvpSBpm5V/o84geF2a+JwQQusHZB
         +L3xXDLgJb0hC4fCXL7zU0IiLtIK6PiNRN/6EaEpOIroXJvqGJiRItnvm0MQ1w7g4dVe
         cDMSlDHihy7vH+1Gfbw66xAN9xPx9hVF9CzQfiB9AXzPszLKmTbvcQKL61x//SbMhUEB
         Jgf++wZslGBeVdGyykwpcKK9fjCuGCTwkVPkJFeDdEUF3Tcfdo3PZdXQse+auCWdqrT+
         WxFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Subject: Re: [PATCH 2/5] staging: vc04_services: Remove cache-line-size
 property.
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Phil Elwell <phil@raspberrypi.org>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20180305202806.21219-1-eric@anholt.net>
 <20180305202806.21219-3-eric@anholt.net>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com>
Date: Tue, 6 Mar 2018 11:30:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305202806.21219-3-eric@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K0:2rZBOEjZg3t9QzfregDzQCZdCtXG4n46jo2tpbCTT3Nvow801b0
 Jt0MAOOVyGkEbGLtSmBJoPOz+hHx9eoQ1HvCADv18dm/d35uB/c4JC0BnzdEi0ZJelxDJti
 u4rezm/XzjzUOpQnLFqVNvUs5Jb4abwhoTIqxkJsnWGJyxkGbSxg9K+FJRubOaEGG0LOngz
 5Iu1fJqQ0ZqublBuJC78A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rScMP/T8vTQ=:H6Uj+StgFwxblLUlE97P8q
 k0GlgY+x2gSUQpnwCr9d9K/70i6ZpT+AQ2WKv4Dti5VWNEntHLwQSYkeuERuCxGzqspvg5GiK
 +6xNW+0IeUsWPtvPsBwdLBDsTXwkpqEF/SfSPcB7kO7U0qjG1RaK9LMd6WgwN9GH/1VH0tuAg
 tepPdIU5fTVZY6xDj0DBFUmLKD33TneexzfN/4gxjzXS5fS8QZ7HHrKCPJwXx8ET1FBYFX8li
 irCKWwMgb8U/ymGq3DyHO7gVozHV5D2QhWm0MTyCrtCsA7v+dLiOTnGY7FRfl3QuJ/gxc95f1
 LSucIGDqA+ge91Io7yapmJt0jWRjD2DqZB20XE0P6qLfNkBKEKzSE6QKoukoWscxsHxKCIBul
 /lwn4tVbfuM6Whd+Fpxtrg7Ohm2X0u53GfwqZdxpzPAQmwCk3FN1/Z3WJcrIXjSVyHMsAi9Vo
 rm4wFOrqF5eFTeQ2BgYJJrKaCBBNSM3hjv22G7mZD/htpZvjRzppaJnVvHsvkZDUc/vsRKarH
 p/6StQvB+Na1cB3ZgDCdDVdd0IEs8cuMHQhQu8bhVli+NCBdxGoa7+I50cyv/+Q5O6BRT8+br
 pCLpFBOrHjBM2gSHA7/LOnDwFX/JNp6QvWoGBJGLB6RNtY90cJ65XRR+gaiNpXd885iH7AAXk
 /85YMgjPYTREcvD33W+tGydHGyMGxM6aMEkI7OTOUodQq9W2N6ZDFADPD3cqKTpUlSjnbLrKc
 443gAhbon21SBFkzBFegtyV9hAqkKwZ3D6U0+SC8fi5B3MXcn3GAxKVVc1s=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130896333791997?=
X-GMAIL-MSGID: =?utf-8?q?1594183893058651528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,


Am 05.03.2018 um 21:28 schrieb Eric Anholt:
> This was just a way for the DT-passed value to get out of sync with
> what Linux has configured the ARM for.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>   .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++---------------
>   .../interface/vchiq_arm/vchiq_pagelist.h           |  1 -
>   2 files changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> index b59ef14890aa..e0e01c812036 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> @@ -77,7 +77,6 @@ struct vchiq_pagelist_info {
>   };
>   
>   static void __iomem *g_regs;
> -static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
>   static unsigned int g_fragments_size;
>   static char *g_fragments_base;
>   static char *g_free_fragments;
> @@ -117,15 +116,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
>   	if (err < 0)
>   		return err;
>   
> -	err = of_property_read_u32(dev->of_node, "cache-line-size",
> -				   &g_cache_line_size);
> -
> -	if (err) {
> -		dev_err(dev, "Missing cache-line-size property\n");
> -		return -ENODEV;
> -	}
> -
> -	g_fragments_size = 2 * g_cache_line_size;
> +	g_fragments_size = 2 * cache_line_size();
>   
>   	/* Allocate space for the channels in coherent memory */
>   	slot_mem_size = PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
> @@ -548,9 +539,9 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
>   
>   	/* Partial cache lines (fragments) require special measures */
>   	if ((type == PAGELIST_READ) &&
> -		((pagelist->offset & (g_cache_line_size - 1)) ||
> +		((pagelist->offset & (cache_line_size() - 1)) ||
>   		((pagelist->offset + pagelist->length) &
> -		(g_cache_line_size - 1)))) {
> +		 (cache_line_size() - 1)))) {
>   		char *fragments;
>   
>   		if (down_interruptible(&g_free_fragments_sema) != 0) {
> @@ -598,10 +589,10 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>   			g_fragments_size;
>   		int head_bytes, tail_bytes;
>   
> -		head_bytes = (g_cache_line_size - pagelist->offset) &
> -			(g_cache_line_size - 1);
> +		head_bytes = (cache_line_size() - pagelist->offset) &
> +			(cache_line_size() - 1);
>   		tail_bytes = (pagelist->offset + actual) &
> -			(g_cache_line_size - 1);
> +			(cache_line_size() - 1);

should it be so easy? Back in 2016 we said that cache_line_size() won't 
work. I always thought that we need the cache line size of L2 not of the 
L1 one.

Did you already test the behavior for these combinations?
BCM2835 ARM32, expected cache line size = 32
BCM2836 ARM32, expected cache line size = 64
BCM2837 ARM32, expected cache line size = 64
BCM2837 ARM64, expected cache line size = 64

Regards
Stefan

>   
>   		if ((actual >= 0) && (head_bytes != 0)) {
>   			if (head_bytes > actual)
> @@ -617,8 +608,8 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>   			(tail_bytes != 0)) {
>   			memcpy((char *)kmap(pages[num_pages - 1]) +
>   				((pagelist->offset + actual) &
> -				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
> -				fragments + g_cache_line_size,
> +				(PAGE_SIZE - 1) & ~(cache_line_size() - 1)),
> +				fragments + cache_line_size(),
>   				tail_bytes);
>   			kunmap(pages[num_pages - 1]);
>   		}
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
> index a6c5f7cc78f0..bec411061554 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
> @@ -34,7 +34,6 @@
>   #ifndef VCHIQ_PAGELIST_H
>   #define VCHIQ_PAGELIST_H
>   
> -#define CACHE_LINE_SIZE 32
>   #define PAGELIST_WRITE 0
>   #define PAGELIST_READ 1
>   #define PAGELIST_READ_WITH_FRAGMENTS 2
