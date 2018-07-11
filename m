Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A6BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBB420878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBB420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeGKJZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:25:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42971 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeGKJZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:25:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EAFC3206ED; Wed, 11 Jul 2018 11:22:31 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 75EEF20732;
        Wed, 11 Jul 2018 11:22:13 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:22:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RTC for 4.18
Message-ID: <20180711092213.GN16084@piout.net>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
 <20180626161536.GH4207@piout.net>
 <522c3fc8-a4cc-bd83-d034-b5c690e541d0@nvidia.com>
 <20180626213138.GI4207@piout.net>
 <7fab97df-9cd9-fa57-47a8-883a717dd96c@nvidia.com>
 <20180709121747.GG16084@piout.net>
 <20180710221410.GL16084@piout.net>
 <dccdc3e9-4fac-ee05-dab0-3533c274f59c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dccdc3e9-4fac-ee05-dab0-3533c274f59c@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 10:17:11+0100, Jon Hunter wrote:
> Hi Alexandre.
> 
> On 10/07/18 23:14, Alexandre Belloni wrote:
> > Hi Jon,
> > 
> > Can you test that one?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=4393575d9aa250c74335f8b37e0466b872b5080
> > 
> > This fixes setting alarms on the TPS658623 of my T20 board but I don't
> > get the interrupt I'm expecting. However, I don't get interrupts with
> > the offending patch reverted so hopefully, this fix is sufficient.
> 
> Yes this fixes the problem. Feel free to add my ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 

Great ! Thank you for your patience, I'll send it as a fix before Sunday.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
