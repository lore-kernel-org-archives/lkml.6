Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeEPMwj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:52:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34524 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbeEPMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:52:36 -0400
X-Google-Smtp-Source: AB8JxZpUGwDiPwNGJjlSgyI1ViuYeovNba5HCkmj0eyPv9KvK1OyB5XImYHhN9A1PO25t+y7wLT4wNR6nwQU+Yo9RjI=
MIME-Version: 1.0
In-Reply-To: <20180504235728.805-1-bjorn.andersson@linaro.org>
References: <20180504235728.805-1-bjorn.andersson@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 14:52:34 +0200
Message-ID: <CACRpkdZebX=6_g2fV7=i=WveNN75KhGP4BJE5c_6qUP4-rEJMg@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: qcom: fix wrong pull status display for
 no_keeper SoC
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GCqhVZ004976

On Sat, May 5, 2018 at 1:57 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> From: Clément Péron <peron.clem@gmail.com>
>
> DebugFS strings about pin pull status for no_keeper SoC are wrong
>
> Fix this by adding a different string array for no_keeper SoC
>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Hi Linus,
>
> Forwarding this patch which was posted to linux-arm-msm@ only. LGTM, please apply.

Patch applied.

Yours,
Linus Walleij
