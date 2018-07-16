Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75484ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A49E208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A49E208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeGPIZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:25:51 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33208 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeGPIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:25:51 -0400
Received: by mail-ua0-f196.google.com with SMTP id i4-v6so17371448uak.0;
        Mon, 16 Jul 2018 00:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5R46MDSXnHRTuE+idWrKKhBsHF639hVBpEm0t1bWtZM=;
        b=UCPiBn0jWRlKkfPDPRI+UFNIOMbeSrVtJ7x3lgzAQI5RlKLiP/IO7eL18J6OX6LX6L
         NtYDq+dp18l9e0gqADpGFLL7sQyCwWMGpCIBCn5XWTmpGI0Wb/HmuYDP9I49aGneqG7t
         2T1o9TF0Aa4X9Kh+wVAPO9FNukOwFDxtYvE88QvyL7Y+o9onMgsT34wXT9bQXu58NRsR
         8ZvZGRLk8tW8ur+2rG9zt4+j8IrZ3SQ88knueG3ZYXBR45BCxizHCZovzXc9b1NCuQb9
         Un4JdfMbLUZyCvxROLYG9mgRkkyeQuIRBqmCIk2w4pyciEh7D97PGRjCvSk++oPANBdm
         jijA==
X-Gm-Message-State: AOUpUlFmE5OfL25iVG3eslIrT485g+oXCgFT3QZBq+DAoQK0hhT2/1pU
        Svw4IN/AYJXCOSf3rSx8XklEDEyL/+Ln8BCgNlk=
X-Google-Smtp-Source: AAOMgpcjyElxKoh19nBuro7agac7CWmZZNLxk+4rXFDmz+1r2dB7ezgM7NnwUrf8FYEWiWrOqIN+Fxg/6EOXis8GLSM=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr11143644uap.33.1531727983016;
 Mon, 16 Jul 2018 00:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180716081018.21bfe495@canb.auug.org.au> <CACRpkdZ5BA1wn=TPn4yWkwWd3pAKh9wuMHd9woBF=+6+L1jtFA@mail.gmail.com>
In-Reply-To: <CACRpkdZ5BA1wn=TPn4yWkwWd3pAKh9wuMHd9woBF=+6+L1jtFA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jul 2018 09:59:31 +0200
Message-ID: <CAMuHMdVRfEcxo0SVW7VkmE-1bjsESKeL9nRk41W32_2V6rpA-A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the pinctrl tree
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jul 16, 2018 at 9:52 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 16, 2018 at 12:10 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Commits
> >
> >   bc319333c156 ("pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and functions")
> >   99500c6a4836 ("pinctrl: sh-pfc: r8a77990: Revise USB ID pin name")
> >   3d3c62d3458a ("pinctrl: sh-pfc: r8a77990: Add USB2.0 pins, groups and functions")
> >   1e0f13198edf ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and functions")
> >
> > are missing a Signed-off-by from their committer.
>
> I am looking at this and I just feel confused. Top to bottom:

> commit bc319333c156a710891942d34560b9fca0f52f5d
> Author: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Date:   Thu Dec 14 13:04:55 2017 +0900
>
>     pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and functions
>
>     This patch adds HSCIF{0,1,2,3,4} pins, groups and functions to
>     the R8A77965 SoC.
>
>     Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>     Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This is very confusing, it looks correct to me.
>
> As usual it must be some minor syntactic thing like a character missing or
> something, I am just soo.... what's wrong here, really?

The previous issue was a missing commit from the _author_, not committer.
As you rebased the branch, _you_ are now the committer, not me anymore.
So now your SoBs must be present, too.

As I already told you I had fixed up the author SoB, and updated the tag,
just drop the above commits, pull sh-pfc-for-v4.19-tag1 again, and be done
with it ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
