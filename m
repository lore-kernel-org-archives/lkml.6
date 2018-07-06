Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D4CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5F62400F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5F62400F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeGFIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:52:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38620 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeGFIwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:52:49 -0400
Received: from p5b127bca.dip0.t-ipconnect.de ([91.18.123.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fbMTi-0008Kl-QQ; Fri, 06 Jul 2018 10:52:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Huibin Hong <huibin.hong@rock-chips.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, sugar.zhang@rock-chips.com,
        david.wu@rock-chips.com, finley.xiao@rock-chips.com,
        robin.murphy@arm.com, william.wu@rock-chips.com,
        rocky.hao@rock-chips.com, klaus.goger@theobroma-systems.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: corrected uart1 clock-names for rk3328
Date:   Fri, 06 Jul 2018 10:52:33 +0200
Message-ID: <4047306.zuHpop0b3Q@phil>
In-Reply-To: <1530864237-14891-1-git-send-email-huibin.hong@rock-chips.com>
References: <1530864237-14891-1-git-send-email-huibin.hong@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huibin,

Am Freitag, 6. Juli 2018, 10:03:57 CEST schrieb Huibin Hong:
> Corrected the uart clock-names or the uart driver might fail.
> 
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>

thanks for catching that issue. I've added a Fixes-tag and a stable-cc
and applied the patch for 4.19


Thanks
Heiko



