Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65EDC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD9420855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfBHPYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:40 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:53807 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfBHPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:38 -0500
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr [109.213.164.40])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0C8EB10000E;
        Fri,  8 Feb 2019 15:24:35 +0000 (UTC)
Date:   Fri, 8 Feb 2019 16:24:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60
 SoC
Message-ID: <20190208152435.GC23062@piout.net>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
 <20190206181221.27914-3-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206181221.27914-3-nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2019 19:12:21+0100, Nicolas Ferre wrote:
> Add support for additional reset causes and the proper compatibility
> string for sam9x60 SoC. The restart function is the same as the samx7.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: split series and collect tag
> 
> Sebastian,
> I add your Acked-by tag here but as I would like that you take the 3 patches on
> your tree now, I let you modify it on your side. I'm expecting Alexandre or
> Ludovic to have a look as well.
> 

Sebastian, please take this series through your tree. Thanks!

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
