Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F484C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 22:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B6D2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA0WPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 17:15:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48670 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfA0WPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 17:15:49 -0500
Received: from p5b12725f.dip0.t-ipconnect.de ([91.18.114.95] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gnsiP-0000k9-1q; Sun, 27 Jan 2019 23:15:45 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dmitry Voytik <voytikd@gmail.com>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable usb-host regulators during boot
Date:   Sun, 27 Jan 2019 23:15:43 +0100
Message-ID: <2042016.tQT6YM4xNP@phil>
In-Reply-To: <20190122223848.6019-1-voytikd@gmail.com>
References: <20190122223848.6019-1-voytikd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. Januar 2019, 23:38:48 CET schrieb Dmitry Voytik:
> After commit ef05bcb60, boot from USB drives is broken.
> Fix this problem by enabling usb-host regulators during boot time.
> 
> Signed-off-by: Dmitry Voytik <voytikd@gmail.com>

added a fixes and cc-stable tag and applied as fix for 5.0

Thanks
Heiko


