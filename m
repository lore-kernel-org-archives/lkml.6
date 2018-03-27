Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeC0Nwc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:52:32 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33663 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeC0Nw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:52:29 -0400
X-Google-Smtp-Source: AG47ELtoCqh7u8C6IMhmn9gVfoTFJhve/FCTsTKQx+eFjqLhxBgScipsPAqhCULcrrYXKXW88ZZLWp1kgSB7tbAKsMQ=
MIME-Version: 1.0
In-Reply-To: <c84c05b6619a17848a11335f881f42153a4e51c0.1520218279.git.baolin.wang@linaro.org>
References: <787c9f115db06390549bfee366b7f70faf312286.1520218279.git.baolin.wang@linaro.org>
 <c84c05b6619a17848a11335f881f42153a4e51c0.1520218279.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:52:28 +0200
Message-ID: <CACRpkdYF_dBi27jHEsO52SZs3sYR9JG_+ZDpH8bmDZ5ew4uskA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] gpio: Add Spreadtrum PMIC EIC driver support
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

> The Spreadtrum PMIC EIC controller contains only one bank of debounce EIC,
> and this bank contains 16 EICs. Each EIC can only be used as input mode,
> as well as supporting the debounce and the capability to trigger interrupts
> when detecting input signals.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v2:
>  - Fix coding style issue.
>  - Fix possible overflow.
>  - Use for_each_set_bit().

Patch applied!

Also added Andy's review tag on all of the patches.

Yours,
Linus Walleij
