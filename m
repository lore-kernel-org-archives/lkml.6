Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7D42064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7D42064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeGDKIX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:08:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50218 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932655AbeGDKIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:08:22 -0400
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1faehs-0006jx-F6; Wed, 04 Jul 2018 12:08:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 0/4] clk: rockchip: support clock controller for px30 SoC
Date:   Wed, 04 Jul 2018 12:08:15 +0200
Message-ID: <19643053.9AiPb2dtV0@phil>
In-Reply-To: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Freitag, 15. Juni 2018, 04:16:47 CEST schrieb Elaine Zhang:
> Change in V3:
> [PATCH v3 1/4]: Correct description
> [PATCH v3 2/4]: Use an SPDX tag instead.
> [PATCH v3 3/4]: Use an SPDX tag instead,
> 		parent_rate might overflow and fix it.
> 		fix up the checkpatch warning.
> 		add more CMPOSITE_xxx_HALFdiv.
> 
> Change in V2:
> [PATCH v2 2/4]: modify the Author name
> [PATCH v2 3/4]: provide a bit more explanation for commit message
> 
> Elaine Zhang (4):
>   dt-bindings: add bindings for px30 clock controller
>   clk: rockchip: add dt-binding header for px30
>   clk: rockchip: add support for half divider
>   clk: rockchip: add clock controller for px30

I've applied the set for 4.19 but dropped the panic-notifier
dump function from the px30 clock driver.

Heiko


