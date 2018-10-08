Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF8D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF8D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJHQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:06:42 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38133 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJHQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:06:42 -0400
Received: by mail-vs1-f67.google.com with SMTP id a202so7761731vsd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uugBN4Fd6aW3rBr8aO+q5wA6v9dAtEr9PkHoeZ0bAM=;
        b=b+8XymAPi4ZnFJza+Oqbl0r3VxRejuP6dgsfs1JZK+rbsFs/OCEvRTwLbuovx+3AjA
         +jTKBv5AJ+Cuo9pxAEdrqM3G0h4hLeYlorD3ri5/JQuU29SODCRQiejmU0aNb9RJBeLm
         ZXuqx6iDVUp9np4PHrAj5lBn80KDjmwZp5HW82NxzETd+tUCMqvFK/Flgxgg+wihyN31
         +1uq0FzULW/m5rku+Aq5jmHx/WnyUqxI3NaKuT1rydT42ctI0FCiXaGcgJEJbIkGZJbO
         l8TIS1XP7sWU4+VYmvT93xx50v1tbCuewLxV3G7HYlGwbEgTI8W169Q7iZn2E0iZ+NPK
         rk0Q==
X-Gm-Message-State: ABuFfojWFG96vx87v2AdR3covtj1nPgCBWr0PbEwgmwbG8cZLxPWnBJM
        hWtsbLuJwx/43V4nqmC2LbTfzL5cBqWNWiksn7JBg/nj
X-Google-Smtp-Source: ACcGV60/tAPjsUBeIQTOcC7jwCc3V6Kw5aB2+zcAWr1G+z/ahfzrDHJbOdf2jik0yI/kh90bMist54vdMw69hqhxO7o=
X-Received: by 2002:a67:7b56:: with SMTP id w83mr7037321vsc.152.1538988962464;
 Mon, 08 Oct 2018 01:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181007085102.17795-1-geert@linux-m68k.org> <20181007113514.GA21217@localhost>
In-Reply-To: <20181007113514.GA21217@localhost>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 10:55:50 +0200
Message-ID: <CAMuHMdVS6QVfg6=-a9+qgnhjT4f1aEMdEm54jKFy7MnSxCj_1g@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Sun, Oct 7, 2018 at 1:35 PM Josh Triplett <josh@joshtriplett.org> wrote:
> On Sun, Oct 07, 2018 at 10:51:02AM +0200, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.
> >
> > Avoid any ambiguity by removing the list, to ensure "a harassment-free
> > experience for everyone", period.
>
> I would suggest reading the commit message that added this in the first
> place. "Explicit guidelines have demonstrated success in other projects
> and other areas of the kernel." See also various comparisons of codes of

The first paragraph of the commit message (the "why" part) is exactly the
part we've been waiting for a clarification since the inception of the
commit...

> conduct, which make the same point. The point of this list is precisely
> to serve as one such explicit guideline; removing it would rather defeat
> the purpose.

Then (at least) the list should be marked containing examples, cfr. the other
examples in the document.

> In any case, this is not the appropriate place for such patches, any
> more than it's the place for patches to the GPL.

There are precedents:

Until recent, the file named "COPYING" (which you referred to in another
email related to patching the CoC), was a verbatim copy of the GPL, with
clarifications added at the top.

Documentation/process/code-of-conduct.rst is already a slightly modified
version of the original.

Now, if amending the CoC locally is not an option, I'm afraid a plain revert
is the only option, like for any other commit that breaks the userspace ABI
(Linux kernel developers are also users ;-), until the raised issues have
been resolved upstream.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
