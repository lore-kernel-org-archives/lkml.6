Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756248AbeCWKhx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:37:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:48130 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933787AbeCWKRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:17:22 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2NAH96i003188
X-Nifty-SrcIP: [209.85.217.172]
X-Google-Smtp-Source: AG47ELs/CtsxNNv8mufrDn/Or7Tv1+WDmxNPZADLcR3R4W4ACDFztsVXvsmH5asB7MfG2SUpINnRG4EHoF0lRxsCQOE=
MIME-Version: 1.0
In-Reply-To: <1521781954-20526-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521781954-20526-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Mar 2018 19:16:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARk3-_DdMcOd4=Tjr0hLO8h=FieQLqye27w8BAbZW-qJA@mail.gmail.com>
Message-ID: <CAK7LNARk3-_DdMcOd4=Tjr0hLO8h=FieQLqye27w8BAbZW-qJA@mail.gmail.com>
Subject: Re: [PATCH] reset: uniphier: add ethernet reset control support for PXs3
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 14:12 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add reset lines for ethernet controller on PXs3 SoC.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/reset/reset-uniphier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index e8bb023..fd3afbd 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -121,6 +121,8 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
>  static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
>         UNIPHIER_RESETX(2, 0x200c, 0),          /* NAND */
>         UNIPHIER_RESETX(4, 0x200c, 2),          /* eMMC */
> +       UNIPHIER_RESETX(6, 0x200c, 9),          /* Ether0 */
> +       UNIPHIER_RESETX(7, 0x200c, 10),         /* Ether1 */
>         UNIPHIER_RESETX(8, 0x200c, 12),         /* STDMAC */
>         UNIPHIER_RESETX(12, 0x200c, 4),         /* USB30 link (GIO0) */
>         UNIPHIER_RESETX(13, 0x200c, 5),         /* USB31 link (GIO1) */
> --
> 2.7.4
>

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
