Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeEBMzD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:55:03 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36907 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeEBMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:54:59 -0400
X-Google-Smtp-Source: AB8JxZq+43qdyS4Z29scK9nMZwbDeF2/5vja7e+DwVHxHF+Q43IRNCGF/SVcxd/4lTMNb5EsQSTC4t3riPiQUJamotY=
MIME-Version: 1.0
In-Reply-To: <20180426140728.43155-2-icenowy@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io> <20180426140728.43155-2-icenowy@aosc.io>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 May 2018 14:54:58 +0200
Message-ID: <CAPDyKFr1CRS7W5gYntbo_KhkvoCB00xzfF4jyUOmtkG1z2g2xg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sunxi: add support for the MMC controller on H6
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 April 2018 at 16:07, Icenowy Zheng <icenowy@aosc.io> wrote:
> The new Allwinner H6 SoC have 3 MMC controllers. The first and second
> ones are similar to the ones on A64, but the third one adds EMCE
> (Embedded Crypto Engine) support which does hardware transparent crypto
> on the eMMC.
>
> As we still do not have support for EMCE, and the support of it is
> disabled by defualt, we just duplicate the A64 mmc configurations and
> change the compatible string.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  2 ++

DT doc changes in separate patches please!

>  drivers/mmc/host/sunxi-mmc.c                        | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>

Kind regards
Uffe
