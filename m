Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeDBDlb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:41:31 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:36333 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDBDla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:41:30 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w323fNUB025668
X-Nifty-SrcIP: [209.85.213.45]
X-Google-Smtp-Source: AIpwx48w6KijMxlJs8v9P/RfL4b5A4iX4kYyhV7Zur0keq0htW2xl+1TUB1kvCTu/oXhoXPGntJLd5N1McaUJqh2PC4=
MIME-Version: 1.0
In-Reply-To: <1522403054-18691-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com> <1522403054-18691-3-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 2 Apr 2018 12:40:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwjzcMFLnU53=wEVqXui2i=9P4oDaYNG02J_rFfPu-1A@mail.gmail.com>
Message-ID: <CAK7LNASwjzcMFLnU53=wEVqXui2i=9P4oDaYNG02J_rFfPu-1A@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: uniphier: add SATA clock control support
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-30 18:44 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add clock control for SATA controller on UniPhier SoCs. This adds
> support for PXs2, LD20 and PXs3.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>





-- 
Best Regards
Masahiro Yamada
