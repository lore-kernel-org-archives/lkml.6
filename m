Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935624AbeCHINV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:13:21 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:39431 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755036AbeCHINT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:13:19 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w288D84f029876
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AG47ELtrQ+LIyhL7jicHcAwFDLP5Px2so13Fu1PL4cZcMGFDDPoe3zbNYYpSBp/U9/PdHXZWvh4nTOjkMpJTs/DBWnU=
MIME-Version: 1.0
In-Reply-To: <20180308080929.30982-1-suzuki.katsuhiro@socionext.com>
References: <20180308080929.30982-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Mar 2018 17:12:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkq6t7zhaNRGUM7nU4NGBAT3FEQTg0xKXHPZOmBcc-OA@mail.gmail.com>
Message-ID: <CAK7LNAQkq6t7zhaNRGUM7nU4NGBAT3FEQTg0xKXHPZOmBcc-OA@mail.gmail.com>
Subject: Re: [PATCH] reset: uniphier: add Pro4/Pro5/PXs2 audio systems reset control
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-08 17:09 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> Add reset lines for audio subsystem (AIO) on UniPhier
> Pro4/Pro5/PXs2 SoCs.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



>  drivers/reset/reset-uniphier.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index e8bb023ff15e..0fa23129d343 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -63,6 +63,7 @@ static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
>         UNIPHIER_RESETX(12, 0x2000, 6),         /* GIO (Ether, SATA, USB3) */
>         UNIPHIER_RESETX(14, 0x2000, 17),        /* USB30 */
>         UNIPHIER_RESETX(15, 0x2004, 17),        /* USB31 */
> +       UNIPHIER_RESETX(40, 0x2000, 13),        /* AIO */
>         UNIPHIER_RESET_END,
>  };
>
> @@ -72,6 +73,7 @@ static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
>         UNIPHIER_RESETX(12, 0x2000, 6),         /* GIO (PCIe, USB3) */
>         UNIPHIER_RESETX(14, 0x2000, 17),        /* USB30 */
>         UNIPHIER_RESETX(15, 0x2004, 17),        /* USB31 */
> +       UNIPHIER_RESETX(40, 0x2000, 13),        /* AIO */
>         UNIPHIER_RESET_END,
>  };
>
> @@ -88,6 +90,7 @@ static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
>         UNIPHIER_RESETX(21, 0x2014, 1),         /* USB31-PHY1 */
>         UNIPHIER_RESETX(28, 0x2014, 12),        /* SATA */
>         UNIPHIER_RESET(29, 0x2014, 8),          /* SATA-PHY (active high) */
> +       UNIPHIER_RESETX(40, 0x2000, 13),        /* AIO */
>         UNIPHIER_RESET_END,
>  };
>
> --
> 2.16.1
>



-- 
Best Regards
Masahiro Yamada
