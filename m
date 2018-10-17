Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD89ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D5521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D5521526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJQRIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:08:18 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58401 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeJQRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:08:18 -0400
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A8D586003E;
        Wed, 17 Oct 2018 09:13:28 +0000 (UTC)
Date:   Wed, 17 Oct 2018 02:13:26 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181017091325.GA15991@localhost>
References: <20181017071902.30102-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017071902.30102-1-geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:19:01AM +0200, Geert Uytterhoeven wrote:
> Providing an explicit list of discrimination factors may give the false
> impression that discrimination based on other unlisted factors would be
> allowed.

This impression is, in fact, false, as has already been discussed
elsewhere. I had hoped that discussion would suffice.

As mentioned there: The original commit explicitly said "Explicit
guidelines have demonstrated success in other projects and other areas
of the kernel."; this is precisely the kind of explicit guideline it
refers to. Listing explicit cases to cover does not imply other cases
are not covered; it does, however, ensure that the listed cases *are*,
and helps people know that they're covered.

This patch is not OK, and defeats one of the purposes of the original
change.
