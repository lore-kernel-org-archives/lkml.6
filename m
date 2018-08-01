Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19035C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6BE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6BE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbeHANcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:32:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33220 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbeHANcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:32:23 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fkpae-0004wi-SL; Wed, 01 Aug 2018 13:46:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] gpio: syscon: rockchip: add GRF GPIO support for rk3328
Date:   Wed, 01 Aug 2018 13:46:49 +0200
Message-ID: <4408660.D6TumT1hZf@phil>
In-Reply-To: <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn> <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Juli 2018, 07:59:19 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
> mute control, can also be used for general purpose. It is manipulated by
> the GRF_SOC_CON10 register in GRF. Aside from the GPIO_MUTE pin, the HDMI
> pins can also be set in the same way.
> 
> Currently this GRF GPIO controller only supports the mute pin. If needed
> in the future, the HDMI pins support can also be added.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

It looks like Linus (Torvalds) is doing an -rc8 this time [0] so we might
still be in time for 4.19 , depending on when this patch is going to be
applied ;-) .


Heiko


[0] https://lore.kernel.org/lkml/CA+55aFzHRaNMHxLCEa5Zke-1FgbQ4rtHf8-HOu0zBzo4Liz88A@mail.gmail.com/


