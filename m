Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeC3HoE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:44:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56183 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeC3HoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:44:02 -0400
X-Google-Smtp-Source: AIpwx4/JvkjYJ6WOex/TPXaQTWKIuFh0lsBc4oz/qnmxer+9mvk9rpJO3ecW0xTSSso7/mw7XGYJKA==
MIME-Version: 1.0
In-Reply-To: <20180206044905.30508-10-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io> <20180206044905.30508-10-icenowy@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Mar 2018 15:43:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v67w6n=bawNaxfJfRi2+RrSRu6GeQG8=Oxh0YADM8AKnmg@mail.gmail.com>
Message-ID: <CAGb2v67w6n=bawNaxfJfRi2+RrSRu6GeQG8=Oxh0YADM8AKnmg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 09/10] ARM: sun8i: h3: fix ALL-H3-CC H3
 ver VDD-CPUX voltage
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 12:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The VDD-CPUX voltage of ALL-H3-CC H3 ver should be 1.2V, not the 3.3V
> currently defined in the device tree.
>
> Fix the voltage in the device tree.
>
> Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre Computer Board ALL-H3-CC H3 ver.")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
