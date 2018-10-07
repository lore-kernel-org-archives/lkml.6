Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55429C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47442084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47442084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeJHC7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:59:36 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34621 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJHC7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:59:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id v12-v6so10281677vsc.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 12:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ws65oVmQ0nLwLcHDh8E3EGh6WixIQm2WOSvbSWj2JNI=;
        b=iRj1VkYcOku0Q+Qb+He4REE4xidzZAa+/U0wX3IhFFt8UwlhW8g84Rao9EEZGN1Ese
         ZGRsr6mz/Z4wK3SGoB+p0x9LYrHqpTjnKXtCJNXcsZ4F6/vfwdjlll/+tnD2Mth80les
         WRlT6FxK1TXI8nheo5nlDftTYX9FR7VYEkWX+vbAy4Eq7srDf/1wVSQ8dAWEJrwuKMD4
         iA20lv3WWncR2X2FRcaqDZyZhIYYUmEAyAP0biK7JZMZCuLf70Xninm321dZhGf8IbNw
         J2g/Iw1Pt8dHEOqzyGJdkrw948xXhBZpShJCFyAPvpIM1hq96qBIgAQNhzgEEaBjqG+Q
         Heuw==
X-Gm-Message-State: ABuFfogbM99dZhx2C5e9h/zphgAonO3Z6DcLI6fQt0oO/xIGV9AeoxoF
        NoKqXWDQTyda3kqhHw8ZokVhG9mQm7lbPxCrZ5TQZQoC
X-Google-Smtp-Source: ACcGV62azAAHhPrM0/AJD/7z+AwPttnNAF6ZVWHap3Xj64QjijULBTGt0jkyt0DsCSk7DLXD610oXTHR/QyJs6Hbiec=
X-Received: by 2002:a67:7b56:: with SMTP id w83mr6357541vsc.152.1538941874283;
 Sun, 07 Oct 2018 12:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com> <1538861851.4088.7.camel@HansenPartnership.com>
In-Reply-To: <1538861851.4088.7.camel@HansenPartnership.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 7 Oct 2018 21:51:02 +0200
Message-ID: <CAMuHMdXVbda8cn8Yt=wA9ABQ9M=S-QM51NVMb6N_J3yBz3sTgQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 11:37 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Significant concern has been expressed about the responsibilities outlined in
> the enforcement clause of the new code of conduct.  Since there is concern
> that this becomes binding on the release of the 4.19 kernel, strip the
> enforcement clauses to give the community time to consider and debate how this
> should be handled.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
