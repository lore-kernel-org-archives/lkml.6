Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6087FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAA52084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfALVhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:37:35 -0500
Received: from gloria.sntech.de ([185.11.138.130]:42512 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfALVhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:37:35 -0500
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1giQxr-0007Er-1G; Sat, 12 Jan 2019 22:37:11 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Pragnesh_Patel@mentor.com
Cc:     Akash Gajjar <Akash_Gajjar@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, Levin Du <djw@t-chip.com.cn>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liang Chen <cl@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Date:   Sat, 12 Jan 2019 22:37:10 +0100
Message-ID: <1646372.YqHRDYLcbR@phil>
In-Reply-To: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
References: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 6. Januar 2019, 05:40:10 CET schrieb Pragnesh_Patel@mentor.com:
> From: Akash Gajjar <Akash_Gajjar@mentor.com>
> 
> ROCK Pi 4 is RK3399 based SBC from radxa.com. board has a 1G/2G/4G lpddr4, CSI,
> DSI, HDMI, OTG, USB 2.0, USB 3.0, 10/100/1000 RGMII Ethernet Phy, es8316 codec,
> POE, WIFI (for Model B only), PCIE M.2 support on board.
> 
> This patch enables
> - HDMI Display
> - Console
> - MMC, EMMC
> - USB 2.0, USB-3.0
> - Ethernet
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> Signed-off-by: Pragnesh Patel <Pragnesh_Patel@mentor.com>

applied for 5.1

Thanks
Heiko


