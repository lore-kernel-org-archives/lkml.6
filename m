Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759171AbeD0UMh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:12:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39870 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758703AbeD0UMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:12:36 -0400
X-Google-Smtp-Source: AB8JxZqTzlPsJeGJDD6r5RkoNt2FGb45sTWSN4izI9uNetJq3twvlFwRGpa8PsyslET2XXr+MxHYCw==
Date: Fri, 27 Apr 2018 15:12:34 -0500
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 1/4] drm/panel: simple: Add support for Rocktech
 RK070ER9427 LCD panel
Message-ID: <20180427201234.hkaqkwa6zsj7tfda@rob-hp-laptop>
References: <20180427131040.28775-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427131040.28775-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 06:40:40PM +0530, Jagan Teki wrote:
> This adds support for the Rocktech Display Ltd. RK070ER9427
> 800(RGB)x480 TFT LCD panel, which can be supported by the
> simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - included drm drm panel maintainers
> 
>  .../display/panel/rocktech,rk070er9427.txt         | 25 ++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt

Reviewed-by: Rob Herring <robh@kernel.org>
