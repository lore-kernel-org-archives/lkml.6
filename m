Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeBLPZf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:25:35 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37456 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbeBLPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:25:24 -0500
X-Google-Smtp-Source: AH8x227jZ6Q28AVG5UsDt6wksQfuRPbpvD06rhW9HGkChmfGx389WDvz2Q3G/wRX0+4u8DcwG/rFFOBVc1sW7bCdrSU=
MIME-Version: 1.0
In-Reply-To: <20180211220317.GA833@kmp-mobile.hq.kempniu.pl>
References: <20180127133209.28995-1-pali.rohar@gmail.com> <20180211220317.GA833@kmp-mobile.hq.kempniu.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2018 17:25:23 +0200
Message-ID: <CAHp75Ve6dCgX+ophyh8M2SzVvpMoDSpwYyiNo=QStht=1G8n+Q@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1CFPcvF008969

On Mon, Feb 12, 2018 at 12:03 AM, Michał Kępień <kernel@kempniu.pl> wrote:

>> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
>> ---
>> Changes since v1:
>>  * Added Dell Vostro V131 based on Michał Kępień testing
>
> I tested this patch on a Vostro V131 and it seems to work as expected:
> "lis3lv02d: 8 bits sensor found" is logged during boot, an input device
> gets registered and its axis values seem to be consistent with laptop's
> movements.
>
> Tested-by: Michał Kępień <kernel@kempniu.pl>

Thanks! I'm waiting for Pali to address my concern.

> I did not review the contents of the patch this time, sorry.

-- 
With Best Regards,
Andy Shevchenko
