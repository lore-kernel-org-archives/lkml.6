Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeBEIkV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeBEIkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:40:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E152E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 16:39:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aapo Vienamo <aapo@tuxera.com>
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Ilya Ledvich <ilya@compulab.co.il>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet
Message-ID: <20180205083954.GU31354@dragon>
References: <20180131143407.8324-1-aapo@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131143407.8324-1-aapo@tuxera.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 02:34:07PM +0000, Aapo Vienamo wrote:
> The missing last digit of the CONFIG values is added. Looks like a typo
> of some sort when comparing to the downstream dt. This fixes
> intermittent behavior behaviour of the ethernet controllers.
> 
> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>

Applied, thanks.
