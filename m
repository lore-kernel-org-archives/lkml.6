Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeBANUn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:20:43 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35000 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752737AbeBANUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:20:40 -0500
X-Google-Smtp-Source: AH8x226f4P3eVZ518PCNgnoGTlShKfJzfs5kLKv/yj9gxks1HBrLEdU1I24ukjLKJvsXygXKXgHBdT2/q6z0TTxEsI8=
MIME-Version: 1.0
In-Reply-To: <1517475954.8615.18.camel@nxp.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com> <1517475954.8615.18.camel@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2018 15:20:38 +0200
Message-ID: <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 11:05 AM, Daniel Baluta <daniel.baluta@nxp.com> wrote:

>> > Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
>> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
>> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> 4 authors of the code?!
>
> The code has a very long history. I will add under each SoB the specific
> contribution.
>
> Mihai got the code from Junichi and reworked it for 4.9. Then Shengjiu and
> me added various features and cleanups.

> Any other suggestion?

Yes, please, put detailed credits in commit message to not shock
people with so many SoB w/o explanation why.

-- 
With Best Regards,
Andy Shevchenko
