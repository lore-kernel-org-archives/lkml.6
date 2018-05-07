Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEGGeC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeEGGd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:33:58 -0400
Date: Mon, 7 May 2018 14:33:36 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ian Ray <ian.ray@ge.com>, Ken Lin <ken.lin@advantech.com.tw>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] ARM: dts: imx: ba16: add "mfg" Q7 SPI-NOR partition
Message-ID: <20180507063335.GB21989@dragon>
References: <20180501155848.16354-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501155848.16354-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 05:58:48PM +0200, Sebastian Reichel wrote:
> From: Ken Lin <ken.lin@advantech.com.tw>
> 
> Add the 4th partiton named "mfg" with a block size 64K to store
> manufacturing data.
> 
> Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Applied, thanks.
