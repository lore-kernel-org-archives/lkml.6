Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938005AbeBUOue (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:50:34 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:46692 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932826AbeBUOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:50:32 -0500
X-Google-Smtp-Source: AH8x224KC/ouafXcw50ItpLaUT2PG4BNH94k3gSLwQZdf0Nryr/Z2zKiMs6DWINJbOsjsuF7KjsDXVtlX2eWg/tByPE=
MIME-Version: 1.0
In-Reply-To: <20180220174446.7784-3-k.marinushkin@gmail.com>
References: <20180220174446.7784-1-k.marinushkin@gmail.com> <20180220174446.7784-3-k.marinushkin@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 16:50:30 +0200
Message-ID: <CAHp75Vc451W4GvvVCv-70EO6Cgn99Y+HV9xb530nJ72aT79rLQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] ASoC: topology: Add missing clock gating
 parameter when parsing hw_configs
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 7:44 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> Clock gating parameter is a part of `dai_fmt`. It is supported by
> `alsa-lib` when creating a topology binary file, but ignored by kernel
> when loading this topology file.

> +               /* clock gating */
> +               if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
> +                       link->dai_fmt |= SND_SOC_DAIFMT_GATED;

> +               else if (hw_config->clock_gated ==
> +                        SND_SOC_TPLG_DAI_CLK_GATE_CONT)

A nit, I would leave it on the same line, even if it ~2-3 characters
longer than 80.

> +                       link->dai_fmt |= SND_SOC_DAIFMT_CONT;
> +

-- 
With Best Regards,
Andy Shevchenko
