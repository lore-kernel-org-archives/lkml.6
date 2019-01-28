Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BFFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6FB20856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfA1KR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:17:28 -0500
Received: from gloria.sntech.de ([185.11.138.130]:51650 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfA1KR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:17:27 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1go3yg-0002qk-9K; Mon, 28 Jan 2019 11:17:18 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Damian Kos <dkos@cadence.com>
Cc:     Chris Zhong <zyw@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: fix for mailbox read validation.
Date:   Mon, 28 Jan 2019 11:17:17 +0100
Message-ID: <4752187.AQatX9g1G3@phil>
In-Reply-To: <1542640463-18332-1-git-send-email-dkos@cadence.com>
References: <1542640463-18332-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 19. November 2018, 16:14:14 CET schrieb Damian Kos:
> This is basically the same fix as in
> commit fa68d4f8476b ("drm/rockchip: fix for mailbox read size")
> but for cdn_dp_mailbox_validate_receive function.
> 
> See patchwork.kernel.org/patch/10671981/ for details.
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>

forgot that patch in my inbox somehow ... applied to drm-misc-next now

Thanks
Heiko


