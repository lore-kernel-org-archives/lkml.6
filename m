Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1532B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1532B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeGYLSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:18:10 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45572 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbeGYLSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:18:10 -0400
Received: from 095-097-149-005.static.chello.nl ([95.97.149.5] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fiGhG-0002HW-Oc; Wed, 25 Jul 2018 12:07:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Mark Yao <markyao0591@gmail.com>, devicetree@vger.kernel.org,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Brian Norris <briannorris@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-rockchip@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Caesar Wang <wxt@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove deprecated Type-C PHY properties on rk3399
Date:   Wed, 25 Jul 2018 12:07:05 +0200
Message-ID: <3045142.hvSNBlnxT0@phil>
In-Reply-To: <20180709205754.29132-1-enric.balletbo@collabora.com>
References: <20180709205754.29132-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Juli 2018, 22:57:54 CEST schrieb Enric Balletbo i Serra:
> Commit 0fbc47d9e426 ("phy: rockchip-typec: deprecate some DT properties
> for various register fields.") deprecates some Rockchip Type-C
> properties. As these are now not needed, remove from the device tree
> file.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied for 4.19

Thanks
Heiko


