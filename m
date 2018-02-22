Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBDNPXPKAKGQER52CL5Q@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519310734; cv=pass;
        d=google.com; s=arc-20160816;
        b=0PhBMx/WN61S/b7IHHvsCfTAaHYRvu78RdIhkulFvNg752IJMrrOQZpkcV6VIg1S4G
         BRpM3N7pZ6kzOtfcZNIKHv6O+0bj4/MQwNWYy5g8lb4j/xUxLAer9PNdjJ/CdHhd6oAf
         SPKjzXMCFa/ixlTYDtJBHTJIGroCmojhHl3+AO3P2UhrIQBu6ugY+EAgf010aByo44Ww
         ZGvxsN70jmqvEpmXueJUaAtav0FEbsto3IiL2CsFxWoC8s17U5p+rhnsjEtbws2xGUfo
         hM5GgUt+niXLb80g+5gTZB/jjlzAW+sMULdjYt7Lp9K2KeOEbJLxRTRwwn5XXGPJ7ixz
         EutA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=zdFOzBXW+wzC7Um2GESDmBHRPOngWeFX9MsFbFutrDc=;
        b=VJGWEZTYREg1xOADHLUA644kFAvdtI8alPBcZ101kKU5cVVsV/9qzOXoL9UL0V3f18
         Bib/DFYC9nWidYvJ84PRNuUwkmCdH1XIgla5mEKW2hVAq4LMV78HO9GhwNbm+QIerBiP
         RZZuA1Hhyuz03Xde8DOeVPwNT2y2cfH4EWLg9XcAy1SEZNt2IiIxrjmc6nE+W3R2odm7
         Y4nXPbcokk7rBlGAtNWDQMibWCYoWIr7O+NnK4wUVxuquXU+RXG2DirAPUjn6SOU5yzz
         W5T/GB2mCFIHMoQkXNuWjauSeutCYhFU1WfgWzx9T3yX9RsiTYwKNB02XxpVATccCv/Q
         BuQQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ICCAbjlL;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbdnpxpkakgqer52cl5q@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBDNPXPKAKGQER52CL5Q@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ICCAbjlL;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrbdnpxpkakgqer52cl5q@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBDNPXPKAKGQER52CL5Q@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519310734; cv=pass;
        d=google.com; s=arc-20160816;
        b=ee9eSIMXgddq9KskssqjNbxOzsQqqL5Nuw0aJBEAaR9if2AE/soUVdkdYXVlnwnaDP
         nm3hJszDuqeIVJCj8zRkVS3R8jXzerXRpAVByRrFjzGspgHV5XH8n1tG4+VQiQ63Q7LA
         1SxFORLDRy8mwxToiFy+V9Km39x/ppjEhxejXOdJnrE0FFGF+2fRKIc5QEtt5zLqURjR
         sUEd15OzN44s00MkTLAKLA5NbiQpuPd3iMQU/VuWOcioojbfJR8FG5jwAnoqXytBqlva
         dvgu/4OxSNvI0Xmy3GoewxptN48lohDC2QHQV5MLJ6TSHfWrb+b0NYlABY4cTrYg5Gok
         yOpw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=zdFOzBXW+wzC7Um2GESDmBHRPOngWeFX9MsFbFutrDc=;
        b=yxiv34NeCc0OIM+ZhfGVbV+3OKOPRYNhcVY1eQyjCCQvGx/wJWWLnQcPPvkbJ9bYHr
         8QMyEe9kdxMVc6H0Kv1R7N2T7uW88p8aZ9pLpAooQ4YfRNMHya9O+HMipFYMLuFbhh25
         KXc382CGjqpxivBuJh/mYChfcxyKbRDP6Z0V/cVrp2rNDPKI5f+Aq674m+WOY+sY7kus
         1p/dZOKc6Xe9PimyM1+CM8U1z3Ld8umWqkYKPvPSDYiyuDyiG3GYR4ezU1vyANpvQDHK
         o4SmZCW6J1Cm5vcKnB7nJaptvt+gwstZVk5xcvBkrLZNG76pEAU3JG+2f2ZxOZujypon
         Tpxg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x226jl0/zU4/yPBsUue1SMXiW1zB+hvTZq75zX08nWtZ5P4UzNiJWhY8L7/0Wea3niD1TrbwipA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519310733; cv=none;
        d=google.com; s=arc-20160816;
        b=cb9OMQ1x4b5gEM05/hcY/lQ0d2LWvOplBFLsHp3pfxaMmXO/xJV+/xJhPTLCoyt8AO
         6Ym9HIfu4dYNNDFrik8e9HAt4ZCI6G0zeEVZoA1XWp+vbMX67McXcHHUHEnZuEy6FJD/
         vklHuLY71g3UynvQ14K+IH+vzqF4y0Z9HXq7ghoNPGAI7qpXtwPQ6j8+3MmChpOPg0m1
         YBIqbxFpEIcW3liVCujF0Iks+Q509X5bQeBiguz6rXKgz+e6JD+Fg2cqcfaEBe7JIO3d
         KswSNkkALFohunZQtLuJrIXqXlcDNj5YUj6NZ9W1+gL1QcjqyiPNDZ4/nJxBmeWRjz67
         BJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=shK39Y+F9I0j67zUagZ839PlkE6NbHRKOBX8h1B4ZCw=;
        b=A/y08anwxsUC2WoyImEr4pT94tW0mDaeNbuwfCbNZcarvrbxuwDdxXIOyhr2Pn81x/
         n9rgPGuzmdlN/s5b6Ue0xOjEt5XxOwHMt0DQwEtxyhMRb95JGy2yeOuL3VEPSsf9NLKe
         qE6igVviASV8H4XjX3znqIFUTxV5UeBIoWz1odNB6/gbzpQmc/TI1GApbEXQ2VuEvgj9
         dLSm0abCXz2YUHzD8aEdGW15h7/zEnju74Y9xUV+qBG4nvo62XCOG1OJlUKQnYCYCTCL
         lHjsZJVy7xVm69Z0xMV8jZMAut1nKtte7buuJz2wTHL8uiNAyLS2WiMYDDmnFHd/noys
         qZRw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Thu, 22 Feb 2018 15:45:09 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v3] mtd: nand: Replace printk()
 with appropriate pr_*() macro
Message-ID: <20180222154509.4837eb38@bbrezillon>
In-Reply-To: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: boris.brezillon@bootlin.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as
 permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593106783204445682?=
X-GMAIL-MSGID: =?utf-8?q?1593112772821742483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Shreeya,

On Thu, 22 Feb 2018 18:40:14 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:


> diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
> index c3aa53c..8643512 100644
> --- a/drivers/mtd/nand/diskonchip.c
> +++ b/drivers/mtd/nand/diskonchip.c

[...]

> @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct mtd_info *mtd)
>  			break;
>  	}
>  	doc->chips_per_floor = i;
> -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> +	pr_debug("Detected %d chips per floor.\n", i);

Just want to add some more context on pr_debug(), nothing that requires
changes on your side, but as Richard said, it's important to explain it.

pr_debug() and printk(KERN_DEBUG) are not exactly the same. pr_debug()
calls are NOPs by default unless you have enabled the
CONFIG_DYNAMIC_DEBUG option or defined DEBUG (either directly in the
sources or by passing -DDEBUG to gcc). This is not the case with
printk(KERN_DEBUG).

If you want to know more about dynamic debug, you can read [1].

> diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
> index fc9287a..cd3cd1c 100644
> --- a/drivers/mtd/nand/r852.c
> +++ b/drivers/mtd/nand/r852.c
> @@ -7,6 +7,9 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#define DRV_NAME "r852"
> +#define pr_fmt(fmt)  DRV_NAME fmt

It would be nicer with:

#define pr_fmt(fmt)  DRV_NAME ": " fmt

...

> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/jiffies.h>
> @@ -935,7 +938,7 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
>  		&dev->card_detect_work, 0);
>  
>  
> -	printk(KERN_NOTICE DRV_NAME ": driver loaded successfully\n");
> +	pr_notice(": driver loaded successfully\n");

and then

	pr_notice("driver loaded successfully\n");

>  	return 0;
>  
>  error10:
> diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
> index 8713c57..709eced 100644
> --- a/drivers/mtd/nand/r852.h
> +++ b/drivers/mtd/nand/r852.h
> @@ -145,16 +145,16 @@ struct r852_device {
>  };
>  
>  #define DRV_NAME "r852"

You don't need this definition anymore, it's been moved to the .c file.
Actually, if you keep it you'll hit a 'redefine' error.

> -
> +#define pr_fmt(fmt)  DRV_NAME fmt

Why do you redefine it here? The only file including r852.h is r852.c,
and pr_fmt() has been defined before all include directives, so when the
preprocessor reaches this point pr_fmt() already has a valid definition.

>  
>  #define dbg(format, ...) \
>  	if (debug) \
> -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
> +		pr_debug(": " format "\n", ## __VA_ARGS__)
>  
>  #define dbg_verbose(format, ...) \
>  	if (debug > 1) \
> -		printk(KERN_DEBUG DRV_NAME ": " format "\n", ## __VA_ARGS__)
> +		pr_debug(": " format "\n", ## __VA_ARGS__)

With the pr_fmt() definition modified as suggested it should be:

		pr_debug(format "\n", ## __VA_ARGS__)

Regards,

Boris

[1]https://01.org/linuxgraphics/gfx-docs/drm/admin-guide/dynamic-debug-howto.html

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180222154509.4837eb38%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
