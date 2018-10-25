Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0863ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6A20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB6A20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeJYIz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:55:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58976 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYIzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:55:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6F87B207C3; Thu, 25 Oct 2018 02:25:37 +0200 (CEST)
Received: from localhost (unknown [2.223.63.88])
        by mail.bootlin.com (Postfix) with ESMTPSA id 31C9120729;
        Thu, 25 Oct 2018 02:25:37 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:25:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     a.zummo@towertech.it, broonie@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix some issues for RTC alarm function
Message-ID: <20181025002537.GA2737@piout.net>
References: <cover.1539851865.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 16:52:25+0800, Baolin Wang wrote:
> This patch set fixes some issues when setting one RTC alarm.
> 
> Baolin Wang (5):
>   rtc: sc27xx: Set wakeup capability before registering rtc device
>   rtc: sc27xx: Clear SPG value update interrupt status
>   rtc: sc27xx: Remove interrupts disable and clear in probe()
>   rtc: sc27xx: Add check to see if need to enable the alarm interrupt
>   rtc: sc27xx: Always read normal alarm when registering RTC device
> 
>  drivers/rtc/rtc-sc27xx.c |   60 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 20 deletions(-)
> 

All applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
