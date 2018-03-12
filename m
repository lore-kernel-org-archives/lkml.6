Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeCLHZC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751303AbeCLHZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:25:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE06E21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 12 Mar 2018 15:24:08 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
Message-ID: <20180312072406.GL3217@dragon>
References: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:58:19PM +0100, Martin Kaiser wrote:
> According to the i.MX25 reference manuals, each SSI has four FIFOs. All
> of those FIFOs can store up to 15 entries.
> 
> The fsl_ssi driver's internal default for the FIFO depth in 8. Set our
> non-default FIFO depth explicitly in the Device Tree.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
