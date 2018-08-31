Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79145C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA43420839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA43420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeHaUAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:00:34 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:60507 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeHaUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:00:33 -0400
Received: from belgarion ([90.89.234.36])
        by mwinf5d40 with ME
        id VrsP1y00Y0nnJME03rsPF0; Fri, 31 Aug 2018 17:52:25 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 31 Aug 2018 17:52:25 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: pxa: fix power i2c base address
References: <20180831120309.8723-1-marcel@ziswiler.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 31 Aug 2018 17:52:23 +0200
In-Reply-To: <20180831120309.8723-1-marcel@ziswiler.com> (Marcel Ziswiler's
        message of "Fri, 31 Aug 2018 14:03:09 +0200")
Message-ID: <874lfa7cug.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Ziswiler <marcel@ziswiler.com> writes:

> There is one too many zeroes in the Power I2C base address. Fix this.
>
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Queued to pxa/dt, thanks.

Cheers.

--
Robert
