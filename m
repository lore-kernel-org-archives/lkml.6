Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2634EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF18020818
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfB0WBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:01:11 -0500
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:22439 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfB0WBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:01:11 -0500
Received: from belgarion ([90.76.35.80])
        by mwinf5d21 with ME
        id hy0w1z00N1jkVcS03y14dU; Wed, 27 Feb 2019 23:01:07 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 27 Feb 2019 23:01:07 +0100
X-ME-IP: 90.76.35.80
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: pxa: remove CONFIG_SND_PXA2XX_AC97 in pxa_defconfig
References: <20190219145214.3811804-1-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 27 Feb 2019 23:00:56 +0100
In-Reply-To: <20190219145214.3811804-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Tue, 19 Feb 2019 15:51:57 +0100")
Message-ID: <87y360lwmf.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The CONFIG_SND_PXA2XX_AC97 driver is for the old AC97 bus implementation,
> and conflicts with all the new-style AC97 drivers after the conversion,
> so the drivers we want all get turned off.
>
> Not disabling the symbol however does the right thing, and we get
> the drivers that are selectively enabled here.
>
> Fixes: 25540f68c871 ("ASoC: pxa: change ac97 dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Yes, most certainly.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
