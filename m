Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93236C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6359C2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6359C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJHVnL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:43:11 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37735 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJHVnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:43:11 -0400
Received: by mail-vk1-f194.google.com with SMTP id y128-v6so4623898vky.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5UKqo2E1ytB2MKygayLLZEu1Qmvfo3tXDFcNH+w/h3k=;
        b=aVgznEeWzdaBKheWLiisxh32o27XHUSzYMz6vQ4+96XNaWkyRUt8dlZ9AyJtIhltr7
         R4ZzNuBWkhXMKkLLSk12ADfYqnrI14k8f005oEBA6GDqWmgPAvysMDoe3wtGhHoOdVNH
         HGqxQDxVesbpPChvk71aNPckGLERkevGx+Lg2hCZkhV0ckHrnd69os3v9Vn5fX5u73Sp
         fUzRH6bjswjeMnl0n4hpyIOiVBLGqmfzPikCtmTwCBh+6S8isx/5PPEEhmxa/MR8BJhj
         ZHpqI8Bn5mL/5szCCHzQp4yQEG8sCthFUOrWsQDU1/b7qVqfv3Ggwqu6XB0CEL4tBTmE
         eVNQ==
X-Gm-Message-State: ABuFfog3xj5N9xAq3Uj4b+hGv+AJgbTOa7EzrP1B2Z8b9wCYPzh9wG0p
        MkYmJvsjW0XmDT04BNarS/L6tJKt0XyCgE/II5I=
X-Google-Smtp-Source: ACcGV60YM0Yn+hbUa5fQ2r1HXG9VvSV8VjvzzPZVapUPT5Lmq+nYHVJcxyLWNLf90kpAdSFskjzBZGAkJETFj7Pj0kU=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr8924882vkg.40.1539009070033;
 Mon, 08 Oct 2018 07:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181007085102.17795-1-geert@linux-m68k.org> <20181007113514.GA21217@localhost>
 <1814283.64diKEr4zR@avalon> <20181008022931.GB30346@localhost> <ECADFF3FD767C149AD96A924E7EA6EAF80517449@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF80517449@USCULXMSG01.am.sony.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 16:30:57 +0200
Message-ID: <CAMuHMdVmz-ZF+ypp4WEkW6txxjw66DTb5PRsSGPsUfBqT+NbMQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Mon, Oct 8, 2018 at 4:12 PM <Tim.Bird@sony.com> wrote:
> > From: Josh Triplett
> > On Sun, Oct 07, 2018 at 08:18:26PM +0300, Laurent Pinchart wrote:
> > > On Sunday, 7 October 2018 14:35:14 EEST Josh Triplett wrote:
> > > > On Sun, Oct 07, 2018 at 10:51:02AM +0200, Geert Uytterhoeven wrote:
> > > > > Providing an explicit list of discrimination factors may give the false
> > > > > impression that discrimination based on other unlisted factors would be
> > > > > allowed.
> > > > >
> > > > > Avoid any ambiguity by removing the list, to ensure "a harassment-free
> > > > > experience for everyone", period.
> > > >
> > > > I would suggest reading the commit message that added this in the first
> > > > place. "Explicit guidelines have demonstrated success in other projects
> > > > and other areas of the kernel." See also various comparisons of codes of
> > > > conduct, which make the same point. The point of this list is precisely
> > > > to serve as one such explicit guideline; removing it would rather defeat
> > > > the purpose.
> > > >
> > > > In any case, this is not the appropriate place for such patches, any
> > > > more than it's the place for patches to the GPL.
> > >
> > > So what's an appropriate place to discuss the changes that we would like,
> > > *together*, to make to the current document and propose upstream ?
> >
> > I didn't say "not the appropriate place to discuss" (ksummit-discuss is
> > not ideal but we don't currently have somewhere better), I said "not the
> > appropriate place for such patches".
> >
> > The Linux kernel is by no means the only project using the Contributor
> > Covenant. In general, we don't encourage people working on significant
> > changes to the Linux kernel to work in private for an extended period
> > and only pop up when "done"; rather, we encourage people to start
> > conversations early and include others in the design. Along the same
> > lines, I'd suggest that patches or ideas for patches belong upstream.
> > For instance, the idea of clarifying that email addresses already used
> > on a public mailing list don't count as "private information" seems like
> > a perfectly reasonable suggestion, and one that other projects would
> > benefit from as well.
>
> So I raised this issue with upstream about 2 weeks ago, and here is my
> experience:
> 1) I suggested that the email clarification could be put into the covenant
> itself, or in a supporting FAQ.
> 2) The project maintainer (Coraline Ada Ehmke) was pleasant and supportive
> of changes to enhance the document, and said either approach would be fine.
> 3) I noticed that there was a FAQ in progress of being created.
> 4) After thinking about it, I decided that I didn't want to alter the language
> of the covenant, because I didn't want to dilute the expression of a need to
> get permission when revealing private information.
>
> My own opinion is that putting clarifying language in a FAQ is sufficient.
> So I made the following recommendation for the (not yet included upstream)
> FAQ:
>
> Q: Does the prohibition on publishing private information include email addresses sent to a public list?
> A: No. Information that has voluntarily been published to a public location does not fall under the category of private information. Such public information may be used within the context of the project according to project norms (such as in commit meta-data in code repositories), without that constituting a breach of the CoC.

I noticed this morning this is actually already included in the FAQ
(I didn't know this is recent thing):
https://www.contributor-covenant.org/faq

> I don't know what progress is being made adopting the FAQ, but Coraline seems very
> supportive, and I've told here that I will come back and help with it if it stalls.

I'm glad to heart that!

FTR, I've submitted my patch earlier today, too:
https://github.com/ContributorCovenant/contributor_covenant/issues/610

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
