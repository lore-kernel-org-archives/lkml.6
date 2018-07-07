Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB86DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE3C21506
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE3C21506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbeGGTak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 15:30:40 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:30534 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753949AbeGGTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 15:30:38 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d73 with ME
        id 7vWS1y00E41oiFu03vWUCK; Sat, 07 Jul 2018 21:30:35 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 07 Jul 2018 21:30:35 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] clk: pxa: export 32kHz PLL
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
        <87d0w2gsa5.fsf@belgarion.home>
        <153091032623.143105.13689700534218065371@swboyd.mtv.corp.google.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 07 Jul 2018 21:30:25 +0200
Message-ID: <87d0vyg7xq.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <sboyd@kernel.org> writes:

> Quoting Robert Jarzmik (2018-07-04 22:34:10)
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> 
>> > This clock is especially used by the RTC driver, so export it so that
>> > devicetree users can use it.
>> >
>> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> > ---
>> > Since v2: fix missing parenthesis in clk-pxa25x.c and clk-pxa3xx.c
>> 
>> Hi Michael and Stephen,
>> 
>> Could you have a look please ?
>> 
>
> I'll apply patch 1, and leave patch 2 to someone else?
As there is a dependency of patch 2 on patch 1, and with the Reviewed-by
provided by Rob, I'd appreciate you take it as well. If not, I'll queue it up
for the next cycle in my pxa tree.

Cheers.

-- 
Robert
