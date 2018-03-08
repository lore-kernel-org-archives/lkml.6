Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935233AbeCHIa5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755104AbeCHIa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:30:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E70206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 8 Mar 2018 16:30:15 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6: RDU2: Add RAVE SP device
Message-ID: <20180308083014.GT3217@dragon>
References: <20180301192007.29278-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301192007.29278-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:20:06AM -0800, Andrey Smirnov wrote:
> With MFD and watchdog drivers for RAVE SP device support added by
> 538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
> c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
> corresponding DT node for RDU2.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied both, thanks.
