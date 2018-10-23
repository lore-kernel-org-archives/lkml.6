Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6C8C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8323320651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8323320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJWNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:14:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35096 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeJWNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:14:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEogR-0003sw-HR; Tue, 23 Oct 2018 04:52:47 +0000
Date:   Tue, 23 Oct 2018 05:52:47 +0100
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
Message-ID: <20181023045247.GV32577@ZenIV.linux.org.uk>
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
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 03:25:08PM +1100, NeilBrown wrote:

> >> If Linus is not true to his new-found sensitivity, we might need someone
> >> (Greg?) to be a co-maintainer, able to accept patches when Linus has a
> >> relapse.  It might be good form to create this channel anyway, but I
> >> doubt it would be needed in practice.
> >> 
> >> So there you have it. The "Code" is upside down.
> >> We need documents which:
> >>   - curtail the power of the strong, starting with Linus
> >>   - are adopted willingly by individuals, not imposed on the community.
> >>   - provide alternate routes for patch-flow, so that no-one has ultimate
> >>     power.
> >
> > Really?  The ultimate power being to say "No" to a patch, and nobody should
> > have such?  Are you fucking serious?
> 
> I have noticed of late a tendency in all sorts of different people to
> hear/read a statement from someone they know, interpret it a particular
> way, be surprised about that interpretation, and persist with believing
> that interpretation anyway, rather than realizing that the most likely
> explanation is a communication failure, and asking for clarification.
> 
> The "ultimate power" is the ability to say "no" to a patch, *with no
> opportunity for review*.  Two people together having that ultimate power
> is a totally different thing to one person having it alone.

If that's a clarification, I'm sorry to say that I understand you even less now.
What are you proposing?  Duopoly?  How do you deal with disagreements?  Fork?
Revert wars?

Frankly, CoC as-is is a bloody awful idea wide-open to abuses, but what you
are proposing feels even more incoherent...
