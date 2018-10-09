Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB35FC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AA7214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ExKJETKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AA7214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJJC53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:57:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37464 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJJC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:57:29 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F3136F8;
        Tue,  9 Oct 2018 21:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539113937;
        bh=2+pe5ukg8mo3BH0sHqB2EodCd03IrAi50qSKZTjs/6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExKJETKYUBuWpPVIShomt06vtIvPSYzIQYyYpqIMHppotdveNY+slx6s/1Zwehh+C
         oyLj/8YwYQ6GHdOhbXT8u4apekZDC2UdkmBXliCj70HyQz2d3LgQb09V5YjWn+PyDl
         GOdJxHwanjQ/sQV4cHZxzWNBwA3w3mA/HlgulKGk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Rainer Fiebig <jrf@mailbox.org>,
        james.bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email addresses
Date:   Tue, 09 Oct 2018 22:38:57 +0300
Message-ID: <1877914.JXSoZ9jg4d@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181009185622.GA20960@localhost>
References: <1538861738.4088.5.camel@HansenPartnership.com> <1718828.OxLgMoHbrt@siriux> <20181009185622.GA20960@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Tuesday, 9 October 2018 21:56:23 EEST Josh Triplett wrote:
> On Tue, Oct 09, 2018 at 08:29:24PM +0200, Rainer Fiebig wrote:
> > Am Montag, 8. Oktober 2018, 08:20:44 schrieb Josh Triplett:
> >> On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley wrote:
> >>> The current code of conduct has an ambiguity in the it considers
> >>> publishing private information such as email addresses unacceptable
> >>> behaviour. Since the Linux kernel collects and publishes email
> >>> addresses as part of the patch process, add an exception clause for
> >>> email addresses ordinarily collected by the project to correct this
> >>> ambiguity.
> >> 
> >> Upstream has now adopted a FAQ, which addresses this and many other
> >> questions. See https://www.contributor-covenant.org/faq .
> >> 
> >> Might I suggest adding that link to the bottom of the document, instead?
> >> (And then, optionally, submitting entries for that FAQ.)
> > 
> > The Code of Conflict has 28 lines, including the heading.
> > The Code of Conduct has 81 lines, including the heading. And it needs a
> > FAQ. Hm.
> 
> Yes, it turns out to be a more complicated problem than it was
> previously oversimplified to. People don't automatically share a common
> understanding.

I see an elephant in the room in the fact that we have carefully avoided 
discussing whether people share a common goal here :-/

-- 
Regards,

Laurent Pinchart



