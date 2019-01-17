Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95837C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA7120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfAQNAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:00:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57549 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfAQNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:00:25 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gk7HM-00060w-Pq; Thu, 17 Jan 2019 14:00:16 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gk7HH-000534-G2; Thu, 17 Jan 2019 14:00:11 +0100
Date:   Thu, 17 Jan 2019 14:00:11 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        eddie.huang@mediatek.com, Sascha Hauer <kernel@pengutronix.de>,
        srv_heupstream@mediatek.com, bibby.hsieh@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>, yingjoe.chen@mediatek.com,
        sj.huang@mediatek.com, Sean Paul <seanpaul@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Yan <andy.yan@rock-chips.com>, ck.hu@mediatek.com,
        Vincent Palatin <vpalatin@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Rahul Sharma <rahul.sharma@samsung.com>
Subject: Re: [PATCH] pwm: Add MediaTek MT8183 display PWM driver support
Message-ID: <20190117130011.lq6wxqpxzq6sc3yy@pengutronix.de>
References: <20190116075252.24124-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116075252.24124-1-jitao.shi@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:52:52PM +0800, Jitao Shi wrote:
> Use the mtk_pwm_data struction to define different registers
> and add MT8183 specific register operations, such as MT8183
> have commit register, needs to enable double buffer
> before writing register, and needs to select commit mode
> and use PWM_PERIOD/PWM_HIGH_WIDTH.

You forgot to add linux-pwm to the recipents.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
