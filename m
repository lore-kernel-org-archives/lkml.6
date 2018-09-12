Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A8C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20962206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20962206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeILPo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:44:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49393 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeILPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:44:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ABEB9208D9; Wed, 12 Sep 2018 12:40:29 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 761FF206FF;
        Wed, 12 Sep 2018 12:40:19 +0200 (CEST)
Date:   Wed, 12 Sep 2018 12:40:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: sama5d4: add labels to soc dtsi for
 derivative boards
Message-ID: <20180912104019.GB2760@piout.net>
References: <1536327489-22005-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536327489-22005-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 16:38:09+0300, Eugen Hristev wrote:
> This adds labels to commonly used device-tree nodes so that derivative
> boards can avoid ahb/apb hierarchy.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> 
> Hello,
> 
> This was already done for SoC sama5d3 and sam9x5, in commit:
> "fc37204432d" ("ARM: dts: at91: add labels to soc dtsi for derivative boards")
> 
> This commit will do basically the same thing for sama5d4 SoC.
> 
> Based on top of at91-next branch of at91.git
> 
> Thanks.
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
