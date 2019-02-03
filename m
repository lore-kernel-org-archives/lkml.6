Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E31C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708BA218FF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBCJBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:01:08 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53246 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfBCJBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:01:08 -0500
Received: from [164.15.244.47] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gqDe7-0001KD-Di; Sun, 03 Feb 2019 10:00:59 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Tony Xie <tony.xie@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: rv1108-elgin: Fix vcc5/6-supply representation
Date:   Sun, 03 Feb 2019 10:00:58 +0100
Message-ID: <59585681.DkdmuU3GWD@phil>
In-Reply-To: <20190131124710.30238-1-otavio@ossystems.com.br>
References: <20190131124710.30238-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 31. Januar 2019, 13:47:07 CET schrieb Otavio Salvador:
> On rv1108-elgin-r1 board the RK805 VCC5 and VCC6 supplies come from
> the BUCK2 regulator at 2.2V, so fix the representation in the
> device tree.
> 
> While at it, rename it from vdd_cam to vdd_buck2, which is a better
> name for the regulator label.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied all 3 for 5.1

Thanks
Heiko


