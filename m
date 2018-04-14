Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeDNKaz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 06:30:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32794 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeDNKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 06:30:53 -0400
X-Google-Smtp-Source: AIpwx4/eNzv/5OXSsfO6YgkyqFIsx6iJjB8YZkXEkL1lZrTSnZ1nlcMTC8xsqiiAfnCMm01pWhw4VQ==
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBOSXu=+jQpsdnykioDGsp=VphSnzQdDDs_hh3Y1FPKyg@mail.gmail.com>
References: <20180316175354.21437-1-icenowy@aosc.io> <20180316175354.21437-4-icenowy@aosc.io>
 <CAMty3ZBOSXu=+jQpsdnykioDGsp=VphSnzQdDDs_hh3Y1FPKyg@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 14 Apr 2018 18:30:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v64-sWsFfHThVrcE5ivrf6kZSZa_tkB_GtC=Z+1TLpWV_Q@mail.gmail.com>
Message-ID: <CAGb2v64-sWsFfHThVrcE5ivrf6kZSZa_tkB_GtC=Z+1TLpWV_Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] bus: add bus driver for accessing Allwinner A64 DE2
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 6:25 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> On Fri, Mar 16, 2018 at 11:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> The "Display Engine 2.0" (usually called DE2) on the Allwinner A64 SoC
>> is different from the ones on other Allwinner SoCs. It requires a SRAM
>> region to be claimed, otherwise all DE2 subblocks won't be accessible.
>>
>> Add a bus driver for the Allwinner A64 DE2 part which claims the SRAM
>> region when probing.
>
> Along with this bus driver, we also need
> drivers/gpu/drm/sun4i/sun4i_drv.c which can usually drive the
> pipelines like mixer0 and 1 are the cases for A64?

I imagine that's the next part to be sent out, after the hardware
representation in the device tree has been decided on.

ChenYu
