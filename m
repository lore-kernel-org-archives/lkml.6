Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82276C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4992177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfBRVgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:36:10 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37713 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfBRVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:36:10 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5628760004;
        Mon, 18 Feb 2019 21:36:07 +0000 (UTC)
Date:   Mon, 18 Feb 2019 22:36:06 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support
Message-ID: <20190218213606.GA10129@piout.net>
References: <20190217185257.2131-1-panfilov.artyom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217185257.2131-1-panfilov.artyom@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2019 21:52:56+0300, Artem Panfilov wrote:
> This patch adds support for AB-RTCMC-32.768kHz-EOZ9 RTC/Calendar
> module with I2C interface.
> 
> v3:
> - Move validity check before reading time registers
> - Add V1F/V2F check before reading the temperature
> - Fix missing check of a return value
> 
> v2:
> - Remove a package denomination in variable names and files
> - Fix read/write time registers length
> - Replace regmap_update_bits with regmap_write during probing
> - Add a check and reset for PON, V2F, V1F registers
> - Rename registers according to the datasheet
> 
> Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
> ---
>  drivers/rtc/Kconfig       |  10 +
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-ab-eoz9.c | 465 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 476 insertions(+)
>  create mode 100644 drivers/rtc/rtc-ab-eoz9.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
