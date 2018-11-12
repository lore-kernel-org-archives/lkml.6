Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1616E20815
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1616E20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbeKMB2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:28:41 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49088 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeKMB2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:28:40 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gMEEk-0005Hl-Me; Mon, 12 Nov 2018 16:34:50 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2) support
Date:   Mon, 12 Nov 2018 16:34:50 +0100
Message-ID: <61693687.BtxviolxTZ@phil>
In-Reply-To: <20180812142317.19991-1-ctatlor97@gmail.com>
References: <20180812142317.19991-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Craig,

Am Sonntag, 12. August 2018, 16:23:12 CET schrieb Craig Tatlor:
> Initial device tree support for Qualcomm SDM630 SoC and
> Sony Pioneer (Xperia XA2).
> 
> SDM630 is based off of the SDM660 soc and all SDM660 specific drivers are
> compatible with it. SDM660 is also based off of MSM8998 so it uses some
> of its drivers aswell.
> 
> The device tree is based on the CAF 4.4 kernel tree.
> 
> The device can be booted into the initrd with a shell over UART.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

With I think core drivers like clk, pinctrl merged in 4.20, do you
plan on respinning the devicetree support or in general continue
working on sdm630/sdm660?

Or do you have some git tree available somewhere, were I can follow
along? I do have interest in supporting a sdm630 phone of my own
but still don't want to duplicate work :-)


Thanks
Heiko



