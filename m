Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECFAC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A939920824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A939920824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeJXUoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:44:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49799 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJXUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:44:20 -0400
X-Originating-IP: 185.7.230.215
Received: from localhost (unknown [185.7.230.215])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 60A1460003;
        Wed, 24 Oct 2018 12:16:23 +0000 (UTC)
Date:   Wed, 24 Oct 2018 13:16:22 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     NeilBrown <neil@brown.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181024121622.GA10942@localhost>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zxt919d.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
> On Sun, Oct 21 2018, Josh Triplett wrote:
> 
> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
> >> I call on you, Greg:
> >>  - to abandon this divisive attempt to impose a "Code of Conduct"
> >>  - to revert 8a104f8b5867c68
> >>  - to return to your core competence of building a great team around
> >>    a great kernel
> >> 
> >>  #Isupportreversion
> >> 
> >> I call on the community to consider what *does* need to be said, about
> >> conduct, to people outside the community and who have recently joined.
> >> What is the document that you would have liked to have read as you were
> >> starting out?  It is all too long ago for me to remember clearly, and so
> >> much has changed.
> >
> > The document I would have liked to have read when starting out is
> > currently checked into the source tree in
> > Documentation/process/code-of-conduct.rst .
> 
> I'm curious - what would you have gained by reading that document?

I would have then had rather less of a pervasive feeling of "if I make
even a single mistake I get made an example of in ways that will feed
people's quotes files for years to come".

See
https://hbr.org/2017/08/high-performing-teams-need-psychological-safety-heres-how-to-create-it
for more on the benefits of that.
