Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934886AbeD0Ofz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:35:55 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41981 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932882AbeD0Ofw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:35:52 -0400
X-Google-Smtp-Source: AB8JxZqNQpkhgoeEPeMxI85p4NRLM5ZXn9xrnmwhEHfWZsnO41jD0N2bb2hO8W/1hBc28ECVUkQdmg==
Date: Fri, 27 Apr 2018 09:35:50 -0500
From: Rob Herring <robh@kernel.org>
To: jan.tuerk@emtrion.com
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/7] dt-bindings: display: Document the EDT et*
 displays in one file.
Message-ID: <20180427143550.yzc3rnunjeudevhi@rob-hp-laptop>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-2-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427132445.3458-2-jan.tuerk@emtrion.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 03:24:36PM +0200, jan.tuerk@emtrion.com wrote:
> From: Jan Tuerk <jan.tuerk@emtrion.com>
> 
> Document the Emerging Display Technology Corp. (EDT) using the
> simple-panel binding in one single file.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
> Changes for v4:
>   - re-arrange the Patch-series to match the DT-submitting-patches
>   - Additional patch for the Documentation of the new DT-bindings
>   - no change (re-arranged 3/6 => 1/7)
> 
>  .../bindings/display/panel/edt,et-series.txt       | 39 ++++++++++++++++++++++
>  .../bindings/display/panel/edt,et057090dhu.txt     |  7 ----
>  .../bindings/display/panel/edt,et070080dh6.txt     | 10 ------
>  .../bindings/display/panel/edt,etm0700g0dh6.txt    | 10 ------
>  4 files changed, 39 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt

Reviewed-by: Rob Herring <robh@kernel.org>
