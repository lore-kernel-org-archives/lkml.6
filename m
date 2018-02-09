Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBINVV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:21:21 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46689 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeBINVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:21:19 -0500
X-Google-Smtp-Source: AH8x224/shiPd9PKDc9IlRJb6K7qflm2Xk+SF97PUvK9u8APJ6NPcCcwfXkv4P75OI/0X8jgqpPuRQNym8weqwEysE0=
MIME-Version: 1.0
In-Reply-To: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2018 15:21:17 +0200
Message-ID: <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 8:58 AM, Donglin Peng <dolinux.peng@gmail.com> wrote:
> There is some duplicate code in soc-core.c,and the kernel provides

'core.c,and' -> 'core.c, and'

> +static int codec_list_show(struct seq_file *s, void *v)

No need to rename m -> s.

> +static int dai_list_show(struct seq_file *s, void *v)

Ditto.

> +static int platform_list_show(struct seq_file *s, void *v)

Ditto.

After addressing above,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
