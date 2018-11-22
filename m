Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8A206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE8A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406329AbeKWDxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:53:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35323 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732541AbeKWDxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:53:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 955F520D72; Thu, 22 Nov 2018 18:13:00 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6CFA720746;
        Thu, 22 Nov 2018 18:13:00 +0100 (CET)
Date:   Thu, 22 Nov 2018 18:13:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: isl1208: Use i2c block read/write routines
Message-ID: <20181122171300.GJ12656@piout.net>
References: <20181115185102.24046-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115185102.24046-1-tpiepho@impinj.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2018 18:51:18+0000, Trent Piepho wrote:
> The Linux i2c layer has functions to execute common SMBUS/I2C
> transactions.  The register access code here is identical to the I2C
> read/write block data routines.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 37 ++++---------------------------------
>  1 file changed, 4 insertions(+), 33 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
