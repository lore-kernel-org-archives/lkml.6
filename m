Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeAaQ4q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:56:46 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34379 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeAaQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:56:44 -0500
X-Google-Smtp-Source: AH8x227lit45InH5++77fD7wETSnKy7m9rQwo7LYpZ1w8qNQNpufLVGmBYmnuIGDX3qMydoMYxEzjNb15C5WAVjqwe0=
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com> <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 18:56:43 +0200
Message-ID: <CAHp75VfmP2zYycht01fo-RPh9o=tRSk4RS6UW02XBjsn7mKgFQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
To: Fabio Estevam <festevam@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        mihai.serban@gmail.com, cosmin.samoila@nxp.com, linux-imx@nxp.com,
        Mihai Serban <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 6:20 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Daniel,

Fabio, +1 to your review. It seems it repeats some of the points I made.


>> +       ak5558->pdn_gpio = of_get_named_gpio(np, "ak5558,pdn-gpio", 0);
>
> It does not match the property in the binding doc: asahi-kasei,pdn-gpios

Btw, it must be simple "reset" as a widely used for the same purpose.

-- 
With Best Regards,
Andy Shevchenko
