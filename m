Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754283AbeDBDly (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:41:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:17205 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeDBDlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:41:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w323fhhS008075
X-Nifty-SrcIP: [209.85.213.41]
X-Google-Smtp-Source: AIpwx4/byoSZ8i21sCSzW5MlZ/BGrj1SQjCnb1GBHtQDbZOmVH1v6kWX9GKlilqOwXoW47fF0Qgohr6pfdPX8E1aJgk=
MIME-Version: 1.0
In-Reply-To: <1522403054-18691-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com> <1522403054-18691-4-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 2 Apr 2018 12:41:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=ZCnD0rAP9yrTZLuK=oBuQN4ZxwA5WCMenidohiNsKw@mail.gmail.com>
Message-ID: <CAK7LNAS=ZCnD0rAP9yrTZLuK=oBuQN4ZxwA5WCMenidohiNsKw@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: uniphier: add additional ethernet clock lines
 for Pro4
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
> Pro4 SoC has clock lines for Giga-bit feature and ethernet phy,
> and these are mandatory to activate the ethernet controller. This adds
> support for the clock lines.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>





-- 
Best Regards
Masahiro Yamada
