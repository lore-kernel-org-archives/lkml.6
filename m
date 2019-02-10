Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F3C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F908213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jaFkCHii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBJSVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:21:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35556 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfBJSVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zXJhTUiV3xsCxu/vqq/nZaO1b3AdsPufQ3ii3tmvIz8=; b=jaFkCHiiw4ws2NHUblROQ1AqMy
        rIWom55hMdiTz/c/7jGGm04yg+HY7BcrkFzDB3d+2WE3ZOuOVBuqRCcFLJfrqPO/xoFQqBfQZwV2x
        IDw//ZbAsS3Q3pMPTW0+Im9ivIODabIjqvrTJYDsz4fkRti3JIaA8tm3JDcUF2o6J+tIJc0BbJFTE
        noVYgbLoF9aZrKVTGAVsmurd5feAjxYCIbbNsoveaOKq8MrslA9keGgE3mlGC/R2GFYA4S7xkrIVq
        e0KNfFBXoQFz4PnNtSSkvUo7h0PM4s3otAMxRwx6QxxLDCOqqTAxwk6bcvOlhoi89ddJse1jL3/xv
        WCk65MHA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gstjf-0005sq-JA; Sun, 10 Feb 2019 18:21:47 +0000
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f34543f5-d0fc-b998-9ce1-c8f3fd36db73@infradead.org>
Date:   Sun, 10 Feb 2019 10:21:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/19 10:10 AM, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> further maintainer to the KEYS-TRUSTED section entry. So, we rectify this
> with this commit.
> 
> The issue was detected when writing a script that parses MAINTAINERS.
> 
> Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mimi, please pick up this patch. Thanks.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf4965d6d5de..31950caabcaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8405,7 +8405,7 @@ F:	security/keys/encrypted-keys/
>  
>  KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.ibm.com>
> -M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>  M:	Mimi Zohar <zohar@linuxibm.com>

Just checking:  is that email address correct (@linuxibm.com)?

Guess I'll see if it bounces.

>  L:	linux-integrity@vger.kernel.org
>  L:	keyrings@vger.kernel.org
> 


-- 
~Randy
