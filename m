Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D952C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE5B21581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE5B21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeHONXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:23:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57310 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeHONXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:23:02 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fpt5G-0003dp-3F; Wed, 15 Aug 2018 12:31:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] phy: rockchip-inno-usb2: fix misspelling and kernel-doc documentation.
Date:   Wed, 15 Aug 2018 12:31:21 +0200
Message-ID: <2908229.jFki8unlfB@phil>
In-Reply-To: <20180815095934.11205-2-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com> <20180815095934.11205-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. August 2018, 11:59:31 CEST schrieb Enric Balletbo i Serra:
> Fix the typo flase -> false and clean up the kernel-doc documentation in
> phy-rockchip-inno.usb2.c and fix the following warnings when documentation
> is built.
> 
>   :58: warning: missing initial short description
>   :69: warning: cannot understand function prototype: 'enum usb_chg_state '
>   :97: warning: missing initial short description
>   :136: warning: cannot understand function prototype: 'struct rockchip_usb2phy_port_cfg '
>   :157: warning: cannot understand function prototype: 'struct rockchip_usb2phy_cfg '
>   :163: warning: Function parameter or member 'port_cfgs' not described in 'rockchip_usb2phy_cfg'
>   :187: warning: cannot understand function prototype: 'struct rockchip_usb2phy_port '
>   :204: warning: Function parameter or member 'port_cfg' not described in 'rockchip_usb2phy_port'
>   :207: warning: missing initial short description
>   :234: warning: Function parameter or member 'dev' not described in 'rockchip_usb2phy'
>   :234: warning: Function parameter or member 'clk480m_hw' not described in 'rockchip_usb2phy'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


