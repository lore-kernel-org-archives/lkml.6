Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeDBDkw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:40:52 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:65243 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDBDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:40:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w323ecY3007704
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AIpwx48YpOYzM3W/A+LuWjw6AuctjM1TRflX/DmKQEaxem+xi/DexLD9LXZhEF/fIPqu4O+NcEz0/GGfP2vqGl2/rPU=
MIME-Version: 1.0
In-Reply-To: <1522403084-18780-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com> <1522403084-18780-3-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 2 Apr 2018 12:39:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAScJ3Z34p6SNbAp3=o_WQMNTi+oNq6YWJZjuNbLYb=4ZQ@mail.gmail.com>
Message-ID: <CAK7LNAScJ3Z34p6SNbAp3=o_WQMNTi+oNq6YWJZjuNbLYb=4ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] reset: uniphier: add SATA reset control support and
 change SATA-PHY ID
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-30 18:44 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add reset lines for SATA controller on UniPhier SoCs.
> This adds support for Pro4 and PXs3 in addition to PXs2.
>
> And this changes the ID of the reset line for SATA-PHY on PXs2.
> Since some SoCs have two controller instances with a common PHY, this moves
> the ID of SATA-PHY for consistency.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>






-- 
Best Regards
Masahiro Yamada
