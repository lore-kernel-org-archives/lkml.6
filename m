Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E3EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0797A20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0797A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeLKTL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:11:27 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46568 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLKTLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:11:25 -0500
Received: from p5b127a5a.dip0.t-ipconnect.de ([91.18.122.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gWnR4-0007xb-Da; Tue, 11 Dec 2018 20:11:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh@kernel.org, ezequiel@collabora.com, xuwei5@hisilicon.com,
        michal.simek@xilinx.com, pavel@ucw.cz, andy.gross@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        koen.kooi@linaro.org, nicolas.dechesne@linaro.org
Subject: Re: [PATCH v3 1/7] arm64: dts: rockchip: ficus: Add on-board LED support
Date:   Tue, 11 Dec 2018 20:11:13 +0100
Message-ID: <44132232.o28PC2y76u@phil>
In-Reply-To: <20181029094245.7886-2-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org> <20181029094245.7886-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 29. Oktober 2018, 10:42:39 CET schrieb Manivannan Sadhasivam:
> Add on-board LED support for Ficus board based on the following
> standard used by other 96Boards:
> 
> red:user1  default-trigger: heartbeat
> red:user2  default-trigger: mmc0/disk-activity (onboard-storage)
> red:user3  default-trigger: mmc1 (SD-card)
> red:user4  default-trigger: none, panic-indicator
> red:wlan   default-trigger: phy0tx
> red:bt     default-trigger: hci0-power
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

applied for 4.21

Thanks
Heiko


