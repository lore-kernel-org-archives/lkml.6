Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeAaM1z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:27:55 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:39965 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeAaM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:27:53 -0500
X-Google-Smtp-Source: AH8x225AN/L5UXWvzzQi4kOvyrHeoJ6pquOO0ye+MSJoVhcAqh8tjh3kAV9/8kJlvn+4V9XPDG1zoIybdvEi6WocIfA=
MIME-Version: 1.0
In-Reply-To: <20180131120348.azy25aqvn5wrdkeh@pali>
References: <20180127133209.28995-1-pali.rohar@gmail.com> <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali> <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 14:27:51 +0200
Message-ID: <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VCRw8g006217

On Wed, Jan 31, 2018 at 2:03 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Sunday 28 January 2018 17:00:35 Andy Shevchenko wrote:
>> On Sun, Jan 28, 2018 at 4:45 PM, Pali Rohár <pali.rohar@gmail.com> wrote:

>> > ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_present
>> > function match only prefix and not exact string?
>>
>> OK, fair enough.
>>
>> Do we have more users of such pattern?
>
> I have not seen this ACPI pattern yet, so probably not.

I see. So, my  one concern is the implicit names of the devices. I
would like rather to see

... acpi_device_id ... []= {
 {"SMO8800"},
 {"SMO8810"},
...
{}
};

-- 
With Best Regards,
Andy Shevchenko
