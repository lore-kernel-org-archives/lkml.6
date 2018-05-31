Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756006AbeEaSka (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:40:30 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45388 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755903AbeEaSk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:40:29 -0400
X-Google-Smtp-Source: ADUXVKLucvZXClBgSCkDi+uITpMgsladZckdsH4kOn71ALz0HAjF1BUzb8nvfCTZztFjkyMExTfnU9X1Ly/YgvYFQQY=
MIME-Version: 1.0
In-Reply-To: <s5hsh67655m.wl-tiwai@suse.de>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com> <s5hsh67655m.wl-tiwai@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 21:40:28 +0300
Message-ID: <CAHp75VdDQXkBUb8Vgiaof68hrO94nnT7L_kLN9UscgUJDrza+g@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] ALSA: oxygen: use match_string() helper
To: Takashi Iwai <tiwai@suse.de>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 9:39 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 31 May 2018 13:11:20 +0200,
> Yisheng Xie wrote:
>>
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
>>
>> Cc: Clemens Ladisch <clemens@ladisch.de>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: alsa-devel@alsa-project.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>
> Applied, thanks.

Is it too late for nitpick?

-- 
With Best Regards,
Andy Shevchenko
