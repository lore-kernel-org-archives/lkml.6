Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031159AbeBNOxI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:53:08 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:44953 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030773AbeBNOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:53:04 -0500
X-Google-Smtp-Source: AH8x224SHZQ69f3k1wascyMZ7XSRVXLy8UAx6q3hl4/wCcghU4KcOKtostXGGTvPEwAWNNsr4cGYQLUOkYr63TVIzNI=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vey-RoLw9kWRg1mdz7-4vBcmOUmdLxjz067f3qjN_S3NA@mail.gmail.com>
References: <CAErzpmuxmrJszRz5_SZXPMkdU2UWNHChrnKjnHuCWZYrs4hgTA@mail.gmail.com>
 <20180212114937.GA12976@sirena.org.uk> <CAErzpmt+HhGkVoN199iPDmQx-1z3iS3waxYQ=oxvn14Bm0R5gg@mail.gmail.com>
 <CAHp75Vey-RoLw9kWRg1mdz7-4vBcmOUmdLxjz067f3qjN_S3NA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Feb 2018 22:52:42 +0800
Message-ID: <CAErzpmtW897Xa5Q_zsu1ye8XAKCFhDw-rn4YzqfsgeMQj6DcCg@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:41 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 14, 2018 at 4:39 PM, Donglin Peng <dolinux.peng@gmail.com> wrote:
>> On Mon, Feb 12, 2018 at 7:49 PM, Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Feb 09, 2018 at 11:10:55PM +0800, Donglin Peng wrote:
>
>> Hi Mark, do you know the way to disable gmail word wrap in plain text mode?
>> I find that gmail will force to wrap word at 70 characters in plain text mode.
>
>> There is a connection error when I use git send-email to send the patch
>> because I am using VPN.
>
> You may use SMTPS port (587 IIRC?) of Gmail to send a patch via git send-email.
Thanks, I have sent it just now.
>
> --
> With Best Regards,
> Andy Shevchenko
