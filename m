Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD8CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2CE2195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfBQL0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 06:26:10 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49626 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfBQL0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 06:26:09 -0500
Received: from p5b127a91.dip0.t-ipconnect.de ([91.18.122.145] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gvKaD-0001k9-1P; Sun, 17 Feb 2019 12:26:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: rk3188-bqedison2qc: remove cap-mmc-highspeed from mmc1 node
Date:   Sun, 17 Feb 2019 12:26:04 +0100
Message-ID: <4226652.OplgTpc3Hz@phil>
In-Reply-To: <20190216102545.1809-1-jbx6244@gmail.com>
References: <20190216102545.1809-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 16. Februar 2019, 11:25:45 CET schrieb Johan Jonker:
> The mmc1 pins are used for SDIO with a wifi chip.
> The function mmc_sdio_switch_hs() only checks for MMC_CAP_SD_HIGHSPEED and
> not for MMC_CAP_MMC_HIGHSPEED, so cap-mmc-highspeed can be removed.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.1

Thanks
Heiko


