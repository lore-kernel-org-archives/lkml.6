Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031640AbeBNVmp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:42:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35117 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031578AbeBNVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:42:42 -0500
X-Google-Smtp-Source: AH8x2270JqcXfth6KD1DaVJSGhkD84MmYPQlWEp5HCevWbDZS14ix4125TZgE7HPO5w3dERN73aEsbg23bzJoe3YSe4=
MIME-Version: 1.0
In-Reply-To: <20180214200906.31509-11-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net> <20180214200906.31509-11-jernej.skrabec@siol.net>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Wed, 14 Feb 2018 22:42:00 +0100
Message-ID: <CAOFm3uFkkydWBT9N72ax1oeJs=J2A_s-VbaAW1P5WQopBjw_tA@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] drm/sun4i: Implement A83T HDMI driver
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 9:09 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> A83T has DW HDMI IP block with a custom PHY similar to Synopsys gen2
> HDMI PHY.
>
> Only video output was tested, while HW also supports audio and CEC.
> Support for them will be added later.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

...

> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+

This should be

/* SPDX-License-Identifier: GPL-2.0+ /* in a .h per [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
