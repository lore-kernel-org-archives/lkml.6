Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E47C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68D320881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68D320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeGJHHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:07:34 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:42705 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeGJHHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:07:32 -0400
Received: by mail-ua0-f171.google.com with SMTP id x18-v6so13322638uaj.9;
        Tue, 10 Jul 2018 00:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbZjGox+MS0GsoY3n7bZ4oadRDxfG4kytFZzSnDYJA8=;
        b=iz82ZnJuUF5EW8+ICKohaEf9OQSXCyl6wOjMDa5nWZXxaeXQKJ8/8ByYegFtDuKiI4
         f2ZvYgoN+BNRCKPoikjfgoPQFE1h0XLS+WacWbU32yM6LyQPNSHZMKLKEnr3+nNdrzlH
         +ajAqz2I+kv4Vzzb0hJF1YjnDn3lTgE5SYlLqfuFM7HSTk5i5ta2104u/9lRrP1IuMhj
         MJ1DM8PsCx01pq0mVnk3n3wx/F9RsVmXDCMXaY1Fd+eQzAOCCQ2H2Y8uyZaX9FXCxdSl
         wU1nvI9bRpRedQXEiLbse2TDmmgSUom9R0QXaCbJuZnHNQh1reUDqOCJIxp2qnV7W3Ha
         w91Q==
X-Gm-Message-State: APt69E3RPK0fdV75HwANKt1uhVfEGHY/XVndHwgSyQhMLmRfbDUP8o3X
        mWa5Y9u0kG+/SXDuU6kHk6Ki5vRBVEtvzxOMaxWmNA==
X-Google-Smtp-Source: AAOMgpdaoEIzilnFfFpoe9iUQAla4q2Q74mQqjR4AqKQE0qXFeypHujswbO4QUATipJezMBmb2F4cE9R88TE8pTAcp8=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr14766037uae.72.1531206451785;
 Tue, 10 Jul 2018 00:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180710075439.4a449b3d@canb.auug.org.au> <CACRpkdZrsGzULrNaoaX6bSy6z6o-gshQXrRhzUk=tuFF86shDw@mail.gmail.com>
 <OSBPR01MB22933EFD31CAC8A88CE08EDAD85B0@OSBPR01MB2293.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB22933EFD31CAC8A88CE08EDAD85B0@OSBPR01MB2293.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Jul 2018 09:07:20 +0200
Message-ID: <CAMuHMdUr1kX=EX32tY0nGZYeriFG+NkmmEQ=ANeb29nN-gBB0Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shimoda-san, Linus,

On Tue, Jul 10, 2018 at 3:18 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > -----Original Message-----
> > From: Linus Walleij, Sent: Tuesday, July 10, 2018 7:46 AM
> >
> > Hm must have come from Geert's pull request?
> >
> > (I'm regularly wrong about this so not so certain...)
> >
> > Geert can I fix it the usual way by simply rebasing and
> > adding the right SoB?
>
> I'm very sorry for this trouble.
> When I ported this patch, I dropped the author's Signed-of-by wrongly..
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Thank you!

Since this was the top commit from my last pull request, I've just ammended it,
retagged, and pushed.

Sorry for the trouble.

/me looks into improving checkpatch.pl...

> > On Mon, Jul 9, 2018 at 11:54 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Commit
> > >
> > >   a742fcf72902 ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and functions")
> > >
> > > is missing a Signed-off-by from its author.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
