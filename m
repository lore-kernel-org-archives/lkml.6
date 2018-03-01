Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032781AbeCAQEr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:04:47 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:51583 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032700AbeCAQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:04:44 -0500
X-Google-Smtp-Source: AG47ELvZ5cnwqg3hqJK4eB8XUls2uNK/vKCNOwvwE9Yw1RfcWCS/MVrA5a1MBlCpqIeUPmohLHdLjR8YFEmorgFeon0=
MIME-Version: 1.0
In-Reply-To: <20180222132705.18314-1-niklas.cassel@axis.com>
References: <20180222132705.18314-1-niklas.cassel@axis.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 17:04:43 +0100
Message-ID: <CACRpkdb3gDBfX+05mSBk3h4Mm-0jvHebT4LbU9p1Bw2Y0U4=tg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: artpec-6: Add smaller groups for uarts
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jesper Nilsson <jespern@axis.com>, Lars Persson <larper@axis.com>,
        Niklas Cassel <niklass@axis.com>, linux-arm-kernel@axis.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 2:27 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:

> From: Jesper Nilsson <jesper.nilsson@axis.com>
>
> Add group configuration for uarts that are cut down
> variants, the standard being full, i.e. all signals,
> flow control, i.e. rx/tx and cts/rts, and rx/tx only.
>
> This allows us to be more precise in which pins we're
> actually using.
>
> Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>

Patch applied!

Yours,
Linus Walleij
