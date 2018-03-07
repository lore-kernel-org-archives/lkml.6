Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934280AbeCGWZv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:25:51 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:46945 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933412AbeCGWZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:25:50 -0500
X-Google-Smtp-Source: AG47ELv2qJzce3cB0UwZp1LnyfjT4zEq40mHf5l+hCBfVCJ7aecK+ce1BbdApRENRzrDnKDU6AbR0X8VPL4Re5bQObc=
MIME-Version: 1.0
In-Reply-To: <20180308073921.5c104e74@canb.auug.org.au>
References: <20180308073921.5c104e74@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Mar 2018 23:25:48 +0100
Message-ID: <CACRpkdaWd_7QWd7t5i6DvU3_Gu1giR9v2uoqQiLNXVWTPEty8w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 9:39 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Linus,
>
> Commit
>
>   fc08fa6009a0 ("pinctrl: sh-pfc: r8a7795: remove duplicate of CLKOUT pin in pinmux_pins[]")
>
> is missing a Signed-off-by from its committer.

Looping in Geert,

I guess this came in through the Renesas PFC pull request.

Geert do you prefer that I back it all out so you can send me
a new pull request? Or some other solution?

Yours,
Linus Walleij
