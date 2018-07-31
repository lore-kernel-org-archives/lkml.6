Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D81C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A6D208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A6D208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeGaOPF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:15:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36429 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731988AbeGaOPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:15:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE44D20789; Tue, 31 Jul 2018 14:34:55 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id A0592206A6;
        Tue, 31 Jul 2018 14:34:55 +0200 (CEST)
Date:   Tue, 31 Jul 2018 14:34:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, sean@mess.org,
        p.zabel@pengutronix.de, andi.shyti@samsung.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 0/4] IR support for A83T
Message-ID: <20180731123452.74jyxc4q3ewig35z@flea>
References: <20180731092258.2279-1-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180731092258.2279-1-embed3d@gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:22:54AM +0200, Philipp Rossak wrote:
> This patch series adds support for the sunxi A83T ir module and enhances 
> the sunxi-ir driver. Right now the base clock frequency for the ir driver
> is a hard coded define and is set to 8 MHz.
> This works for the most common ir receivers. On the Sinovoip Bananapi M3 
> the ir receiver needs, a 3 MHz base clock frequency to work without
> problems with this driver.
> 
> This patch series adds support for an optinal property that makes it able
> to override the default base clock frequency and enables the ir interface 
> on the a83t and the Bananapi M3.

Once the minor comment on patch 2 has been fixed,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
