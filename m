Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCWRGk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:06:40 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:42618 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeCWRGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:06:37 -0400
X-Google-Smtp-Source: AG47ELvXNJvLh9u4hIk9fk/UfBx18MhjXOUe02LqAJtUP+O8UQ4+bfxdLNzERLRwDywhL+zqB6LCkEyuSzkW7LTTbjc=
MIME-Version: 1.0
In-Reply-To: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
From: Jagan Teki <jagannadh.teki@gmail.com>
Date: Fri, 23 Mar 2018 22:36:35 +0530
Message-ID: <CAD6G_RSfiPC2qPjFFukqx6ihzS=_qBOdsP1KnWTP8BJ9Zsekew@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] drm/sun4i: Allwinner MIPI-DSI support
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Mar 6, 2018 at 7:25 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Hi,
>
> Here is an preliminary version of the MIPI-DSI support for the Allwinner
> SoCs.
>
> This controller can be found on a number of recent SoCs, such as the
> A31, A33 or the A64.
>
> Given the sparse documentation, there's a number of obscure areas, but
> the current implementation has been tested with a 4-lanes DSI panel on
> an A33.
>
> The support is a bit rough around the edges at the time, and some artifacts
> are still shown on the screen for some reasons. Wider testing with
> different display will hopefully nail those down.
>
> Let me know what you think,
> Maxime
>
> Changes from v2:
>   - Added a ports node under the DSI node
>   - Changed the huarui panel driver to an ili9881c driver
>   - Changed the panel vendor to bananapi
>   - Made the init table static in the panel driver
>   - Dropped the huarui vendor patch for the DT doc.
>
> Changes from v1:
>   - Rebased on 4.16-rc1
>   - Constified a few function arguments and structures
>   - Reworked the DT binding example a bit
>   - Reworked the panel driver to check for DSI return codes, and use DCS
>     helpers when possible
>
> Maxime Ripard (7):
>   drm/sun4i: tcon: Add TRI finish interrupt for vblank
>   dt-bindings: display: Add Allwinner MIPI-DSI bindings
>   drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
>   dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
>   drm/panel: Add Ilitek ILI9881c panel driver
>   arm: dts: sun8i: a33: Add the DSI-related nodes
>   [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

Any dependencies for this series on linux-next? it is not applying directly.

Jagan.
