Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeAaMDx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:03:53 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:41532 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeAaMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:03:51 -0500
X-Google-Smtp-Source: AH8x226qc+XiGSO3YAeIp124iz5ojJa/Zn0GwybxLO2GgQgj4W/ltvF67wYYGlXyZGxJVDnVCMmkgw==
Date: Wed, 31 Jan 2018 13:03:48 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Steven Honeyman <stevenhoneyman@gmail.com>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mario Limonciello <Mario_Limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Message-ID: <20180131120348.azy25aqvn5wrdkeh@pali>
References: <20180127133209.28995-1-pali.rohar@gmail.com>
 <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali>
 <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VC3xoB003819

On Sunday 28 January 2018 17:00:35 Andy Shevchenko wrote:
> On Sun, Jan 28, 2018 at 4:45 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Sunday 28 January 2018 16:39:25 Andy Shevchenko wrote:
> >> On Sat, Jan 27, 2018 at 3:32 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> >> > +static bool is_dell_system_with_lis3lv02d(void)
> >> > +{
> >>
> >> > +       /*
> >> > +        * Check that ACPI device SMO88xx exists and is enabled. That ACPI
> >> > +        * device represent our ST microelectronics lis3lv02d accelerometer but
> >> > +        * unfortunately without any other information (like i2c address).
> >> > +        */
> >>
> >> Isn't it simple
> >>
> >> return acpi_dev_present("SMO88", NULL, -1);
> >>
> >> call?
> >
> > ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_present
> > function match only prefix and not exact string?
> 
> OK, fair enough.
> 
> Do we have more users of such pattern?

I have not seen this ACPI pattern yet, so probably not.

-- 
Pali Rohár
pali.rohar@gmail.com
