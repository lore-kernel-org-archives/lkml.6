Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D72EECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF659214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF659214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJQR0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:26:39 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40308 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeJQR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:26:38 -0400
Received: by mail-vk1-f196.google.com with SMTP id h20-v6so6167756vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fcJPgcBwQVi0wklpnJ+WPkjnwtz0m1qKyvroUqyo0E=;
        b=Nfbgdj2RbViMtCS3hZlir9H9rK1BRpbtCgvl73qUllulZbBW2nvfhIxXd08yDOMkyG
         7A9vLgaZy7PQWBKyogEQP/Z+YHf1ZknWmd+sGhSpXo1nDDx5pYILvbDuiM6I1rdxXiG8
         qPDCL0QuCoG52fVOCTjDRQE9Bm/W93PaVLrGHfq026QVKit4HXk0oCETbPF6pE0GQZC5
         dq6yyP8rAtGyOwQZqgOnla/2ARZ++wUXYaIp1IwqstKGQlepEy3DLP1hH6AGTdx2/lq+
         mfyET6gvPeSVibHZOSZBXjhUFOJDAnZh1HInWGofOXdtuG0+C+I54kSfTE4FWn4iQs1x
         IMRA==
X-Gm-Message-State: ABuFfogXI6M7WpZQ1QdSjVrqAeBf6zWia8XJ0d7RRO/SumXJDJExqU+m
        OcHcOW89hdX8K1Z+kdLoqUfa+ZH4KwbTwFwEKn4=
X-Google-Smtp-Source: ACcGV62rSEcHOO+OrYk8WRCWQmm9kKbx6BhuMVPZP7fQlS66lMuKWmDNd0y8xKXDyfJ/Yrb4KOK2K6KaFJQq3cVRb1k=
X-Received: by 2002:a1f:3613:: with SMTP id d19mr2235207vka.65.1539768708257;
 Wed, 17 Oct 2018 02:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181017071902.30102-1-geert@linux-m68k.org> <20181017091325.GA15991@localhost>
In-Reply-To: <20181017091325.GA15991@localhost>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Oct 2018 11:31:35 +0200
Message-ID: <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        tomi.valkeinen@iki.fi
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thanks for your comments!

On Wed, Oct 17, 2018 at 11:13 AM Josh Triplett <josh@joshtriplett.org> wrote:
> On Wed, Oct 17, 2018 at 09:19:01AM +0200, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.
>
> This impression is, in fact, false, as has already been discussed
> elsewhere. I had hoped that discussion would suffice.

The CoC FAQ is not part of the CoC, and not part of the Linux kernel.
If the CoC is imprecise, it should be fixed in the CoC, not in a separate
document hosted elsewhere, as discussed elsewhere.

Comparison with the GPL and the GPL FAQ is not appropriate, as the GPL
is still the precise legal document, while its FAQ is a clarification using
laymen's terms.

> As mentioned there: The original commit explicitly said "Explicit
> guidelines have demonstrated success in other projects and other areas
> of the kernel."; this is precisely the kind of explicit guideline it

Given the original commit was not submitted for and objected to public
review, nobody had the chance to question these statements, and ask for
pointers of proof, which would surely have happened.

> refers to. Listing explicit cases to cover does not imply other cases
> are not covered;

It does, if not accompanied by "examples of...", like in the other sections.

> it does, however, ensure that the listed cases *are*,
> and helps people know that they're covered.

So you agree people cannot know if the unlisted cases are covered or not?

> This patch is not OK, and defeats one of the purposes of the original
> change.

So the purpose of the original change was to list a number of factors,
without saying that it was just a list of examples?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
