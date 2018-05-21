Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeEUWZp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:25:45 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44379 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbeEUWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:25:41 -0400
X-Google-Smtp-Source: AB8JxZo7MKwStE7PVqoUqcOoBAUAHeU2wmMscnAJ99WRurl7sIT/lyiRUOsvWWyQscT4ZUK5VB7INuM9hNYXWzeN4Qw=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-33-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-33-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:25:39 +0300
Message-ID: <CAHp75Vdr08D1XreBRadRTTNFnty4rLm2i=V-uQtVKUPRvXqjYQ@mail.gmail.com>
Subject: Re: [PATCH 32/33] ASoC: max98095: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.


> +       int ret = match_string(bq_mode_name, ARRAY_SIZE(bq_mode_name), name);

Rather split and move an assignment to the line before 'if'.

>
>         /* Shouldn't happen */

> +       if (ret < 0)
> +               dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
> +       return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko
