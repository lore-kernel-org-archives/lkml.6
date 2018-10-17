Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA1ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E514F2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E514F2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJQXRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:17:22 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:39671 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:17:22 -0400
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 573AB240007;
        Wed, 17 Oct 2018 15:21:06 +0000 (UTC)
Date:   Wed, 17 Oct 2018 08:21:02 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        tomi.valkeinen@iki.fi
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181017152101.GA17531@localhost>
References: <20181017071902.30102-1-geert@linux-m68k.org>
 <20181017091325.GA15991@localhost>
 <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:31:35AM +0200, Geert Uytterhoeven wrote:
> Hi Josh,
> 
> Thanks for your comments!
> 
> On Wed, Oct 17, 2018 at 11:13 AM Josh Triplett <josh@joshtriplett.org> wrote:
> > On Wed, Oct 17, 2018 at 09:19:01AM +0200, Geert Uytterhoeven wrote:
> > > Providing an explicit list of discrimination factors may give the false
> > > impression that discrimination based on other unlisted factors would be
> > > allowed.
> >
> > This impression is, in fact, false, as has already been discussed
> > elsewhere. I had hoped that discussion would suffice.
> 
> The CoC FAQ is not part of the CoC, and not part of the Linux kernel.

I wasn't referring just to that; I'm referring to the discussion we've
already had on this exact point.

> > refers to. Listing explicit cases to cover does not imply other cases
> > are not covered;
> 
> It does, if not accompanied by "examples of...", like in the other sections.

"for everyone, regardless of ..." still says "for everyone", making the
"regardless of ..." inherently a non-exhaustive list of factors.

> > it does, however, ensure that the listed cases *are*,
> > and helps people know that they're covered.
> 
> So you agree people cannot know if the unlisted cases are covered or not?

People in underrepresented and commonly marginalized groups, especially
those more commonly overlooked, don't always know if a given group has
taken their particular group into account or given any thought to it.
Explicit inclusion helps, and this is a standard guideline often cited
for good codes of conduct.

That doesn't make other groups *not* covered. But *if* there is a
particular commonly marginalized group that you feel this should
*explicitly* cover and doesn't, I'd suggest *adding* that group rather
than deleting the existing effort to be explicitly inclusive. (And
again, I'd suggest doing so upstream first.)

> > This patch is not OK, and defeats one of the purposes of the original
> > change.
> 
> So the purpose of the original change was to list a number of factors,
> without saying that it was just a list of examples?

You seem to be actively trying to read something more into what I said.
One of the key purposes of the original change was to make the kernel a
"a welcoming environment to participate in", and to provide "explicit
guidelines".
