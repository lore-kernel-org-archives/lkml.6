Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E73C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D28E206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D28E206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeIJSBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:01:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43744 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeIJSBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:01:50 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fzLuq-0003Sk-Fp; Mon, 10 Sep 2018 15:07:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix vcc_host1_5v pin assign
Date:   Mon, 10 Sep 2018 15:07:43 +0200
Message-ID: <2254080.m30pKOgRkt@phil>
In-Reply-To: <20180906153947.19495-1-katsuhiro@katsuster.net>
References: <20180906153947.19495-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 6. September 2018, 17:39:47 CEST schrieb Katsuhiro Suzuki:
> This patch fixes pin assign of vcc_host1_5v. This regulator is
> controlled by USB20_HOST_DRV signal.
> 
> ROCK64 schematic says that GPIO0_A2 pin is used as USB20_HOST_DRV.
> GPIO0_D3 pin is for SPDIF_TX_M0.
> 
> ROCK64 schematic:
> http://files.pine64.org/doc/rock64/ROCK64_Schematic_v2.0_20171019.pdf
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 4.20 after adapting the subject to also list the actual board
this affects :-) .


Thanks
Heiko


