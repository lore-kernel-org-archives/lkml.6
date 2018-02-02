Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeBBGwU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeBBGwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:52:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB4221748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 14:52:02 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH] ARM: dts: imx53: Add touchscreen reset line
Message-ID: <20180202065201.GA25699@dragon>
References: <20180115142452.31278-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115142452.31278-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 03:24:52PM +0100, Sebastian Reichel wrote:
> From: Martyn Welch <martyn.welch@collabora.co.uk>
> 
> Utilise new support in Atmel MaxTouch driver to drive the
> touchscreen controllers reset line correctly.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

s/imx53/imx53-ppd in subject.

I fixed it up and applied the patch.

Shawn
