Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34096C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5AC21725
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5AC21725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934892AbeF0P2N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:28:13 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:33306 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934844AbeF0P2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:06 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d42 with ME
        id 3rU41y00641oiFu03rU4ZR; Wed, 27 Jun 2018 17:28:05 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 27 Jun 2018 17:28:05 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: pxa: fix the rtc controller
References: <20180627150150.23951-1-robert.jarzmik@free.fr>
        <20180627150150.23951-2-robert.jarzmik@free.fr>
        <20180627171627.592849b5@windsurf.home>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 27 Jun 2018 17:28:04 +0200
In-Reply-To: <20180627171627.592849b5@windsurf.home> (Thomas Petazzoni's
        message of "Wed, 27 Jun 2018 17:16:27 +0200")
Message-ID: <87muvgl057.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Petazzoni <thomas.petazzoni@bootlin.com> writes:

> Hello,
>> +		rtc@40900000 {
>> +			clocks = <&clks CLK_OSC32k768>>;
>
> Double closing bracket, doesn't look good.

Rrrr you're right ... I swear this patchset is cursed ...

Thanks for spotting that, I'll send a v4.

Cheers.

-- 
Robert
