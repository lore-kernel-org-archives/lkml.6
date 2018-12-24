Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6122CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8D72173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeLXHQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:16:15 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37868 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbeLXHQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:16:14 -0500
Received: from [46.183.103.8] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gbKTB-00033o-3s; Mon, 24 Dec 2018 08:16:09 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable analog audio node for rock64
Date:   Mon, 24 Dec 2018 08:16:08 +0100
Message-ID: <16987084.rf60fZEaYD@phil>
In-Reply-To: <20181223101026.12998-1-katsuhiro@katsuster.net>
References: <20181223101026.12998-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 23. Dezember 2018, 11:10:26 CET schrieb Katsuhiro Suzuki:
> The Rock64 boards has analog audio jack on it. RK3328 can output
> analog audio signal using I2S1 and ACODEC core.
> 
> This patch adds sound node for analog audio for Rock64.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

I've put a patch collecting the sound-dai-cells in rk3328.dtsi
before this one, dropped the sound-dai-cells from here and
applied the patch for 4.22.

Thanks
Heiko


