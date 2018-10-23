Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD5C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD292064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD292064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJWLxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:53:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34226 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:53:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEnPm-0002bg-AG; Tue, 23 Oct 2018 03:31:30 +0000
Date:   Tue, 23 Oct 2018 04:31:30 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     NeilBrown <neil@brown.name>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181023033130.GQ32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zxt919d.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:

> Currently if a maintainer is rude to you, there is no where else that
> you can go and *that* is why it hurts.  It isn't the abuse so much as
> the powerlessness associated with it.  If you can (metaphorically) say
> to that maintainer "I don't care about your toilet mouth, you've just
> given me the right to take my petition to caesar" - then the emotional
> response will be quite different to pain.

Bollocks.  First of all, you *always* can take patches to Linus, even if
maintainer is being the sodding Miss Manners.  Always could.  What you
can't (and shouldn't be able to) is to _force_ a piece of shit patch
(pardon the toilet mouth) into the tree on the grounds of maintainer having
been "rude" to your patch.

Again, you can and always could appeal to Linus if your patches are wrongly
rejected, in your opinion.  You'd better have good evidence supporting the
"wrongly" bit in that case, but the "right to petition" model implies that
anyway.

If you are talking about the situations when "rude" maintainer makes insufferable
requests to one's precious patches (e.g. demonstrates his or her mental inferiority
by admitting that they are unable to follow contributor's 0.5KLoC of spaghetty in a
single function and has an unspeakable gall to demand to clean it up - instead of
passing that task upon the interns, as they ought to[1])... sure, that would be
something new.  Would you care to be the person charged with dealing with such...
valuable contributors?  And how good is the coverage of psychiatric treatments
offered by your medical insurance?

[1] no, I'm not making it up
 
> If Linus is not true to his new-found sensitivity, we might need someone
> (Greg?) to be a co-maintainer, able to accept patches when Linus has a
> relapse.  It might be good form to create this channel anyway, but I
> doubt it would be needed in practice.
> 
> So there you have it. The "Code" is upside down.
> We need documents which:
>   - curtail the power of the strong, starting with Linus
>   - are adopted willingly by individuals, not imposed on the community.
>   - provide alternate routes for patch-flow, so that no-one has ultimate
>     power.

Really?  The ultimate power being to say "No" to a patch, and nobody should
have such?  Are you fucking serious?

PS: All together, now -

Every Patch is Sacred,
Every Patch is Great,
If a Patch Is Wasted,
Neil Gets Quite Irate

may the filking begin...
