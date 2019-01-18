Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE84AC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C99D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfARWNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:13:55 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:23644 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbfARWNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:13:55 -0500
Received: from belgarion ([86.206.19.74])
        by mwinf5d85 with ME
        id RyDs1z0021btlZA03yDsUf; Fri, 18 Jan 2019 23:13:53 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 18 Jan 2019 23:13:53 +0100
X-ME-IP: 86.206.19.74
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pxa2xx: replace spi_master with spi_controller
References: <20190116151330.1971861-1-lkundrak@v3.sk>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 18 Jan 2019 23:13:51 +0100
In-Reply-To: <20190116151330.1971861-1-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Wed, 16 Jan 2019 16:13:31 +0100")
Message-ID: <87won1r4v4.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> It's also a slave controller driver now, calling it "master" is slightly
> misleading.

I think the patch subject's prefix is not correct, should be :
"spi: pxa2xx: replace spi_master with spi_controller".

Apart from that, for the mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
