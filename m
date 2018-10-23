Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F2AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE912064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE912064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeJWPaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:30:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34551 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeJWPaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:30:01 -0400
X-Originating-IP: 167.98.65.38
Received: from localhost (unknown [167.98.65.38])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5CE6EE0006;
        Tue, 23 Oct 2018 07:07:51 +0000 (UTC)
Date:   Tue, 23 Oct 2018 08:07:50 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [GIT PULL] code of conduct fixes for 4.19-rc8
Message-ID: <20181023070750.GB3068@localhost>
References: <1540066514.3464.22.camel@HansenPartnership.com>
 <20181022211025.GA8911@kroah.com>
 <23e41205115d317908c63d37a20ee316b44a8404.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e41205115d317908c63d37a20ee316b44a8404.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 09:16:20PM -0700, Joe Perches wrote:
> On Mon, 2018-10-22 at 22:10 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Oct 20, 2018 at 01:15:14PM -0700, James Bottomley wrote:
> > > This is the series of patches which has been discussed on both ksummit-
> > > discuss and linux-kernel for the past few weeks.  As Shuah said when
> > > kicking off the process, it's designed as a starting point for the next
> > > phase of the discussion, not as the end point, so it's only really a
> > > set of minor updates to further that goal.
> > > 
> > > The merger of the three patches to show the combined effect is attached
> > > below.  However, Greg recently posted the next phase of the discussion,
> > > so people will be asking what the merger of the series looks like. 
> > > Ignoring the non-CoC documents, I think it looks like this
> > 
> > Sorry for not responding sooner for this, travel and the meeting today
> > took up my time.
> > 
> > Anyway, as we discussed today in the Maintainers summit, let's leave the
> > Code of Conduct text alone for now.  It matches what "upstream" has with
> > the exception of removing that one paragraph.  If you have issues with
> > the wording in it, please work with upstream to fix the issues there as
> > hundreds of other projects will benefit with your changes if they are
> > really needed.
> 
> Given the different development models, that's not
> a very compelling argument.
> 
> As James Bottomley has suggested multiple times,
> I'd much rather kernel development use the debian
> code of conduct verbatim than even this modified one.
> 
> https://www.debian.org/code_of_conduct

The Debian code of conduct doesn't do nearly as good a job of addressing
issues. (Debian also adopted that code of conduct back when such codes
weren't nearly as well understood or established.) Many people *in*
Debian, including supporters of their current CoC, have an interest in
improving it further and/or adopting a more well-established one.
