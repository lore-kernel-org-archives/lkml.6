Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1BCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38162151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38162151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeISWpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:45:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57217 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbeISWpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:45:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2D52720728; Wed, 19 Sep 2018 19:06:10 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id B93362000E;
        Wed, 19 Sep 2018 19:05:58 +0200 (CEST)
Date:   Wed, 19 Sep 2018 19:05:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     a.zummo@towertech.it, andy.shevchenko@gmail.com, robh@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
Message-ID: <20180919170556.GB2479@piout.net>
References: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
 <20180725172605.108040-3-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725172605.108040-3-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2018 19:26:04+0200, Giulio Benetti wrote:
> m41txx chips can hold a calibration value to get correct clock bias.
> 
> Add offset handling (ranging between -63ppm and 126ppm) via sysfs.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 77 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
