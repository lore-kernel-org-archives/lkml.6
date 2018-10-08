Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC11FC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACE52086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACE52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJHWuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:50:18 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:51716 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeJHWuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:50:17 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w98Fbn4c013828;
        Mon, 8 Oct 2018 16:37:49 +0100
Date:   Mon, 8 Oct 2018 16:37:48 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Tim.Bird@sony.com, ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Message-ID: <20181008163748.0e68cba5@alans-desktop>
In-Reply-To: <1538883209.4088.14.camel@HansenPartnership.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861851.4088.7.camel@HansenPartnership.com>
        <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
        <1538883209.4088.14.camel@HansenPartnership.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I happen to think that the fact that the TAB cannot compel where it
> cannot persuade is a huge strength of the system because it means
> there's no power structure to subvert if someone were interested in
> using it to try to impose their own viewpoint on the community.  But
> that's just my opinion and I did write the TAB charter, so I'm probably
> biased in this viewpoint.

The TAB can't handle it anyway because the privacy promise about
reporting is incompatible with reality for three reasons (and I bet there
are more)

1. Things like the EUCD can force almost all but the name to be revealed
to the person complained about as the tab has no legal privilege.
2. There are lots of laws in lots of locations where some allegations
*MUST* be reported to law enforcement.
3. We know from things like the catholic church debacle that serious
allegations need to be fast-pathed to the legal system - yet the privacy
promises are incompatible with that.

It ever got really nasty then the scenario that unfolds is potentially
the following

Developer A makes a complaint about developer B
Developer B's employer fires developer B

Developer B then uses things like the EUCD to force the TAB to provide
the complaint details (with personal data redacted) and the TAB has no
real defence as it's not legally privileged. 

Developer B then sues developer A, the TAB for all sorts of things, the
LF and their employer.

In court what's going to happen to the TAB ?

= Where is your written policy ?
= Who approved it and reviewed it for legal compliance ?
= What are your qualifications in this area ?
= Where are the full minutes of the decision ?
= Which of you work for rival companies ?
= What personal connections do or your frends have to A and B ?

Needless to say answers like 'we don't have one, nobody, none, umm I think
there's an email thread' are not going to go down well.

This sort of mess works with big company HR departments because they've
got lawyers and they have lots of written process. If it hits a court
then B's employer is able to point at all their rules and policies,
employment contracts etc. All of the decisions were either legally
privileged or minuted properly. The people who made the decisions have
appropriate professional qualifications.

The TAB can't enforce anything. If maintainers decide to carry on
accepting patches from someone what can they do ?

So both patches:

Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>


