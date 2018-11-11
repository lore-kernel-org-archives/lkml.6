Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74412C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43019208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43019208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeKLHBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:01:52 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:33252 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeKLHBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 02:01:52 -0500
Received: from belgarion ([90.89.234.36])
        by mwinf5d16 with ME
        id ylC61y0020nnJME03lC6xh; Sun, 11 Nov 2018 22:12:08 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 11 Nov 2018 22:12:08 +0100
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: dts: pxa: add mioa701 board description
In-Reply-To: <20180915110206.23110-1-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Sat, 15 Sep 2018 13:02:06 +0200")
References: <20180915110206.23110-1-robert.jarzmik@free.fr>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
X-URL:  http://belgarath.falguerolles.org/
Date:   Sun, 11 Nov 2018 22:12:06 +0100
Message-ID: <874lcnl3o9.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Add device-tree description of the Mitac MIO A701 board.
> This is aimed at replacing mioa701.c board file, and once stabilized,
> the leftover, such as the suspend resume mechanics will rely on a new
> IPL, and not the legacy Windows CE one.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: fix lcd_supply and lcd_backlight
>           These were depending on my internal tree changes, fit it.
> Since v2: take into account Rob's comments
> Since v3: take into account Marcel's comments
>
> This patch deserves some special "love review". As it will probably
> serve for a more broad pxa conversion to devicetree of the other boards,
> and because it touches almost all domains for a pxa platform (camera,
> video, audio, i2c, ...), it should be as clean as possible so that
> mistakes are not carried on ...
>
> Therefore I expect the review of this one to be long (ie. it won't land
> for v4.19), until it looks good enough.

Rob, would you respin that in your tester now all the missing dependencies have
hit Linus's master tree again please ?

--
Robert
