Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C67C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71859213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfAJU5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:57:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33135 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbfAJU5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:57:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 26914207B6; Thu, 10 Jan 2019 21:57:01 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id F37CB206A6;
        Thu, 10 Jan 2019 21:57:00 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:57:01 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dianlong Li <long17.cool@163.com>
Cc:     robh@kernel.org, a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rtc: sd3078: new driver.
Message-ID: <20190110205701.GA2362@piout.net>
References: <1544696030-17159-1-git-send-email-long17.cool@163.com>
 <1544696030-17159-3-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544696030-17159-3-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2018 18:13:50+0800, Dianlong Li wrote:
> The sd3078 is a combination RTC and SRAM device with I2C interface.
> 
> Signed-off-by: Dianlong Li <long17.cool@163.com>
> ---
>  MAINTAINERS              |    6 ++
>  drivers/rtc/Kconfig      |    9 ++
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-sd3078.c |  232 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 248 insertions(+)
>  create mode 100644 drivers/rtc/rtc-sd3078.c
> 

All applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
