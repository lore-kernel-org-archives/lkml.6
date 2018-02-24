Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeBXJU3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 04:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbeBXJU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 04:20:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86B121796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Sat, 24 Feb 2018 17:20:12 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Message-ID: <20180224092011.GR3217@dragon>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
 <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 04:02:49PM +0800, Anson Huang wrote:
> This patch adds i.MX7 thermal sensor support, most
> of the i.MX7 thermal sensor functions are same with
> i.MX6 except the registers offset/layout, so we move
> those registers offset/layout definitions to soc data
> structure.
> 
> i.MX7 uses single calibration data @25C, the calibration
> data is located at OCOTP offset 0x4F0, bit[17:9], the
> formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
