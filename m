Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FEDC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619420644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D619420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHTRk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:40:26 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43237 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHTRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:40:26 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id C9ED4E0F85;
        Mon, 20 Aug 2018 14:24:27 +0000 (UTC)
Message-ID: <6e2df3d919b85f48c22c653124b7c2b594cb2d28.camel@aosc.io>
Subject: Re: [PATCH] arm64: allwinner: dts: h6: fix Pine H64 MMC bus width
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 20 Aug 2018 22:24:20 +0800
In-Reply-To: <20180730082712.koiaej6dxjnnk6lb@flea>
References: <20180726044805.55888-1-icenowy@aosc.io>
         <20180730082712.koiaej6dxjnnk6lb@flea>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-07-30一的 10:27 +0200，Maxime Ripard写道：
> On Thu, Jul 26, 2018 at 12:48:05PM +0800, Icenowy Zheng wrote:
> > Currently the enabled MMC controllers on Pine H64 do not have bus-
> > width
> > set, which make them fall back to 1-bit mode and become quite slow.
> > 
> > Fix this by add the corresponding bus-width properties.
> > 
> > Fixes: ecbd611882a1 ("arm64: allwinner: h6: enable MMC0/2 on Pine
> > H64")
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> Applied, thanks!

BTW why didn't I see it in next-20180820?

It's 3 weeks later, and you didn't say that the patch is queued for
another version.

> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

