Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbeCGDyV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 22:54:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:19701 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932313AbeCGDyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 22:54:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,434,1515484800";
   d="scan'208";a="22357710"
Date: Wed, 7 Mar 2018 09:28:12 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] MAINTAINERS: Add linux/of_*.h headers to appropriate
 subsystems
Message-ID: <20180307035812.GU15443@localhost>
References: <20180306151334.28720-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306151334.28720-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:13:34AM -0600, Rob Herring wrote:
> The DeviceTree support code for specific subsystems are maintained by
> the respective subsystem maintainers. However, only the DT
> maintainers are listed for most of the linux/of_*.h headers. Fix this
> and add the headers to the appropriate subsystem maintainer.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93a12af4f180..248f4266c6bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4333,6 +4333,7 @@ Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
>  S:	Maintained
>  F:	drivers/dma/
>  F:	include/linux/dmaengine.h
> +F:	include/linux/of_dma.h
>  F:	Documentation/devicetree/bindings/dma/
>  F:	Documentation/driver-api/dmaengine/
>  T:	git git://git.infradead.org/users/vkoul/slave-dma.git

This:
Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
