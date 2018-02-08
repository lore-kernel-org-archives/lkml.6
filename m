Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBHQHy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:07:54 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42668 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBHQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:07:52 -0500
X-Google-Smtp-Source: AH8x227tEqI4RVOFE3uFt3dandu/DuieOGtDL81NpgeJbbQbZAFWTrCPiyoJm/W+L1POFnKFaA5bN9YholR8IaMmdv4=
MIME-Version: 1.0
In-Reply-To: <20180208154252.GB27520@sirena.org.uk>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
 <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
 <20180123173732.GI7600@sirena.org.uk> <CAErzpmt5Z_bVkO-86yCNNWMNSYXWMzvABGtTEuYV1Y1qk=2LJQ@mail.gmail.com>
 <CAHp75Ve-Nq+hbzf9XRDjQrMz_W7BCSW_58o_vA0H1RGqEFpYrA@mail.gmail.com> <20180208154252.GB27520@sirena.org.uk>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 9 Feb 2018 00:07:31 +0800
Message-ID: <CAErzpmv5LHUfFrW4nXZgUGPvd=o+5oOsMrxT=HFeM7aP86C5LA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents of
 dai_list,platform_list and codec_list
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I will send it later.

On Thu, Feb 8, 2018 at 11:42 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 08, 2018 at 04:25:10PM +0200, Andy Shevchenko wrote:
>> On Fri, Jan 26, 2018 at 9:16 AM, Donglin Peng <dolinux.peng@gmail.com> wrote:
>
>> > I can send another patch after the following patch is merged:
>> > https://patchwork.kernel.org/patch/10178813/
>
>> It's merged. I think whenever Mark switched his repositories for new
>> cycle you may be able to submit a patch.
>
> Send it any time, I'll just not apply it until after -rc1 comes out.
