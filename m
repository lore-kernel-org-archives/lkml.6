Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF46C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CBB2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfACVG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:06:57 -0500
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:25317 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbfACVG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:06:56 -0500
Received: from belgarion ([90.89.234.36])
        by mwinf5d75 with ME
        id Kx6p1z0030nnJME03x6prY; Thu, 03 Jan 2019 22:06:52 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 03 Jan 2019 22:06:52 +0100
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Peng Hao <peng.hao2@zte.com.cn>, linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm/plat-pxa/ssp : unneeded to free devm_ allocated data
References: <1546060206-97556-1-git-send-email-peng.hao2@zte.com.cn>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 03 Jan 2019 22:06:48 +0100
In-Reply-To: <1546060206-97556-1-git-send-email-peng.hao2@zte.com.cn> (Peng
        Hao's message of "Sat, 29 Dec 2018 13:10:06 +0800")
Message-ID: <87tvipsb6f.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Hao <peng.hao2@zte.com.cn> writes:

> devm_ allocated data will be automatically freed. The free
> of devm_ allocated data is invalid.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Hi Peng Hao,

Thanks for the patch. I changed your title to fit my tree, ie. :
"ARM: pxa: ssp: unneeded to free devm_ allocated data"

If you have other patches please check what is the commit subject's prefix for
the file(s) you're touching.

Queued to pxa/fixes.

Cheers.

-- 
Robert
