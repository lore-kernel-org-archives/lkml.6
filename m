Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE0BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A97D20665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfAJM0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:26:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54774 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfAJM0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:26:46 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ghZQ4-00032m-Ao; Thu, 10 Jan 2019 13:26:44 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        bleung@chromium.org, groeck@google.com,
        kieran.bingham@ideasonboard.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] phy: phy-rockchip-inno-usb2: drop reading the utmi-avalid property
Date:   Thu, 10 Jan 2019 13:26:43 +0100
Message-ID: <5125335.cuvu72hbmo@phil>
In-Reply-To: <20190109171415.9954-1-enric.balletbo@collabora.com>
References: <20190109171415.9954-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 18:14:15 CET schrieb Enric Balletbo i Serra:
> That property is no used in mainline and is not documented. The only
> board using that property is the rk33-99-evb-rev1 and -rev2 in the
> vendor kernel. The existence of a further -rev3 (which also looks way
> better cared for compared rev1+2) indicates that the older ones are
> probably some sort of preproduction models, where some wiring (on the soc
> or board) may have gone wrong.
> 
> It is also not clear why this is a hardware-description or a DT
> property, so, as noboby seems to care of this just drop reading that
> property.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


