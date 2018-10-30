Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE5AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A0720664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A0720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJaFaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:30:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57462 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbeJaFai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:30:38 -0400
Received: from ip5f5a8d7b.dynamic.kabel-deutschland.de ([95.90.141.123] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gHajg-0001bq-A7; Tue, 30 Oct 2018 21:35:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Use default brightness table for gru.
Date:   Tue, 30 Oct 2018 21:35:35 +0100
Message-ID: <3715364.6vahmuDdgq@phil>
In-Reply-To: <20181016141304.21984-1-enric.balletbo@collabora.com>
References: <20181016141304.21984-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. Oktober 2018, 16:13:04 CET schrieb Enric Balletbo i Serra:
> After commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye") the pwm_bl driver is able to calculate a default
> brightness table. The calculated table for this PWM will have more
> granularity and will be adjusted to change the brightness linearly to
> the human eye. Use that table instead of have a DT-defined table with
> less granularity.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Hi Heiko,
> 
> Note that the patch was only tested on a Samsung Chromebook Plus
> (kevin), will be very interesting if someone can test on other gru-based
> devices, like Bob, before apply this patch.
> 
> Best regards,
>  Enric

gave it a spin on Bob - works as expected - and applied for 4.21

Thanks
Heiko


