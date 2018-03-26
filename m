Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeCZWYf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:24:35 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44565 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeCZWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:32 -0400
X-Google-Smtp-Source: AIpwx4/5Id6MXkza8QajaTfxn46NvJNokQs5CEpJ66kQCTyE1byqmazU2dyeE6Y4f5xoFNIVTbvxZg==
Date: Mon, 26 Mar 2018 17:24:30 -0500
From: Rob Herring <robh@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] drm/panel: add panel CDTech S070_WV95_CT16 to
 panel-simple
Message-ID: <20180326222430.jysohrvgcmlsdclj@rob-hp-laptop>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-2-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521662593-25468-2-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 09:03:08PM +0100, Giulio Benetti wrote:
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../display/panel/cdtech,s070wv95-ct16.txt         |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
> new file mode 100644
> index 0000000..b00d6c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
> @@ -0,0 +1,7 @@
> +CDTech(H.K.) Electronics Limited 7" 800x480 color TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "cdtech,s070wv95-ct16"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

Please be specific as to what properties apply. In particular, are you 
not describing the power supply and it has multiple supplies or the 
panel has a single supply?

Rob
