Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbeBGOPI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:15:08 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:39413 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeBGOPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:15:06 -0500
X-Google-Smtp-Source: AH8x224QKL8rVWfVXoeZv++fM+XR7gpWpr3fRZhFH2kv+o119D5w+F35uZ2OoS0ICBant3ixY7Bs4aKA8Snf7b9+JSU=
MIME-Version: 1.0
In-Reply-To: <20180126112838.GA32674@sirena.org.uk>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
 <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
 <20180123173732.GI7600@sirena.org.uk> <CAErzpmt5Z_bVkO-86yCNNWMNSYXWMzvABGtTEuYV1Y1qk=2LJQ@mail.gmail.com>
 <20180126112838.GA32674@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Feb 2018 16:15:04 +0200
Message-ID: <CAHp75VdvTdwB=EM1DejYHcazBRRgoy5cw=Rs0U5kSTXHWeuUOA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents of
 dai_list,platform_list and codec_list
To: Mark Brown <broonie@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 1:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 26, 2018 at 03:16:00PM +0800, Donglin Peng wrote:
>> On Wed, Jan 24, 2018 at 1:37 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Too late, I already applied this - a further conversion for the new
>> > macro would be good.
>
>> I can send another patch after the following patch is merged:
>> https://patchwork.kernel.org/patch/10178813/
>
> Yes, please - that'd be great!

I have sent PR to Linus. If everything goes fine, it will be in
upstream today evening.

-- 
With Best Regards,
Andy Shevchenko
