Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759513AbeD1CfA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 22:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759307AbeD1Ce7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 22:34:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE59521923
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Sat, 28 Apr 2018 10:34:46 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: jan.tuerk@emtrion.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add basic support for emtrion emCON-MX6 modules
Message-ID: <20180428023445.GA3693@dragon>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427132445.3458-1-jan.tuerk@emtrion.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 03:24:35PM +0200, jan.tuerk@emtrion.com wrote:
> From: Jan Tuerk <jan.tuerk@emtrion.com>
> 
> Changes for v4:
>   - re-arrange the Patch-series to match the DT-submitting-patches
>   - Additional patch for the Documentation of the new DT-bindings
> 
> [PATCH v4 1/7] dt-bindings: display: Document the EDT et* displays in one file.
>   - no change (re-arranged 3/6 => 1/7)
> 
> [PATCH v4 2/7] drm/panel: Add support for the EDT ETM0700G0BDH6
>   - no change (re-arranged 1/6 => 2/7)
> 
> [PATCH v4 3/7] drm/panel: Add support for the EDT ETM0700G0EDH6
>   - no change (re-arranged 2/6 => 3/7)

Please split the series into two, DRM driver (above) and platform part
(below), to avoid posting one part over and over again with zero
changes, but only because the other part needs update.

Shawn

> 
> [PATCH v4 4/7] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
>   - no change
> 
> [PATCH v4 5/7] dt-bindings: arm: Document emtrion emCON-MX6 bindings
>   - separate patch for the emtrion emCON-MX6 DT-bindings
> 
> [PATCH v4 6/7] ARM: dts: Add support for emtrion emCON-MX6 series
>   - alphabetically sort the DT
>   - moved duplicated Avari baseboard code into separate file.
> 
> [PATCH v4 7/7] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
>   - unchaged
