Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7069ECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 01:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2B0207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 01:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2B0207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeJ0Jt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 05:49:28 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40383 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJ0Jt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 05:49:28 -0400
Received: from localhost (unknown [167.98.65.38])
        (Authenticated sender: josh@joshtriplett.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1571920000F;
        Sat, 27 Oct 2018 01:10:10 +0000 (UTC)
Date:   Sat, 27 Oct 2018 02:10:10 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     NeilBrown <neil@brown.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181027011010.GA29769@localhost>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181024121622.GA10942@localhost>
 <87ftwt6850.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftwt6850.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:14:51AM +1100, NeilBrown wrote:
> On Wed, Oct 24 2018, Josh Triplett wrote:
> 
> > On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
> >> On Sun, Oct 21 2018, Josh Triplett wrote:
> >> 
> >> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
> >> >> I call on you, Greg:
> >> >>  - to abandon this divisive attempt to impose a "Code of Conduct"
> >> >>  - to revert 8a104f8b5867c68
> >> >>  - to return to your core competence of building a great team around
> >> >>    a great kernel
> >> >> 
> >> >>  #Isupportreversion
> >> >> 
> >> >> I call on the community to consider what *does* need to be said, about
> >> >> conduct, to people outside the community and who have recently joined.
> >> >> What is the document that you would have liked to have read as you were
> >> >> starting out?  It is all too long ago for me to remember clearly, and so
> >> >> much has changed.
> >> >
> >> > The document I would have liked to have read when starting out is
> >> > currently checked into the source tree in
> >> > Documentation/process/code-of-conduct.rst .
> >> 
> >> I'm curious - what would you have gained by reading that document?
> >
> > I would have then had rather less of a pervasive feeling of "if I make
> > even a single mistake I get made an example of in ways that will feed
> > people's quotes files for years to come".
> 
> Thanks for your reply.  Certainly feeling safe is important, and having
> clear statements that the community values and promotes psychological
> safety is valuable.
> 
> The old "code of conflict" said
>    If however, anyone feels personally abused, threatened, or otherwise
>    uncomfortable due to this process, that is not acceptable. 
> 
> would you have not found this a strong enough statement to ward off that
> pervasive feeling?

Not when that document started out effectively saying, in an elaborate
way, "code > people". (Leaving aside that the more important detail
would be the community actually acting consistently with the code of
conduct it espoused.)

> In the current code, would The "Our Pledge" section have been
> sufficient, or do you think the other sections would have actually
> helped you?

"Our Standards" would have been at least as important to me personally,
as would "Enforcement" (and more importantly, examples of that applying
in practice and not just as empty words).
