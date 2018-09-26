Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F8EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36469214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36469214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIZRvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:51:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38176 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeIZRvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:51:36 -0400
Received: from wd0156.dip.tu-dresden.de ([141.76.108.156] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g589e-00031B-Fv; Wed, 26 Sep 2018 13:38:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable SPI NOR flash on Rock64
Date:   Wed, 26 Sep 2018 13:38:53 +0200
Message-ID: <2872521.VFYVRVU0oA@phil>
In-Reply-To: <20180926045357.20722-1-wens@csie.org>
References: <20180926045357.20722-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. September 2018, 06:53:57 CEST schrieb Chen-Yu Tsai:
> The Pine64 Rock64 board comes with a GigaDevice GD25Q128CSIG
> or GD25Q127CSIG chip, which is a 128 Mbit SPI NOR flash chip
> that supports the JEDEC read-ID command.
> 
> This patch enables the SPI controller and adds a device node
> for the flash chip using the generic "jedec,spi-nor" comaptible.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

applied for 4.20

Thanks
Heiko


