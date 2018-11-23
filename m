Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1627EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5F220685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5F220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437026AbeKXB1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:27:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35503 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388198AbeKXB1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:27:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 63DDD20D29; Fri, 23 Nov 2018 15:42:34 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32DC520712;
        Fri, 23 Nov 2018 15:42:24 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 4/6] clk: mvebu: ap806: Fix clock name for the cluster
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
        <20180922181709.13007-5-gregory.clement@bootlin.com>
        <153980091588.5275.2414842812770832337@swboyd.mtv.corp.google.com>
Date:   Fri, 23 Nov 2018 15:42:24 +0100
In-Reply-To: <153980091588.5275.2414842812770832337@swboyd.mtv.corp.google.com>
        (Stephen Boyd's message of "Wed, 17 Oct 2018 11:28:35 -0700")
Message-ID: <87efbbq2i7.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On mer., oct. 17 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2018-09-22 11:17:07)
>> Actually, the clocks exposed for the cluster are not the CPU clocks, but
>> the PLL clock used as entry clock for the CPU clocks. The CPU clock will
>> be managed by a driver submitting in the following patches.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> Does this need a fixes tag?

It doesn't fix a regression so I don't thing it needs a fixes tag.

Gregory

>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
