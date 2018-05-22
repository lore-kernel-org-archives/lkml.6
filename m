Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeEVRXg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:23:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37732 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEVRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:23:35 -0400
X-Google-Smtp-Source: AB8JxZqr6ajHpVkErLUXqwlb8ItkpG8L7u5iajZmOW8vIi8EdKQ4ACwjUiwnnV3BN+iTEINsq+YGzg9R4bWtVOg+7A8=
MIME-Version: 1.0
In-Reply-To: <92b32dee-7ba9-ad6d-573b-9924453a69fb@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com> <92b32dee-7ba9-ad6d-573b-9924453a69fb@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 20:23:33 +0300
Message-ID: <CAHp75Vesp4BmnLNK4iqw_nG+7_rtgQceqbRdtGCmU46nLSHT3w@mail.gmail.com>
Subject: Re: [PATCH 31/33] ASoC: max98088: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 3:30 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:

> hmm, you mean something like:
>
>         int ret;
>
>         ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
>         if (ret < 0) /* Shouldn't happen */
>                 dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
>         return ret;

Yes. (But remove that useless comment).

-- 
With Best Regards,
Andy Shevchenko
