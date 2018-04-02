Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeDBDlL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:41:11 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:16473 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDBDlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:41:09 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w323f4Bl007920
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AIpwx49vkQwgoImqp0oRdSXOSYUIwvongT5gbc94ZtqWMwpxVPnH21i118339+c1E9aRheQzLqIYlMEIRXXBL03mgrA=
MIME-Version: 1.0
In-Reply-To: <1522403054-18691-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com> <1522403054-18691-2-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 2 Apr 2018 12:40:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_d6kN0sF_JrGPKdRG1ZbQEbnDQgMB-6VHdsjoJqjipg@mail.gmail.com>
Message-ID: <CAK7LNAT_d6kN0sF_JrGPKdRG1ZbQEbnDQgMB-6VHdsjoJqjipg@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: uniphier: add PCIe clock control support
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
> Add clock control for PCIe controller on UniPhier SoCs. This adds
> support for Pro5, LD20 and PXs3.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>






-- 
Best Regards
Masahiro Yamada
