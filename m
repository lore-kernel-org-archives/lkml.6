Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADDDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456C621479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550607191;
	bh=GK/4w7IJIU5Es1KU8wFeOkVdZ7sPkQTpSlUKLOHtBCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ckx8aqm67eG1DzViZ/zcuyjO9tnvDVsCjh2ybW3oZbg3SCSPReYmrggmfcHvni7yL
	 boMUBYiNyNv0Cx4LWlrm1fzr/P0dwMBxSPQaBXCN/SvsRidUBmE8ANpBmOzZ4Bljpw
	 fGiOkh6xoaZ/FO3AeVntMfsW+9lQrw736D0gFth0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfBSUNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:13:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44823 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:13:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so17845451edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrLUnChJSNkERzDtX8T5G3FZ9otkoZOBM7pmL7p0jc4=;
        b=Yeyrmfst7WrCE7nLZAjX3E//IU0Vygvm/Bcbz7HTxuZcCvHW6g8lX0CPCcpmi3VyKv
         jkt2upwfR5uodNugiPZKbKNswmVKC1j5/sqsco9omj7MWHyu2vpci37ZvW0j9e7K2jMG
         qsEqA9CrjA/aFCXukH4oe1d3foT1tv23UTh1YSZT5tGr+GCHQb9i8l4uG4YfcawPnICG
         WdPj0J8fqHJzL/hvb0ue5W0r/UGlaQPPSSkoMwr0nx5KJxPHjD6g8vDcmD2TYm9mQsTp
         NtU598gpd/QchBxro4x3+e+fCGy0jSuhOeK9FAYV3ynb58R6IIh1jIBpTryIjxoBlQb9
         hbEA==
X-Gm-Message-State: AHQUAuZiHlvGlpHkxrUkgFoeeSAiTRIMADNlTNC/ZGp5R4U5RkQBq5KR
        py/ZKhUdyYxuoUXsIPKYXpDLR+ag0yeRTyoX264=
X-Google-Smtp-Source: AHgI3IYd6ByYpk/iDD90F28J0O8P82jI+dg3w1wyNWWi5IecCWdR2ui+JLbqag4TDdMaeaWzhQrvRNx0tDyRDYbcmgE=
X-Received: by 2002:a50:b721:: with SMTP id g30mr24159281ede.155.1550607187133;
 Tue, 19 Feb 2019 12:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20190119200719.5686-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190119200719.5686-1-lukas.bulwahn@gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 19 Feb 2019 15:12:56 -0500
Message-ID: <CAJvTdKnui1i4pswtNWPKG8RBHBiSgv3H9Xo4bW_Fdn1MtSwE3Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update simple firmware interface (SFI)
 section entry
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        Jiang Liu <jiang.liu@linux.intel.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Len Brown <len.brown@intel.com>

Indeed, Lukas, I believe that all of the systems that will ship with
SFI have shipped.
It is probably time to delete this code from the kernel.

-Len

On Sat, Jan 19, 2019 at 3:07 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Len Brown has not been active in this part since around 2010. The recent
> activity suggests that Thomas Gleixner and Jiang Lui were maintaining
> this part of the kernel sources. Jiang Lui has not been active in the
> kernel sources since beginning 2016. So, the maintainer's role seems to
> be now with Thomas.
>
> The referenced git tree does not exist. Instead, I found an sfi branch
> in Len's kernel git repository, but that has not been updated since 2014;
> so that is not worth to be mentioned in MAINTAINERS now anymore either.
>
> This change was motivated after I found that I could not send any mails
> to the sfi-devel mailing list, and that the mailing list does not exist
> anymore.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>
> Len, please ack this patch.
>
> Thomas, if you are maintaining SFI, please pick this.
>
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 887b4b9fb6c4..e2d370910a07 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13841,10 +13841,8 @@ F:     drivers/video/fbdev/sm712*
>  F:     Documentation/fb/sm712fb.txt
>
>  SIMPLE FIRMWARE INTERFACE (SFI)
> -M:     Len Brown <lenb@kernel.org>
> -L:     sfi-devel@simplefirmware.org
> +M:     Thomas Gleixner <tglx@linutronix.de>
>  W:     http://simplefirmware.org/
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
>  S:     Supported
>  F:     arch/x86/platform/sfi/
>  F:     drivers/sfi/
> --
> 2.17.1
>


-- 
Len Brown, Intel Open Source Technology Center
