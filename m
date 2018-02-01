Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBAOrA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:47:00 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34660 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeBAOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:46:58 -0500
X-Google-Smtp-Source: AH8x226GkDQpODaud+y4Zbo5D66hZCmo8dV6jJFAP8/9cIbXm+Rrn2Sk8XeevDL+uutjIGK+Hh+ZbfCyKeVLelbBT88=
MIME-Version: 1.0
In-Reply-To: <20180201134840.GA10785@sirena.org.uk>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
 <1517475954.8615.18.camel@nxp.com> <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
 <20180201134840.GA10785@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2018 16:46:56 +0200
Message-ID: <CAHp75VfydH+9ABZRbV++Od3+wnvQdzXyyDFtfi-1FnOUYjOXQQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 3:48 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 01, 2018 at 03:20:38PM +0200, Andy Shevchenko wrote:
>> On Thu, Feb 1, 2018 at 11:05 AM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
>> >> > Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
>> >> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
>> >> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> >> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> >> 4 authors of the code?!
>
>> > The code has a very long history. I will add under each SoB the specific
>> > contribution.
>
>> > Mihai got the code from Junichi and reworked it for 4.9. Then Shengjiu and
>> > me added various features and cleanups.
>
>> > Any other suggestion?
>
>> Yes, please, put detailed credits in commit message to not shock
>> people with so many SoB w/o explanation why.
>
> Honestly the signoffs above are nothing unusual for a driver contributed
> by a vendor - things are often bouncing around internally for ages and
> it's good to keep credits for people.

We have Co-developed-by: for the authors.

-- 
With Best Regards,
Andy Shevchenko
