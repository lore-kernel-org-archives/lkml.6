Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44443C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4C208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C4C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeKKVOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:14:19 -0500
Received: from shell.v3.sk ([90.176.6.54]:53646 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbeKKVOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:14:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E7813C650D;
        Sun, 11 Nov 2018 12:25:57 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NHlmcplRNRzi; Sun, 11 Nov 2018 12:25:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3BF2EC650E;
        Sun, 11 Nov 2018 12:25:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7H3N_zoBKKGA; Sun, 11 Nov 2018 12:25:54 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8190EC650D;
        Sun, 11 Nov 2018 12:25:54 +0100 (CET)
Message-ID: <2af6aa65313a9cb6c47fd4756c48f2963aa317c6.camel@v3.sk>
Subject: Re: [PATCH 10/17] mailbox: bcm2835: Switch to SPDX identifier
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sun, 11 Nov 2018 12:25:53 +0100
In-Reply-To: <1541865555-7647-1-git-send-email-stefan.wahren@i2se.com>
References: <1541865555-7647-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-10 at 16:59 +0100, Stefan Wahren wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/mailbox/bcm2835-mailbox.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/mailbox/bcm2835-mailbox.c
> b/drivers/mailbox/bcm2835-mailbox.c
> index e92bbc5..bb3ee72 100644
> --- a/drivers/mailbox/bcm2835-mailbox.c
> +++ b/drivers/mailbox/bcm2835-mailbox.c
> @@ -1,15 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   *  Copyright (C) 2010,2015 Broadcom
>   *  Copyright (C) 2013-2014 Lubomir Rintel
>   *  Copyright (C) 2013 Craig McGeachie
>   *
> - * This program is free software; you can redistribute it and/or
> modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This device provides a mechanism for writing to the mailboxes,
> - * that are shared between the ARM and the VideoCore processor
> - *
>   * Parts of the driver are based on:
>   *  - arch/arm/mach-bcm2708/vcio.c file written by Gray Girling that
> was
>   *    obtained from branch "rpi-3.6.y" of
> git://github.com/raspberrypi/

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

