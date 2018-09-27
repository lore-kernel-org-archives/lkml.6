Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044D6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54C4216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54C4216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeI0Xr7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:47:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33137 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbeI0Xr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:47:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B038420795; Thu, 27 Sep 2018 19:28:37 +0200 (CEST)
Received: from localhost (unknown [91.116.141.28])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6B95F20730;
        Thu, 27 Sep 2018 19:28:37 +0200 (CEST)
Date:   Thu, 27 Sep 2018 19:28:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device
 trees
Message-ID: <20180927172837.ucxmqfhazt4xwfh2@flea>
References: <20180926132339.24737-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180926132339.24737-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 09:23:39PM +0800, Chen-Yu Tsai wrote:
> Bananapi released an updated revision of the H3/H5 based Bananapi M2+.
> Version 1.2 enables voltage control for the CPU's regulator by using
> a GPIO line to toggle a MOSFET that can change the effective resistance
> value in the regulator's feedback network.
> 
> This patch adds a common .dtsi file for this new revision, which
> includes the original common sunxi-bananapi-m2-plus.dtsi file, and
> adds the GPIO-controlled regulator and a cpu-supply reference. H3
> and H5 variant dts files are added as well.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
