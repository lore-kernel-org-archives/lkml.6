Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeC0Ntp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:49:45 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36568 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeC0Ntm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:49:42 -0400
X-Google-Smtp-Source: AG47ELt7eGgs/kJHYJriRnBYreloZ1JaytJ9SiIPxRGmZfPJmBcp6r2ASbGpaCdItsymJF9hSru7823tMvGi6p+gZ9c=
MIME-Version: 1.0
In-Reply-To: <81071c32c104205af015f20ee63f4cb74eb274a2.1520218279.git.baolin.wang@linaro.org>
References: <787c9f115db06390549bfee366b7f70faf312286.1520218279.git.baolin.wang@linaro.org>
 <81071c32c104205af015f20ee63f4cb74eb274a2.1520218279.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:49:41 +0200
Message-ID: <CACRpkdYa5=0_66LMF+10Dqmzgsgw-sj3=fdJhhuf=5c-7U-YOA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] gpio: Add Spreadtrum EIC driver support
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 3:56 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> The Spreadtrum digital-chip EIC controller has 4 sub-modules: debounce EIC,
> latch EIC, async EIC and sync EIC, and each sub-module can has multiple
> banks and each bank contains 8 EICs.
>
> Each EIC can only be used as input mode, and has the capability to trigger
> interrupts when detecting input signals.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v2:
>  - No updates.

Patch applied.

Yours,
Linus Walleij
