Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DF8208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DF8208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeH0S5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:57:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45275 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbeH0S5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:57:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3AA3320739; Mon, 27 Aug 2018 17:10:53 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 10D23206A6;
        Mon, 27 Aug 2018 17:10:53 +0200 (CEST)
Date:   Mon, 27 Aug 2018 17:10:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: at91: pm: remove pm_bu initialization in
 at91_pm_backup_init()
Message-ID: <20180827151052.GD23428@piout.net>
References: <1533714460-6883-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533714460-6883-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 10:47:40+0300, Claudiu Beznea wrote:
> There is no need to initialize pm_bu since it is used only if backup
> mode is selected. In case backup mode initialization fails (which means
> pm_bu is invalid) the ULP0 mode will be selected.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/pm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
