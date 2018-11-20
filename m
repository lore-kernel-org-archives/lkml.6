Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34372C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C8E20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B5fC8R/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C8E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbeKUDUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:20:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34920 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKUDUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:20:01 -0500
Received: from zn.tnic (p200300EC2BD1FF00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:ff00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A9971EC023A;
        Tue, 20 Nov 2018 17:49:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542732595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/vt8Hp0VJRnuaHkimQpG4absC2XHbAnYp0TasjtCME8=;
        b=B5fC8R/dCgnKkx+MzbGEo8Ak0tgRvDe8Ka6lj6Z6JCCszrJ6ZP31VgdETDaGHgzhyMqcth
        LTOZ9iOICj3OCpafMvKodqOqzSG7+vCewNNEVn0eP9ygXCIgThQOl/nBUPXqTr5zEklt0f
        FuwVXh3cTcwonEoKRzAQfa6mGQtcbu8=
Date:   Tue, 20 Nov 2018 17:49:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Arvind R ." <arvino55@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: edac: drop bouncing email
Message-ID: <20181120164954.GI2527@zn.tnic>
References: <20181120161032.3417-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120161032.3417-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 05:10:32PM +0100, Alexandre Belloni wrote:
> jetztechnologies.com doesn't exist anymore and emails to Ranganathan are
> bouncing.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b25905..424ae080b38a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5292,7 +5292,6 @@ S:	Maintained
>  F:	drivers/edac/i82443bxgx_edac.c
>  
>  EDAC-I82975X
> -M:	Ranganathan Desikan <ravi@jetztechnologies.com>
>  M:	"Arvind R." <arvino55@gmail.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
> -- 

Both applied,
thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
