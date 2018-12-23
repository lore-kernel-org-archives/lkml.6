Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7AFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156C21920
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeLWQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:40:35 -0500
Received: from muru.com ([72.249.23.125]:59208 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbeLWQke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:40:34 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 264CB8119;
        Sun, 23 Dec 2018 16:40:38 +0000 (UTC)
Date:   Sun, 23 Dec 2018 08:40:30 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
Message-ID: <20181223164030.GQ6707@atomide.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181221110128.GO13248@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221110128.GO13248@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [181221 11:01]:
> On Tue, 18 Dec 2018, Christian Hohnstaedt wrote:
> 
> > These options apply to all regulators in this chip.
> > 
> > strict-supply-voltage:
> >   Set STRICT flag in CONFIG1
> > under-voltage-limit:
> >   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> > under-voltage-hysteresis:
> >   Select 200mV or 400mV UVLOHYS in CONFIG2
> > 
> > Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> > ---
> >  drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> 
> This needs a close review by Tony and any of the other OMAP guys.

Adding Keerthy to Cc, he's probably the best person to review these
changes.

Regards,

Tony
