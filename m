Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeDDMqc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:46:32 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34081 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeDDMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:46:28 -0400
X-Google-Smtp-Source: AIpwx48jru+neWqRwfgKpc9cUwQh//C5vzwQ/zzJ8s/hLy6MfV4cxtXIOQkH3yUJnqLHhVK74IaOnKe+cK0xGCRHAHo=
MIME-Version: 1.0
In-Reply-To: <20180403100652.41056-1-yixun.lan@amlogic.com>
References: <20180403100652.41056-1-yixun.lan@amlogic.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Apr 2018 14:46:27 +0200
Message-ID: <CAPDyKFpf=Mzryr6wijndKt4Hx48nSGSzyysqAABRGu8_vzGj6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: meson-axg: initial support for AXG SoC platform
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 April 2018 at 12:06, Yixun Lan <yixun.lan@amlogic.com> wrote:
>    The patches series try to enable basic eMMC support in the Meson-AXG platfrom.
>
>    Currently HS200 mode is tested with clock running at 166MHz, since
> not all boards are stable to running 200MHz (due to tuning phase error),
> we will further improve the tuning phase driver in the future,
> but in my opiton, this patch series itself is pretty good to go.
>
> Nan Li (3):
>   mmc: dt-bindings: update bindings doc to support Meson-AXG SoC
>   mmc: meson-axg: add support for the Meson-AXG platform
>   mmc: meson: update doc to support Meson-AXG platform
>
>  .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |  1 +
>  drivers/mmc/host/Kconfig                           |  4 +-
>  drivers/mmc/host/meson-gx-mmc.c                    | 63 ++++++++++++++++++----
>  3 files changed, 55 insertions(+), 13 deletions(-)
>
> --
> 2.16.2
>

Queued up for 3.18, thanks!

Kind regards
Uffe
