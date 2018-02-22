Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeBVDVa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 22:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbeBVDV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 22:21:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB282178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 22 Feb 2018 11:21:19 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpc: de-register power domains only if
 initialized
Message-ID: <20180222032117.GC3217@dragon>
References: <20180107134905.15624-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180107134905.15624-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2018 at 02:49:05PM +0100, Stefan Agner wrote:
> If power domain information are missing in the device tree, no
> power domains get initialized. However, imx_gpc_remove tries to
> remove power domains always in the old DT binding case. Only
> remove power domains when imx_gpc_probe initialized them in
> first place.
> 
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
