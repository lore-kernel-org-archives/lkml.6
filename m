Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeDBDkj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:40:39 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:21208 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDBDkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:40:37 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w323eD6P021894
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: AIpwx48k4tpkyFNg/565DW+m9hL9g6jHe4j0FBiIqF0fAD3NrLsnOIbaYeUVMkdkLIWOBMnQbKc7xfGnQP3ruQ/OH2g=
MIME-Version: 1.0
In-Reply-To: <1522403084-18780-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com> <1522403084-18780-2-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 2 Apr 2018 12:39:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQoURnPzWpkZ9uyhsqHJuTB983R-qVdYCMy1XUTLSrurg@mail.gmail.com>
Message-ID: <CAK7LNAQoURnPzWpkZ9uyhsqHJuTB983R-qVdYCMy1XUTLSrurg@mail.gmail.com>
Subject: Re: [PATCH 1/2] reset: uniphier: add PCIe reset control support
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-30 18:44 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add reset lines for PCIe controller on UniPhier SoCs. This adds support for
> Pro5, LD20 and PXs3.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---



Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
