Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD10C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686A32087F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfA0VIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:08:04 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48462 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfA0VID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:08:03 -0500
Received: from p5b12725f.dip0.t-ipconnect.de ([91.18.114.95] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gnreq-0000aK-GA; Sun, 27 Jan 2019 22:08:00 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     devicetree@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: fix rk3300-gru-bob graph_port warning
Date:   Sun, 27 Jan 2019 22:08:00 +0100
Message-ID: <4055651.A8C7SXy0L7@phil>
In-Reply-To: <20190126103730.3883-1-enric.balletbo@collabora.com>
References: <20190126103730.3883-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 26. Januar 2019, 11:37:28 CET schrieb Enric Balletbo i Serra:
> Ports are described by child 'port' nodes contained in the device node.
> 'ports' is optional and is used to group all 'port' nodes which is not
> the case here.
> 
> This patch fixes the following warning:
> 
> arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts:25.9-29.5: Warning (graph_port): /edp-panel/ports: graph port node name should be 'port'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I've squashed all 3 into one and applied the result as fix for 5.0

Thanks
Heiko


