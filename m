Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965604AbeBMRGB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:06:01 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:39754 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964840AbeBMRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:05:58 -0500
X-Google-Smtp-Source: AH8x2248S2TdCNu2foDhFR+pR4m+QS8LU4+rdL3NgeAV4MyQ49Y8E9TJgt+5YoqYd7tFC6iKv0iC+G9mwhOiX8MFlVg=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc9T8umLVtBuBCK+HgAga9=ZKBhBTjA8Nmbvaw1zyVLng@mail.gmail.com>
References: <20180127133209.28995-1-pali.rohar@gmail.com> <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali> <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali> <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
 <20180212153012.vffvjmz26ifyxbj5@pali> <CAHp75VfF+qwCXcr3yuayE-Z+UG9wuMOKfGzLhdyPk79daEi9gQ@mail.gmail.com>
 <20180213150004.5d2v7y7wwuure4io@pali> <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
 <20180213165023.xmzovx7fd3gdljxw@pali> <CAHp75Vc9T8umLVtBuBCK+HgAga9=ZKBhBTjA8Nmbvaw1zyVLng@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 19:05:57 +0200
Message-ID: <CAHp75Vd=LLLBFUoOHxFcM+G9A8F2wQ6E5a9vsQTM3rxcz1aGhg@mail.gmail.com>
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

On Tue, Feb 13, 2018 at 7:01 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Similar approach is used in spi-pxa2xx.c (check pxa2xx_spi_pci_compound_match).

Another approach might be a registration of I2C board info from
dell-smo8800.c. Not sure if it better, because theoretically user may
disable that one, but leave i2c-i801 enabled.

-- 
With Best Regards,
Andy Shevchenko
