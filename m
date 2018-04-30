Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeD3JRW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:17:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37723 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeD3JRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:17:20 -0400
X-Google-Smtp-Source: AB8JxZqRA0ni96sKcLvrYqOiOuat4FeuQj8QqG97tB3LXUOMGrpPz6Dm5S6FCReUutZK0Ap9LN5UTFv+AaAgPspAVXs=
MIME-Version: 1.0
In-Reply-To: <20180424131642.3806-1-luc.vanoostenryck@gmail.com>
References: <20180424131642.3806-1-luc.vanoostenryck@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Apr 2018 11:17:19 +0200
Message-ID: <CACRpkdaR=wqCfRmyqpLufYoLbFHr9ixy6gZq6MqdaGdaXPiQzQ@mail.gmail.com>
Subject: Re: [PATCH] net: gemini: fix gmac_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 3:16 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>
> Fix this by returning 'netdev_tx_t' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this!
Linus Walleij
