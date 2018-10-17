Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46255ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E600A2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E600A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJQX5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:57:04 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54303 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQX5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:57:03 -0400
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EEA3424001C;
        Wed, 17 Oct 2018 16:00:38 +0000 (UTC)
Date:   Wed, 17 Oct 2018 09:00:36 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org, tomi.valkeinen@iki.fi
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181017160036.GA18198@localhost>
References: <20181017071902.30102-1-geert@linux-m68k.org>
 <20181017091325.GA15991@localhost>
 <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
 <20181017152101.GA17531@localhost>
 <1539791355.3769.35.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539791355.3769.35.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:49:15AM -0700, James Bottomley wrote:
> On Wed, 2018-10-17 at 08:21 -0700, Josh Triplett wrote:
> > People in underrepresented and commonly marginalized groups,
> > especially those more commonly overlooked, don't always know if a
> > given group has taken their particular group into account or given
> > any thought to it. Explicit inclusion helps, and this is a standard
> > guideline often cited for good codes of conduct.
> 
> Actually, that's not a good thing to do in a vacuum: you have to be
> really careful about how you do this from a legal point of view.  The
> argument over whether enumerating specific rights or classes disparages
> others has been going on for centuries.  To give you an example of how
> far back it goes: it's the reason for the ninth amendment to the US
> constitution.
> 
> The commonly accepted legal way of doing this today is the statement
> 
> "examples of X include but are not limited to: ..."
> 
> which is thought to work in most jurisdictions and is what you'll find
> in all US corporate codes of conduct or ethics.

Which is a much better proposal than removing the list entirely.
