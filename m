Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F19C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F8020866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F8020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJPUXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:23:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43950 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPUXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:23:09 -0400
Received: from wd0405.dip.tu-dresden.de ([141.76.109.149] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gCOWZ-0004Xb-IS; Tue, 16 Oct 2018 14:32:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: dts: rockchip: add rk3399 SPI DMAs
Date:   Tue, 16 Oct 2018 14:32:34 +0200
Message-ID: <2907390.NKaBHyzm1c@phil>
In-Reply-To: <20181010090038.20834-4-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk> <20181010090038.20834-4-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Oktober 2018, 11:00:34 CEST schrieb Emil Renner Berthing:
> Add spi dma channels as specified by the rk3399 TRM.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

applied for 4.21 with Enric's test-tag


Thanks
Heiko


