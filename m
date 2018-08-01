Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F888C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B758F2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B758F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbeHANm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:42:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33330 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbeHANm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:42:58 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fkpkf-0004yc-Sk; Wed, 01 Aug 2018 13:57:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     djw@t-chip.com.cn
Cc:     linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add support for ROC-RK3399-PC board
Date:   Wed, 01 Aug 2018 13:57:12 +0200
Message-ID: <3845549.84TLR0FYli@phil>
In-Reply-To: <1532916721-24117-1-git-send-email-djw@t-chip.com.cn>
References: <1532916721-24117-1-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 30. Juli 2018, 04:12:01 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> ROC-RK3399-PC is a power efficient 4GB LPDDR4 single board
> computer with USB 3.0 and Gigabit Ethernet in a form factor
> compatible with the Raspberry Pi. It is based on the Rockchip
> RK3399 SoC, powered by the Type-C port.
> 
> The devicetree currently supports peripherals of:
> 
> - Ethernet
> - HDMI
> - SD Card
> - UART2 debug
> - Type-C
> - eMMC
> 
> USB3 in Type-C port currently only works with normal orientation,
> not flip one.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

applied with Rob's review-tag.

Might still make it into 4.19 but also may have to wait for 4.20


Heiko


