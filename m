Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbeBGUTz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:19:55 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:46527 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754548AbeBGUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:19:52 -0500
X-Google-Smtp-Source: AH8x226T5Q8I7Tvx7IYtmDVrnAqu6TtpIgqM1hTMS/mpG3anpcEcHihk3UPJgGk2tMLQPQUcIaaBwAjDBdeRhh//0Pw=
MIME-Version: 1.0
In-Reply-To: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 7 Feb 2018 21:19:51 +0100
Message-ID: <CAPDyKFpYLm2vVVsAkE2r5HVF4uzgHS404dUzPcEsxJiawEf7Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: add SCPSYS binding for MT7623
 and MT7623A SoC
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2018 at 11:22,  <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> document the binding for enabling SCPSYS on MediaTek MT7623 and MT7623A
> SoC. Where MT7623 SoC has the same definition about power domains with
> MT2701, so it's fine to using MT2701 ones as MT7623's fallback.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index 76bf45b..d6fe16f 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -21,6 +21,8 @@ Required properties:
>         - "mediatek,mt2712-scpsys"
>         - "mediatek,mt6797-scpsys"
>         - "mediatek,mt7622-scpsys"
> +       - "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
> +       - "mediatek,mt7623a-scpsys": For MT7623A SoC
>         - "mediatek,mt8173-scpsys"
>  - #power-domain-cells: Must be 1
>  - reg: Address range of the SCPSYS unit
> @@ -28,10 +30,11 @@ Required properties:
>  - clock, clock-names: clocks according to the common clock binding.
>                        These are clocks which hardware needs to be
>                        enabled before enabling certain power domains.
> -       Required clocks for MT2701: "mm", "mfg", "ethif"
> +       Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
>         Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
>         Required clocks for MT6797: "mm", "mfg", "vdec"
>         Required clocks for MT7622: "hif_sel"
> +       Required clocks for MT7622A: "ethif"
>         Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
>
>  Optional properties:
> --
> 2.7.4
>
