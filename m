Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303F3C67863
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 00:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD60B21748
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 00:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD60B21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJUI0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 04:26:17 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:53792 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbeJUI0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 04:26:16 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9L0DnJL010830;
        Sun, 21 Oct 2018 01:13:49 +0100
Date:   Sun, 21 Oct 2018 01:13:48 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     <Tim.Bird@sony.com>
Cc:     <gregkh@linuxfoundation.org>,
        <ksummit-discuss@lists.linuxfoundation.org>, <mishi@linux.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
 contact email address
Message-ID: <20181021011348.564a3fe4@alans-desktop>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF80528627@USCULXMSG01.am.sony.com>
References: <20181020134908.GA32218@kroah.com>
        <20181020135118.GG32218@kroah.com>
        <20181020192845.48b8b860@alans-desktop>
        <ECADFF3FD767C149AD96A924E7EA6EAF80528627@USCULXMSG01.am.sony.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Data protection law, reporting laws in some
> > countries and the like mean that anyone expecting an incident to remain
> > confidential from the person it was reported against is living in
> > dreamland and are going to get a nasty shock.  
> 
> OK - you seem to be talking about keeping the incident and reporter
> confidential from the person reported against.
> Certainly the  person reported against has to have the incident
> identified to them, so that part is not confidential.  Many legal
> jurisdictions require that the accused can know their accuser.
> But these things come into play mostly when items have veered
> into legal territory.  Most violation reports are not in the territory.
> There's no legal requirement that the Code of Conduct committee
> tell someone who it was that said they were rude on the mailing list.

The 'who said' is generally safe (except from the it's in court case -
which is fine when that happens the legal process deals with it). The
other details are not so while someone accused of something might not
know who said it they can ask for what personal data (which would include
that email with names etc scrubbed).

You can possibly fight that in court of course, if you've got lots of
money and nothing better to do for six weeks.

> > You should also reserving the right to report serious incidents directly
> > to law enforcement. Unless of course you want to be forced to sit on
> > multiple reports of physical abuse from different people about
> > someone - unable to tell them about each others report, unable to prove
> > anything, and in twenty years time having to explain to the media why
> > nothing was done.  
> 
> The scope of the code of conduct basically means that it covers
> online interactions (communication via mailing list, git commits
> and Bugzilla).  

I don't see it specifically stating that 'If someone is offensive at a
kernel summit we are going to refuse to listen'

Seriously ?

Alan
