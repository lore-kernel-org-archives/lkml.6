Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeDRCx2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 22:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753580AbeDRCx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 22:53:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A67721745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Wed, 18 Apr 2018 10:52:53 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v4] ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings
 from panel-simple
Message-ID: <20180418025251.GO25429@dragon>
References: <20180326080554.11559-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326080554.11559-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 01:35:53PM +0530, Jagan Teki wrote:
> Switch to use koe_tx31d200vm0baa LVDS timings from
> panel-simple instead hard coding the same in dts.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks.
