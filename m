Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C864C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEFA20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEFA20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGZUxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:53:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44610 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730402AbeGZUxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:53:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7CBDD20922; Thu, 26 Jul 2018 21:35:32 +0200 (CEST)
Received: from localhost (unknown [88.128.80.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32A7E20908;
        Thu, 26 Jul 2018 21:35:22 +0200 (CEST)
Date:   Thu, 26 Jul 2018 21:35:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: TXx9: remove useless RTC definitions
Message-ID: <20180726193522.GA3074@piout.net>
References: <20180726164054.9092-1-alexandre.belloni@bootlin.com>
 <20180726174015.2brsh3x5abcdqh27@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726174015.2brsh3x5abcdqh27@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2018 10:40:15-0700, Paul Burton wrote:
> Hi Alexandre,
> 
> On Thu, Jul 26, 2018 at 06:40:54PM +0200, Alexandre Belloni wrote:
> > The RTC definitions were moved to the driver, remove them from the platform
> > header.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  arch/mips/include/asm/txx9/tx4939.h | 27 ---------------------------
> >  1 file changed, 27 deletions(-)
> 
> Thanks - applied to mips-next for 4.19, with a small change to also
> remove the tx4939_rtc_reg macro.
> 

Ah, thanks, I missed that one as it was not used.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
