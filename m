Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3AE21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeLXGBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 01:01:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37622 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLXGBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 01:01:22 -0500
Received: from [46.183.103.8] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gbJIc-0002rO-HS; Mon, 24 Dec 2018 07:01:10 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add rk3328 ACODEC node
Date:   Mon, 24 Dec 2018 07:01:09 +0100
Message-ID: <2940538.FSBKZpFrSm@phil>
In-Reply-To: <20181223100530.12892-1-katsuhiro@katsuster.net>
References: <20181223100530.12892-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 23. Dezember 2018, 11:05:30 CET schrieb Katsuhiro Suzuki:
> This patch adds audio codec (ACODEC) node that converts to analog
> audio signal from I2S for rk3328.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

I've moved the rockchip,grf below the clocks properties
and applied the result for 4.22.

Thanks for improving the rk3328
Heiko



