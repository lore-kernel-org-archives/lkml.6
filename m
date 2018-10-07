Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09596C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D242084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jPh5gum0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D242084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeJHA0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:26:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54508 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeJHA0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:26:05 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8CA08995;
        Sun,  7 Oct 2018 19:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538932686;
        bh=66fI5q/1P9etdVBd2mk0lukuql/tRQKIq8CLS4IHuuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPh5gum0IBzLICyachhuBH8DLHKynf3Q0qzDxfqVX+H0RZwvWnywCYReHQKGA4S4n
         rGg6APxBw21jWl9SrOl+HnRb5UsvByOXPgWUKUeBCimh6NTI2mySaKdEgyDsnnd34h
         e+YUG8UBOycFZVBvBiHCFZTXWvi36xejtLvJPhCE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list of discrimination factors
Date:   Sun, 07 Oct 2018 20:18:26 +0300
Message-ID: <1814283.64diKEr4zR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181007113514.GA21217@localhost>
References: <20181007085102.17795-1-geert@linux-m68k.org> <20181007113514.GA21217@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Sunday, 7 October 2018 14:35:14 EEST Josh Triplett wrote:
> On Sun, Oct 07, 2018 at 10:51:02AM +0200, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.
> > 
> > Avoid any ambiguity by removing the list, to ensure "a harassment-free
> > experience for everyone", period.
> 
> I would suggest reading the commit message that added this in the first
> place. "Explicit guidelines have demonstrated success in other projects
> and other areas of the kernel." See also various comparisons of codes of
> conduct, which make the same point. The point of this list is precisely
> to serve as one such explicit guideline; removing it would rather defeat
> the purpose.
> 
> In any case, this is not the appropriate place for such patches, any
> more than it's the place for patches to the GPL.

So what's an appropriate place to discuss the changes that we would like, 
*together*, to make to the current document and propose upstream ? As stated 
in another e-mail in a similar thread, I believe we need to come together and 
decide on what we want to do. We still have no official forum to do so, and 
repeatedly telling people that ksummit-discuss and LKML are not the right 
place won't make the concerns go away. Only by discussing problems will we 
come to solutions.

-- 
Regards,

Laurent Pinchart



