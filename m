Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB5C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F61721924
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfBGTqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:46:09 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52619 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:46:08 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 39B3320006;
        Thu,  7 Feb 2019 19:46:01 +0000 (UTC)
Date:   Thu, 7 Feb 2019 20:46:01 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] rtc: imx-sc: add rtc set time support
Message-ID: <20190207194601.GG4719@piout.net>
References: <1548127476-7958-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548127476-7958-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2019 03:29:24+0000, Anson Huang wrote:
> This patch adds i.MX system controller RTC set time support, the
> RTC set time is implemented via SIP(silicon provider) runtime
> service call and ARM-Trusted-Firmware will communicate with system
> controller via MU(message unit) IPC to set RTC time.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/rtc/rtc-imx-sc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
