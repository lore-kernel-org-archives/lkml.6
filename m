Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeBAPMy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:12:54 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43920 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeBAPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:12:52 -0500
X-Google-Smtp-Source: AH8x22535+skvYSSDI6dAuO5K3EWmwtRUSpuISirsW8RtOtn+XtxoRC+OVZir/KAaVjMeOHXEAb7ERfHmok+iOhVbFQ=
MIME-Version: 1.0
In-Reply-To: <20180201122230.GC690@gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
 <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
 <CAHp75Vcig869pUQ5yK1b=GpXinhYkpw1q29OVKSs_7EqP4Hknw@mail.gmail.com>
 <CAMz4kuL9r+97_rDihgKD_TyNaDQ3aCk7go6e4mB24QOpovFYJg@mail.gmail.com>
 <CAHp75VcYQMYNmW9-MkOKA5TWV2JgNfqnUB22s1qB4Z0ZZbTG2g@mail.gmail.com>
 <CAMz4kuLO=zRqg72=7dC2fLHyVcEOcsU0PqiZM8XEYC3TGT1fYA@mail.gmail.com> <20180201122230.GC690@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2018 17:12:50 +0200
Message-ID: <CAHp75VdrSC6dePsebN36v4iigDa9o3996cm3Wu27CrAZBeSLgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 2:22 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> On Thu, Feb 01, 2018 at 11:08:46AM +0800, Baolin Wang wrote:

> Then you could replace

> +subsys_initcall(sprd_gpio_init);

> module_platform_driver(sprd_gpio_driver);

It's not an equivalent when built-in


-- 
With Best Regards,
Andy Shevchenko
