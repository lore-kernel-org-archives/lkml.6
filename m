Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DC5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8892150D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y2jeFhJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8892150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeIZVsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:48:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52818 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeIZVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+yiA2HBZL+QfNZk+RyqqeXc+ZJXUYi/CBUzI43dyWyg=; b=y2jeFhJKUzkKxX9nC1gzSNpzor
        m7cmw4GdAYVdTB8ShoI64NIIoOAuPlBKFUgY3a4GAXIDOuSieayBYc/ssQQE/S9PLL/tjEg4c1n9a
        ai3MhfVjPvDz6NYfxGx3mH+rnZ1NbX6nghNsRqxSb8DQkMl1mAbCSxcl48bnj1z0Oah3GCC013IGe
        XwkiXo7ymRGvbRxaArZ4UYAfO1ve+NC3Y3ltwJsKGWlAQcSfZI1j8NdMP+NImGzur7+tr9FVDmtAt
        QKnUBRsfzPRvFLtGgXORyKofgGPlFwwmnszDiQ95JlrHHjvNcYf3gNKcYQNdQzKW5daj5lCArFWcJ
        R+E1Ewbg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5BpR-0000vS-Ks; Wed, 26 Sep 2018 15:34:37 +0000
Subject: Re: [PATCH] of: base: Fix english spelling in
 of_alias_get_alias_list()
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gregkh@linuxfoundation.org, geert@linux-m68k.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <b64be28f7705a91fcb84b9c59ca830e057c71d96.1537959997.git.michal.simek@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfd94b86-0a71-a2c4-449d-7f06ff3ae30e@infradead.org>
Date:   Wed, 26 Sep 2018 08:34:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b64be28f7705a91fcb84b9c59ca830e057c71d96.1537959997.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/18 4:06 AM, Michal Simek wrote:
> Fix english spelling in of_alias_get_alias_list().
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Greg: Please apply it on the top of tty-next because patch is going via
> your tree.

Maybe a few more fixes first...

> ---
>  drivers/of/base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 33011b88ed3f..ffcbb2963ba2 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1948,7 +1948,7 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>   * @matches:	Array of OF device match structures to search in
>   * @stem:	Alias stem of the given device_node
>   * @bitmap:	Bitmap field pointer
> - * @nbits:	Maximum number of alias ID which can be recorded it bitmap
> + * @nbits:	Maximum number of alias IDs which can be recorded it bitmap

s/it/in/

>   *
>   * The function travels the lookup table to record alias ids for the given
>   * device match structures and alias stem.
> @@ -1971,7 +1971,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
>  			 __func__, app->stem, app->id);
>  
>  		if (strcmp(app->stem, stem) != 0) {
> -			pr_debug("%s: stem comparison doesn't passed %s\n",
> +			pr_debug("%s: stem comparison didn't pass %s\n",
>  				 __func__, app->stem);
>  			continue;
>  		}
> @@ -1986,7 +1986,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
>  			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
>  			set_bit(app->id, bitmap);
>  		}
> -		/* Alias exist but it not compatible with matches */
> +		/* Alias exists but it not compatible with matches */

s/it/is/

>  	}
>  	mutex_unlock(&of_mutex);
>  
> 

thanks,
-- 
~Randy
