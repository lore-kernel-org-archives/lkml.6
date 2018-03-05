Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeCEIp6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:45:58 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:38912 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933168AbeCEIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:45:56 -0500
X-Google-Smtp-Source: AG47ELuScMUyAyJ6wRfPMHmwMSuybOgO4yGBTmKgFxE7TqSL5QIm4bGWe7CXmn/iAHyU3EW0vU6TFkedLpoEbPGDbMw=
MIME-Version: 1.0
In-Reply-To: <6cb1d6d4ee40a61f7b33aed1711753342590d0dd.1520232933.git.sean.wang@mediatek.com>
References: <6cb1d6d4ee40a61f7b33aed1711753342590d0dd.1520232933.git.sean.wang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Mar 2018 09:45:55 +0100
Message-ID: <CAPDyKFqvhrsNqqqo0R=6mpfR-mBM8uNeJTdXj+FuuU7TUmn=Sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: dt-bindings: add support for MT7622 SoC
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 March 2018 at 08:03,  <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> Add the devicetree binding for MT7622 SoC
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 9b80176..f33467a 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -12,6 +12,7 @@ Required properties:
>         "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>         "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>         "mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> +       "mediatek,mt7622-mmc": for MT7622 SoC
>         "mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
>
>  - reg: physical base address of the controller and length
> --
> 2.7.4
>
