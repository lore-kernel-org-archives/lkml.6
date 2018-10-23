Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1C2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7FA20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="aF7bFyRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7FA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeJXAHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:07:52 -0400
Received: from imap.thunk.org ([74.207.234.97]:49066 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeJXAHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ndofp5I4d7JIFD2BEvua8eSw59LpQJzqt3r0BY2jpmA=; b=aF7bFyRhf3SojhAQsyLsLcKLXO
        RSdKf6nCe5uJdqhplwAXgP64HKNVxCni3zbBiOxoUeRamaJ4rXc5m3z/SbPZdzAw5kCe+swFvgPRz
        Q20vQbWb/UylnvLFppn4UCcjR8JwUDeU6P851tiCU3HmvJuUMP5DvAGrf7J0ocSCukQQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gEyqT-0002Yn-Rm; Tue, 23 Oct 2018 15:43:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B1EF27A36C3; Tue, 23 Oct 2018 11:43:41 -0400 (EDT)
Date:   Tue, 23 Oct 2018 11:43:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rainer Fiebig <jrf@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, t@thunk.org,
        NeilBrown <neil@brown.name>, Al Viro <viro@zeniv.linux.org.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181023154341.GF6850@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Rainer Fiebig <jrf@mailbox.org>, linux-kernel@vger.kernel.org,
        t@thunk.org, NeilBrown <neil@brown.name>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
 <87r2gh70ij.fsf@notabene.neil.brown.name>
 <20181023081144.GN1617@thunk.org>
 <1917804.q5V88l7eEq@siriux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1917804.q5V88l7eEq@siriux>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 04:22:54PM +0200, Rainer Fiebig wrote:
> 
> And whether that CoC does come with a political agenda or is just being
> *perceived* so, is irrelevant: the perception *is* the reality. And by 
> embracing this CoC, Linux is now being perceived as also supporting the agenda 
> that comes with it. But perhaps that was intended?
> 
> In my view you now have a new, probably even bigger problem: namely that by
> adopting *this* CoC and by unyieldingly clinging to it, you have alienated 
> many, if not the majority of loyal Linux-users/supporters.

Citation Needed: What's your *proof* the majority of Linux
users/supports have been alienated?  Many people have actually been
quite supportive of the CoC.

And perception is a funny thing.  I have no doubt that there are
people who will claim that some CoC's that might more be acceptable to
you would be "useless" or "means nothing".  (Note how simply removing
three lines that troubled ***many*** Maintainers caused Josh to
complain that it ruined the CoC).  And there are others for whom the
Contributor's Convenant automatically seems to mean kangaroo courts
and harsh punishments with no accountability for minor issues.  I
suspect that both you *and* Josh are unhappy, in opposite directions,
might be a hint that we've mostly gotten things right.

Another example of this is that zero-day testing bot changed its
message in order to be more welcoming to newcomers.  ("Thank you for
the patch! Yet something to improve...".)  At the Maintainer's Summit,
someone from Germany pointed out that in European and especially
German cultures, being ultra polite is often a signal that the person
is considered stupid/incompetent, and he actually viewed it the change
in the testing bot as making it be *less* welcoming, not *more*.  Not
that he cared, because he has a thick skin and after all, it's only a
'bot --- but in his view he thought it was quite funny that the change
was welcomed by some as being an improvement when he viewed it
completely the other way 'round.

Ultimately, we are a world-wide effort, and it's really hard to
predict or control how people from different cultures will perceive an
e-mail or some document.  That doesn't mean we shouldn't *try*, and
there may very well be times when someone will file a complaint for
what is perceived to be a Code of Conduct which is really a
misunderstanding due to a cultural mismatch.  (And *obviously* that's
not a CoC violation either, despite some people trying to spread FUD
by making the case that it would be.)

> In my view, the Linux-CoC stands for exactly that sort of extreme "Political 
> Correctness" that is infesting our societies and has proven its destructive 
> nature in more than enough instances. For some examples see [1][2][3][4][5].   
> 
> To me it feels more and more like the dark times of witch-hunts are back or 
> when it was politically in-correct to say that the earth revolves around the 
> sun. In those days offenders like Galilei were at least offered the choice 
> between recanting and the funeral-pile. Today you may recant but you get 
> publicly burnt anyway.

Yeah, and that's precisely the FUD that I'm talking about.  I
understand that is your view.  Let's see if it's actually true.  I
haven't seen any witch trials or burnings in the GoLang community,
which also uses the Contributor hConvenant as their CoC.  Can you be
open-minded enough to accept the fact that you might be wrong?  And
are you prepared to change your views if we don't see Maintainers
getting "impeached" or otherwise burned at the stake in the next year
or so?

And on the flip side, if we continue to have newcomers saying that
they are feeling more welcomed, I'm hoping that Josh is also open
minded to understand that the changes the we made didn't completely
destroy the whole point of the CoC.

Best regards,

						- Ted
