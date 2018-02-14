Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030995AbeBNPGm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:06:42 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:40037 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030382AbeBNPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:06:41 -0500
X-Google-Smtp-Source: AH8x224FKjFNeYvNX68asoJGRwp/COPxh8pfzwBLgU6kimtH1VcQWaCHi51St2SYwGzoFy17Dt/Gz1OmKcK3//EbVao=
MIME-Version: 1.0
In-Reply-To: <20180214145343.GC12658@sirena.org.uk>
References: <1518619687-31442-1-git-send-email-dolinux.peng@gmail.com> <20180214145343.GC12658@sirena.org.uk>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Feb 2018 23:06:20 +0800
Message-ID: <CAErzpmuZH80a6ZKnT7cfoZN8NpMnGjdcenwF=epyJskPONLFgw@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:53 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Feb 14, 2018 at 10:48:07PM +0800, Peng Donglin wrote:
>
>> v4:
>>  * resend patch using outlook email, because I can't disable gmail
>>    word wrap in plain text mode
>
> Using Outlook for better interaction with the lists!
Okay, I have sent it.
