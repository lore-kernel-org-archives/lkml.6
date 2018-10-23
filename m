Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631AFC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F3A20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F3A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJWOXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:23:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35804 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:23:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEpkR-0004zX-KG; Tue, 23 Oct 2018 06:00:59 +0000
Date:   Tue, 23 Oct 2018 07:00:59 +0100
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
Message-ID: <20181023060059.GW32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181023033130.GQ32577@ZenIV.linux.org.uk>
 <87r2gh70ij.fsf@notabene.neil.brown.name>
 <20181023045247.GV32577@ZenIV.linux.org.uk>
 <87o9bl6xlo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9bl6xlo.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 04:28:03PM +1100, NeilBrown wrote:

> > If that's a clarification, I'm sorry to say that I understand you even less now.
> > What are you proposing?  Duopoly?  How do you deal with disagreements?  Fork?
> > Revert wars?
> 
> We already have team-maintainership arrangements - doing the same thing
> at the top level should not be that hard to imagine.
> 
> It really about "saying" no.  I suspect all members of a team would come
> to much the same decision about any given patch, but they might "say" it
> differently.  One might say "anyone who wrote this should be
> lobotomised", and the other might say "I see what you are trying to do,
> but the approach won't work - go look at how we handle XXXX, they have a
> similar problem".  Neither will accept the patch, and they will probably
> both accept it after certain changes.  But when one of them is having a
> bad day, I would like people to have the explicit opportunity to ignore
> them and talk to the other.  Yes, they'll still get "no" twice, but they'll
> also get something approaching sane review least once.

You still have not answered the question I've asked - what to do in case of
real disagreements, seeing that "pass it to Linus for final decision" obviously
doesn't work here.  And while we are at it, what to do in case when "they"
_agree_ that patch is unsalvagable?  I'm quite sure that you can think of
examples of such...

BTW, out of curiosity - when has anyone suggested lobotomies[1]?  I'd like to see
details - got to be interesting...

[1] on kernel development lists, that is - I can think of examples in e.g.
NANAE circa '98 or so regarding the SGI employees responsible for sendmail
setup they used to ship in IRIX, but that was more of a possible explanation
of the reasons rather than suggested remedy...
