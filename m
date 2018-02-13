Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965462AbeBMSc0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:32:26 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44187 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965365AbeBMScY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:32:24 -0500
X-Google-Smtp-Source: AH8x226zhW+YXjZZl+04LG3EwjAybSmZB94NvorxvqvV4FPzZ1m017Wavi2EmfLW6kO/05m6cyZg9oHChqoTITR0Yf0=
MIME-Version: 1.0
In-Reply-To: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
References: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 20:32:23 +0200
Message-ID: <CAHp75VeTeZztEXQTpFM4Wa-zmtH3qOz21Mn=30YmAMEG4PROxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for AK4458 DAC
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Mihai Serban <mihai.serban@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, shegjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 4:14 PM, Cosmin-Gabriel Samoila
<cosmin.samoila@nxp.com> wrote:
> We support Normal Mode, TDM Mode and PM.
>

Read the comments Mark and me gave against another [1] submission.

[1]: https://www.spinics.net/lists/alsa-devel/msg73471.html

> Changes since V1:
> - support only i2c
> - i2c probe / remove/suspend/ resume moved into shared code
> - change enum array to separate variables
> - aggregate Volume control for Left and Right Channel
> - remove mux from DAPM
> - remove unused functions
> - remove unused controls
> - remove unused macros
> - use snd_soc_update_bits instead of soc_read + soc_write
> - use GPIOD
> - use SPDX identifier
> - use dac@10 instgitead of ak4458@10
> - use explicit power_on/off functions
> - add __maybe_unused attribute
> - use probe_new for i2c_probe
>
> Cosmin-Gabriel Samoila (2):
>   ASoC: codecs: Add support for AK4458 DAC driver
>   ASoC: ak4458: Add bindings for AK4458 DAC
>
>  Documentation/devicetree/bindings/sound/ak4458.txt |  23 +
>  sound/soc/codecs/Kconfig                           |   6 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/ak4458.c                          | 684 +++++++++++++++++++++
>  sound/soc/codecs/ak4458.h                          |  75 +++
>  5 files changed, 790 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
>  create mode 100644 sound/soc/codecs/ak4458.c
>  create mode 100644 sound/soc/codecs/ak4458.h
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
