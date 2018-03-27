Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeC0LhL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:37:11 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:36472 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeC0LhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:37:09 -0400
X-Google-Smtp-Source: AIpwx49WrR4C2WDSc4drzXkWYcGd5VddthQhppvsS4RN7ogUKJAWEQHUSFskUA6A12t3Dp1nI1vaT3yb7hzt35pjxAk=
MIME-Version: 1.0
In-Reply-To: <20180314063535.13303-1-suzuki.katsuhiro@socionext.com>
References: <20180314063535.13303-1-suzuki.katsuhiro@socionext.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 13:37:08 +0200
Message-ID: <CACRpkdYDJkk8eJuGPAXO7fpvGZ4KbjSf43difeEGTV9KzJcmvg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: divide I2S and S/PDIF audio out
 pin-mux group
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 7:35 AM, Katsuhiro Suzuki
<suzuki.katsuhiro@socionext.com> wrote:

> This patch divides large pin-mux group 'aio' of UniPhier LD11/LD20
> to 2 groups as following:
>   aout1   : 8ch I2S output: AO1DACCK, AO1BCK, AO1LRCK, AO1D[0-2]
>   aoutiec1: S/PDIF output : AO1IEC, AO1ARC
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Patch applied with Masahiro's ACK!

Yours,
Linus Walleij
