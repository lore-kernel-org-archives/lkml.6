Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC8FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D5220846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D5220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbeGZRjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:39:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49471 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbeGZRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:39:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ADAFA805A1; Thu, 26 Jul 2018 18:22:08 +0200 (CEST)
Date:   Thu, 26 Jul 2018 18:21:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alex Richman <alex.r@gblabs.co.uk>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Very slow SYS_io_destroy()
Message-ID: <20180726162117.GA3054@localhost>
References: <27245a6a-a827-2662-215c-05ccdff65768@gblabs.co.uk>
 <x49fu0a3rz1.fsf@segfault.boston.devel.redhat.com>
 <4c5819ce-72cb-2ee3-06b9-8c3d0a11a0aa@gblabs.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5819ce-72cb-2ee3-06b9-8c3d0a11a0aa@gblabs.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-07-23 16:16:34, Alex Richman wrote:
> Thanks for the response.?? I'm running 4.4.123-1 from Gentoo.?? It
> also happens on 4.4.87-r1.

You may want to try 4.18 if you are out of other ideas...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
