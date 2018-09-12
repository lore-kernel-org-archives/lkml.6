Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683C7C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B52087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3B52087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeILQW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:22:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50117 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeILQW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:22:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AC5AF20720; Wed, 12 Sep 2018 13:18:52 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 88DEE20618;
        Wed, 12 Sep 2018 13:18:52 +0200 (CEST)
Date:   Wed, 12 Sep 2018 13:18:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] rtc: abx80x: add basic watchdog support
Message-ID: <20180912111852.GD2760@piout.net>
References: <20180911172826.7195-1-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911172826.7195-1-jgebben@sweptlaser.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 11:28:24-0600, Jeremy Gebben wrote:
> This patch series adds watchdog support for abracon RTC chips which
> include basic watchdog functionality.
> 
> Thank you for reviewing.
> 
> Changes in v3 (all in patch 2):
> * fix CONFIG_WATCHDOG dependency again (hopefully correctly this time)
> * don't start hardware when set_timeout is called
> * remove unneeded WDOG_HW_RUNNING bit changes
> * fix abx80x_setup_watchdog()
> * fix formatting of multiline splits
>  
> Changes in v2:
> * split out priv structure into a separate patch
> * remove new Kconfig option
> * fix CONFIG_WATCHDOG dependency
> * fix WDT interrupt message
> 
> 
> Jeremy Gebben (2):
>   rtc: abx80x: use a 'priv' struct for client data
>   rtc: abx80x: add basic watchdog support
> 
>  drivers/rtc/Kconfig      |   1 +
>  drivers/rtc/rtc-abx80x.c | 143 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 132 insertions(+), 12 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
