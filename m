Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC271C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D93420020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D93420020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeFTUXh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:23:37 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:44208 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933085AbeFTUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:23:36 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d20 with ME
        id 18Pb1y00941oiFu038Pb3f; Wed, 20 Jun 2018 22:23:35 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 20 Jun 2018 22:23:35 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: pxa: add the missing AC97 clocks
References: <20180603201539.15704-1-robert.jarzmik@free.fr>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 20 Jun 2018 22:23:35 +0200
In-Reply-To: <20180603201539.15704-1-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Sun, 3 Jun 2018 22:15:39 +0200")
Message-ID: <874lhxp5q0.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The AC97 bit clock is added as the pxa internally generated 13MHz
> clock. This is a consequence of the new ac97 framework.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/devices.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
Queued to pxa/for-next.

--
Robert
