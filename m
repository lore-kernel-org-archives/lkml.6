Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED2AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FF420881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0XMXMd/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FF420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeJOXia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:38:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39136 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeJOXia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J3grTd8CYm6iW8j6njDGyBOvxniCX6xJckiInushUAk=; b=0XMXMd/ckM8u1rRGkI5TLZoV5t
        i+hN7x+MwAVTxcvdQlFMQvVVIG8fjw39dO1w6SMySOghRMLXX0NNUkntzr+tIZujMtkTR+ERZvTQw
        i8YE6QcF87lxnTPtpCAu5uIzz2MHvMZ3oiEzpBV2Fl7B12xTJOKzbmknKQFUev72U6K3qSpiQMJ2w
        m2/Q5JnJP7Cg27EOqUZdnsK902D1sLdia//F3/xvx2WrCTBLSKUtVU+ywLgLyEk7ocQ6fQ89YnMRj
        5SoPSlym4dfzgvq5wfka9ZPXUtspbvrd4WHyjMt/jSKaiF3nDk3fSI64jwjWiW3onxcAb+DzVjY7k
        dlgUsvRA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gC5Ac-0000ZH-Aj; Mon, 15 Oct 2018 15:52:38 +0000
Subject: Re: [PATCH] docs/uio: fix a grammar nitpick
To:     Will Korteland <will@korte.land>, corbet@lwn.net,
        linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <f4edbcfab23ae1a53499dcdc1db32f1b@korte.land>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ba7b71e7-5652-1209-f169-cacc1067b89a@infradead.org>
Date:   Mon, 15 Oct 2018 08:52:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f4edbcfab23ae1a53499dcdc1db32f1b@korte.land>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 1:10 AM, Will Korteland wrote:
> This patch fixes a minor, incorrect piece of grammar in the UIO howto.
> 
> Signed-off-by: Will Korteland <will@korte.land>

Looks good to me.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> This is my first attempt at a kernel patch, so please let me know if
> I've done something silly.  I sent a copy of this a few days ago, but
> I can't find it on the public archives - apologies if I've now posted
> this twice.
> 
>  Documentation/driver-api/uio-howto.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
> index fb2eb73be4a3..25f50eace28b 100644
> --- a/Documentation/driver-api/uio-howto.rst
> +++ b/Documentation/driver-api/uio-howto.rst
> @@ -463,8 +463,8 @@ Getting information about your UIO device
> 
>  Information about all UIO devices is available in sysfs. The first thing
>  you should do in your driver is check ``name`` and ``version`` to make
> -sure your talking to the right device and that its kernel driver has the
> -version you expect.
> +sure you're talking to the right device and that its kernel driver has
> +the version you expect.
> 
>  You should also make sure that the memory mapping you need exists and
>  has the size you expect.


-- 
~Randy
