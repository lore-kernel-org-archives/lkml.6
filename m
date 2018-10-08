Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E708C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36B72145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36B72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJHX0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:26:39 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37851 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHX0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:26:39 -0400
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4BCE5C000A;
        Mon,  8 Oct 2018 16:14:06 +0000 (UTC)
Date:   Mon, 8 Oct 2018 09:14:05 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181008161404.GA11021@localhost>
References: <20181007085102.17795-1-geert@linux-m68k.org>
 <20181007113514.GA21217@localhost>
 <20181008164247.48b60ba7@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008164247.48b60ba7@alans-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:42:47PM +0100, Alan Cox wrote:
> > In any case, this is not the appropriate place for such patches, any
> > more than it's the place for patches to the GPL.
> 
> I disagree. We had the GPLv2 or GPLv3 discussion on the kernel mailing
> list. The syscall clarification was discussed on the list. The
> EXPORT_SYMBOL and EXPORT_SYMBOL_GPL stuff was discussed on the list.

And discussion of this could occur on the list, as well. I said "for
such patches", not "for such discussion".

And, incidentally, this particular issues has now been addressed
upstream. I proposed a change to the FAQ, which has now been merged. See
https://www.contributor-covenant.org/faq and
https://github.com/ContributorCovenant/contributor_covenant/pull/612 .
