Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9332C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E77206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfALURH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 15:17:07 -0500
Received: from gloria.sntech.de ([185.11.138.130]:42106 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfALURG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 15:17:06 -0500
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1giPiF-00070n-HS; Sat, 12 Jan 2019 21:16:59 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] ARM: dts: rv1108: Add support for rv1108-elgin-r1 board
Date:   Sat, 12 Jan 2019 21:16:58 +0100
Message-ID: <2576878.pKSbgTzd5o@phil>
In-Reply-To: <20190104014023.17973-4-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br> <20190104014023.17973-4-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. Januar 2019, 02:40:23 CET schrieb Otavio Salvador:
> rv1108-elgin-r1 board is based on Rockchip RV1108 SoC.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied all 4 patches (including the vendor-prefix) for 5.1

I've rearranged some minor properties in the board-dts to follow
alphabetical ordering (emmc and gmac).


Thanks
Heiko


