Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBIOVt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:21:49 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39153 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeBIOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:21:48 -0500
X-Google-Smtp-Source: AH8x227PYSbVhIyKuGVzZZYZbnDeAvAkCf6cVONPSmGuZlI6uY1ev+2d7Qh8MQdSIP42sI6H9LeQDbxWkpWT5S/6BDE=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
 <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 9 Feb 2018 22:21:26 +0800
Message-ID: <CAErzpmuLvx-61EtXJ=p8dqZ3r-wLSEvmsLOcUz9jzzLzAAsxUA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 9:21 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 9, 2018 at 8:58 AM, Donglin Peng <dolinux.peng@gmail.com> wrote:
>> There is some duplicate code in soc-core.c,and the kernel provides
>
> 'core.c,and' -> 'core.c, and'
>
>> +static int codec_list_show(struct seq_file *s, void *v)
>
> No need to rename m -> s.
>
>> +static int dai_list_show(struct seq_file *s, void *v)
>
> Ditto.
>
>> +static int platform_list_show(struct seq_file *s, void *v)
>
> Ditto.
>
> After addressing above,
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> --
> With Best Regards,
> Andy Shevchenko
Thanks for review, and I will send a patch v2.
