Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeBBQJs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:09:48 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38883 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeBBQJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:09:41 -0500
X-Google-Smtp-Source: AH8x224NaBh+z0OYsX57MQBe7/7QryWew1EjthQvkKRtwjfjsAtJtLdlknWlFaa7XtldTJSJ/CP1ZDiGP+YISO6nwz0=
MIME-Version: 1.0
In-Reply-To: <20180202150609.GB7101@sirena.org.uk>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
 <1517475954.8615.18.camel@nxp.com> <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
 <20180201134840.GA10785@sirena.org.uk> <CAHp75VfydH+9ABZRbV++Od3+wnvQdzXyyDFtfi-1FnOUYjOXQQ@mail.gmail.com>
 <20180202150609.GB7101@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 Feb 2018 18:09:39 +0200
Message-ID: <CAHp75VeiPrJc-G44BomwwSFs1AELWNis=aS-j=Pg85ttL78Jnw@mail.gmail.com>
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

On Fri, Feb 2, 2018 at 5:06 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 01, 2018 at 04:46:56PM +0200, Andy Shevchenko wrote:
>> On Thu, Feb 1, 2018 at 3:48 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> >> > Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
>> >> >> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
>> >> >> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> >> >> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
>> > Honestly the signoffs above are nothing unusual for a driver contributed
>> > by a vendor - things are often bouncing around internally for ages and
>> > it's good to keep credits for people.
>
>> We have Co-developed-by: for the authors.
>
> Which doesn't really get much use

True... (13 entries so far)

>  and in this case where it looks like
> the code has flowed from AKM to NXP the DCO bit is pretty important.

...though it doesn't replace SoB, it adds a bit of information to it
(points to the authors of the module).


-- 
With Best Regards,
Andy Shevchenko
