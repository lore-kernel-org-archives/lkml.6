Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeDXQmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:42:10 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37554 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:42:08 -0400
X-Google-Smtp-Source: AIpwx49KzRTuNID/UhrHMBHRUHTmJMkS69cxzh3K3oQ9Uc/ZMcpZyYd8V/3kEkq6w8kehXAAyzRduQ==
Date: Tue, 24 Apr 2018 11:42:07 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: Re: [PATCH 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
Message-ID: <20180424164207.ay4ai6lbspgv6anw@rob-hp-laptop>
References: <20180419093225.614-1-wens@csie.org>
 <20180419093225.614-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419093225.614-5-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 05:32:23PM +0800, Chen-Yu Tsai wrote:
> This panel is marketed as Banana Pi 7" LCD display. On the back is
> a sticker denoting the model name S070WV20-CT16.
> 
> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
> However the panel only does 262k colors.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../display/panel/bananapi,s070wv20-ct16.txt  |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> new file mode 100644
> index 000000000000..2ec35ce36e9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> @@ -0,0 +1,7 @@
> +Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> +
> +Required properties:
> +- compatible: should be "bananapi,s070wv20-ct16"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

Does this panel have a power supply (or more than 1) or backlight? I 
can't know that by just refering to simple-panel.txt.
