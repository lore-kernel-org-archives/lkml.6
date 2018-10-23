Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606ABC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA94C20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="m4f4SUUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA94C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJWQeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:34:09 -0400
Received: from imap.thunk.org ([74.207.234.97]:47794 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbeJWQeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:
        Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=podc23Nx4h33627CIltzPxNt9Jft11USQ3DZudTJGzU=; b=m4f4SUUQtL1CRrateAC8c2kSFN
        d8v65a6NXFu5xEZp+CYTkrXiNxClaFfxMpJzBr2UJENbNjyZmsP5vdgA2mrSocEX5h7o67qr5799B
        7r5hClhdb7QeC+OvKKM4DRJtlUvaUy7UXn0aUGh33gLX24kMqlsNu2lsnCdhPbrszAQE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gErn0-0007p8-WD; Tue, 23 Oct 2018 08:11:47 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5ED2D7A36C3; Tue, 23 Oct 2018 04:11:44 -0400 (EDT)
Date:   Tue, 23 Oct 2018 04:11:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     NeilBrown <neil@brown.name>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181023081144.GN1617@thunk.org>
Reply-To: t@thunk.org
Mail-Followup-To: t@thunk.org, NeilBrown <neil@brown.name>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181023033130.GQ32577@ZenIV.linux.org.uk>
 <87r2gh70ij.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2gh70ij.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 03:25:08PM +1100, NeilBrown wrote:
> 
> Yes, you could, and you can.  But if it was Linus who was behaving
> inappropriately, where did you go then?  This is why I think whatever
> "code" we have should be overtly a statement Linus makes about his
> behaviour, in the first instance.

You're still missing the point, and the problem.  The concern was not
*that* a patch was rejected, it was in *how* the patch was rejected.
The "problem" has never been about how Linus was treating anyone other
than core maintainers; i.e., most of the rants that I can think of (a)
happened years of ago, and (b) were directed at the sort of people who
were in the room at the Maintainer's Summit yesterday.  Who which, by
the way, didn't have a complaint about Linus's recent behavior; in
fact, there was general agreement that Linus's behavior has been
getting *better* over the last few years.

One of the more important effects of the CoC is that newcomers have a
fear about Linux's reputation of having extremely toxic community.
There is a narrative that has been constructed that because Linus
behaves badly to everyone; and this gives everyone "permission" to
behave badly.  Regardless of how true it may have been in the past, I
believe that it is largely obsolete today.  And so, the mere existence
of a CoC has caused some newcomers to say that they have "already
noticed a difference" --- which is IMO mostly the effect of CoC easing
fears, as opposed to any real change in Linux community in the past
four weeks.

I think how it will work out in practice is that the CoC will be more
a commitment about what we are holding up as community norms.
Unfortunately, for some poeple the term "CoC" apparently acts as
trigger language and it brings to mind legal proceedings,
unaccountable court-like entities, and hammering people with
punishments for petty issues with no appeal or recourse.

Perhaps this is why other communities have elected to use terms such
as "How to do Samba: Nicely" and "GNU Kind Communication Guidelines".
All of these are trying to solve the same issue, and so my suggestion
is let's just wait and see how things go.  If people continue to see
that the community has "changed" for the better, and other people see
that we're not hammering people with sanctions, but rather reminding
each other about the kind of community we aspire to be, it'll all be
good.

						- Ted
