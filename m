Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934667AbeDXNhl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:37:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52758 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934236AbeDXNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:37:33 -0400
X-Google-Smtp-Source: AIpwx49/rV4FO5aUmxKqXqK/z/1VqOx8+PWv5orSiD0yoJk+g05/mQxw+tVuEpAaHhldKedwh9zQwA==
MIME-Version: 1.0
In-Reply-To: <20180424133425.24291-4-jagan@amarulasolutions.com>
References: <20180424133425.24291-1-jagan@amarulasolutions.com> <20180424133425.24291-4-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 24 Apr 2018 21:37:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v67oJ7SE3P0_gmhL+Ggg5HVqQWvgBx0nyDzL82UuGAAESg@mail.gmail.com>
Message-ID: <CAGb2v67oJ7SE3P0_gmhL+Ggg5HVqQWvgBx0nyDzL82UuGAAESg@mail.gmail.com>
Subject: Re: [RFC 03/13] bindings: display: Add compatible for A64 DE2 pipeline
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 9:34 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Allwinner A64 has DE2 pipeline similar to other Allwinner
> SOC's like A83T, H3/H5.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +

All the device tree binding patches can be merged into one.

ChenYu
