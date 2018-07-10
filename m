Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F4CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14252098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14252098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeGJWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:15:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57803 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeGJWP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:15:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 307932079C; Wed, 11 Jul 2018 00:14:21 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03FD3206A6;
        Wed, 11 Jul 2018 00:14:11 +0200 (CEST)
Date:   Wed, 11 Jul 2018 00:14:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RTC for 4.18
Message-ID: <20180710221410.GL16084@piout.net>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
 <20180626161536.GH4207@piout.net>
 <522c3fc8-a4cc-bd83-d034-b5c690e541d0@nvidia.com>
 <20180626213138.GI4207@piout.net>
 <7fab97df-9cd9-fa57-47a8-883a717dd96c@nvidia.com>
 <20180709121747.GG16084@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709121747.GG16084@piout.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Can you test that one?

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=4393575d9aa250c74335f8b37e0466b872b5080

This fixes setting alarms on the TPS658623 of my T20 board but I don't
get the interrupt I'm expecting. However, I don't get interrupts with
the offending patch reverted so hopefully, this fix is sufficient.

On 09/07/2018 14:17:47+0200, Alexandre Belloni wrote:
> On 09/07/2018 13:04:36+0100, Jon Hunter wrote:
> > > Ok, I probably found the issue but the fix is not immediate. I'll try to
> > > post something tomorrow.
> > 
> > Sorry if I missed it, but did you send a fix for this?
> > 
> 
> Not yet, I'll keep you copied. I was missing the serial cable of my T20
> board with this PMIC. I'll try to find some time later this week to
> solve that.
> 
> If I can't fix it on time, I'll revert the patch.
> 
> 
> -- 
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
