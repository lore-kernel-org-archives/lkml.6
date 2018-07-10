Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21620C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB8F20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB8F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeGJNDU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:03:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34654 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752652AbeGJNDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:03:19 -0400
Received: from wd0417.dip.tu-dresden.de ([141.76.109.161] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fcsIW-0002LI-IC; Tue, 10 Jul 2018 15:03:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        kernel@collabora.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: dwc3: rockchip: Fix PHY documentation links.
Date:   Tue, 10 Jul 2018 15:03:14 +0200
Message-ID: <1651148.X0ZVfyzq5n@phil>
In-Reply-To: <20180710125848.15915-1-enric.balletbo@collabora.com>
References: <20180710125848.15915-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. Juli 2018, 14:58:48 CEST schrieb Enric Balletbo i Serra:
> Commit 34962fb8070c ("docs: Fix more broken references") replaced the
> broken reference to rockchip,dwc3-usb-phy.txt binding for the Qualcomm
> DWC3 binding (qcom-dwc3-usb-phy.txt). That's wrong, so replace that
> reference for the correct ones.
> 
> Fixes: 34962fb8070c ("docs: Fix more broken references")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


