Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C4FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2358322360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2358322360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeKNDBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:01:09 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:55633 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeKNDBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:01:09 -0500
Received: from belgarion ([90.89.234.36])
        by mwinf5d14 with ME
        id zV291y00Y0nnJME03V2AYd; Tue, 13 Nov 2018 18:02:11 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Tue, 13 Nov 2018 18:02:11 +0100
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 17/18] USB: phy-mv-usb: use phy-pxa-usb
References: <20181112032027.653931-1-lkundrak@v3.sk>
        <20181112032027.653931-18-lkundrak@v3.sk>
X-URL:  http://belgarath.falguerolles.org/
Date:   Tue, 13 Nov 2018 18:02:09 +0100
In-Reply-To: <20181112032027.653931-18-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Mon, 12 Nov 2018 04:20:26 +0100")
Message-ID: <87tvkkkj1q.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> Use a proper PHY driver, instead of hooks to a board support package.
Hi Lubomir,

This specific patch caught my attention, because of its title : I don't see what
phy-pxa-usb stands for, is it a typo ? I don't think anybody implemented so far
a proper phy support for pxa based boards (pxa27x actually), hence my question.

Cheers.

--
Robert
