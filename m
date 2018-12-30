Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F91BC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7372075D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeL3OEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 09:04:00 -0500
Received: from gloria.sntech.de ([185.11.138.130]:42720 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeL3OEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 09:04:00 -0500
Received: from [46.183.103.8] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gdbgv-00038W-C4; Sun, 30 Dec 2018 15:03:45 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/7] ARM: dts: rockchip: rk3066: add HCLK_HDMI to pmu node
Date:   Sun, 30 Dec 2018 15:03:43 +0100
Message-ID: <1546188525.f5QxLQzqUk@phil>
In-Reply-To: <20181229133318.18128-2-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com> <20181229133318.18128-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 29. Dezember 2018, 14:33:12 CET schrieb Johan Jonker:
> A MK808 TV stick with rk3066 processor
> boots normal with logo and console,
> but after booting the monitor remains black.
> This patch fixes a vblank wait time out
> by adding HCLK_HDMI to the pmu node.
> The HCLK_HDMI clock is now part of the logic
> that enables the RK3066_PD_VIO power domain.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 4.22

Thanks
Heiko


