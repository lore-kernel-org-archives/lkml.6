Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB5B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB5B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLKTjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:39:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46762 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLKTjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:39:21 -0500
Received: from p5b127a5a.dip0.t-ipconnect.de ([91.18.122.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gWnsF-00086u-4H; Tue, 11 Dec 2018 20:39:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: rockchip: Add internal timer support for rv1108
Date:   Tue, 11 Dec 2018 20:39:18 +0100
Message-ID: <5328135.xSjgCaBnB4@phil>
In-Reply-To: <20181126173506.24068-4-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br> <20181126173506.24068-4-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. November 2018, 18:35:06 CET schrieb Otavio Salvador:
> Add support for the internal timer peripheral on RV1108.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied for 4.21

Thanks
Heiko


