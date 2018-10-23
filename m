Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8765C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A156920651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A156920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJWMh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:37:59 -0400
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:57753 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726764AbeJWMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:37:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5DC61181D340F;
        Tue, 23 Oct 2018 04:16:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crow76_1a9b1c704b316
X-Filterd-Recvd-Size: 2453
Received: from XPS-9350 (unknown [172.56.41.163])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Oct 2018 04:16:22 +0000 (UTC)
Message-ID: <23e41205115d317908c63d37a20ee316b44a8404.camel@perches.com>
Subject: Re: [Ksummit-discuss] [GIT PULL] code of conduct fixes for 4.19-rc8
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <greg@kroah.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Mon, 22 Oct 2018 21:16:20 -0700
In-Reply-To: <20181022211025.GA8911@kroah.com>
References: <1540066514.3464.22.camel@HansenPartnership.com>
         <20181022211025.GA8911@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 22:10 +0100, Greg Kroah-Hartman wrote:
> On Sat, Oct 20, 2018 at 01:15:14PM -0700, James Bottomley wrote:
> > This is the series of patches which has been discussed on both ksummit-
> > discuss and linux-kernel for the past few weeks.  As Shuah said when
> > kicking off the process, it's designed as a starting point for the next
> > phase of the discussion, not as the end point, so it's only really a
> > set of minor updates to further that goal.
> > 
> > The merger of the three patches to show the combined effect is attached
> > below.  However, Greg recently posted the next phase of the discussion,
> > so people will be asking what the merger of the series looks like. 
> > Ignoring the non-CoC documents, I think it looks like this
> 
> Sorry for not responding sooner for this, travel and the meeting today
> took up my time.
> 
> Anyway, as we discussed today in the Maintainers summit, let's leave the
> Code of Conduct text alone for now.  It matches what "upstream" has with
> the exception of removing that one paragraph.  If you have issues with
> the wording in it, please work with upstream to fix the issues there as
> hundreds of other projects will benefit with your changes if they are
> really needed.

Given the different development models, that's not
a very compelling argument.

As James Bottomley has suggested multiple times,
I'd much rather kernel development use the debian
code of conduct verbatim than even this modified one.

https://www.debian.org/code_of_conduct


