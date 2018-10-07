Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C81FC6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C232084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeJHGFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:05:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39320 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJHGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:05:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9Hy9-0007jS-M6; Sun, 07 Oct 2018 22:56:13 +0000
Date:   Sun, 7 Oct 2018 23:56:13 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Dave Airlie <airlied@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
Message-ID: <20181007225613.GZ32577@ZenIV.linux.org.uk>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:25:35AM +1000, Dave Airlie wrote:

> This isn't a legally binding license or anything, but departing from
> the upstream wording makes it tricker to merge new upstream versions
> if they are considered appropriate.

Nicely done, that - gotta love the passive voice use.  Considered appropriate
*by* *whom*?

Anyway, upstream clearly is a poor fit for Linus kernel community structure
- the use of open lists, amount of subprojects, the length of transmission
chains into the mainline, total amount of contributors, amount of people
elsewhere in the project with occasional forays into any given area, etc.
And IIRC the CoC upstream's opinion was that it wouldn't fit.

We can surround it with "explanations" until we get something that more or
less fits, but then we'd need to reanalyse them every time an upstream
change gets merged.  And the lack of textual conflicts is not a good thing
in such situations, obviously.
