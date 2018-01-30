Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeA3RFa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:05:30 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45594 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932065AbeA3RF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:05:28 -0500
X-Google-Smtp-Source: AH8x226XLILbfo4Zeuj20iOYrreP4x/O6hKwiTdV+V8ANQJcsJ2XLwQTzrYzxAbo7O7J3XOoxE2xRtDeaFFmkk7VSGA=
MIME-Version: 1.0
In-Reply-To: <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 19:05:27 +0200
Message-ID: <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Jeremy Cline <jeremy@jcline.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 6:40 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jan 30, 2018 at 6:01 PM, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>> On Mon, 29 Jan 2018 16:07:02 +0200
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>>> > But that would take much longer.  Feel free to propose it and a patch
>>> > removing the ifdef fun if you like!
>
>>> Where can I see the patch?
>
>> Doh. I clearly forgot to push out.  Should be able to push to
>> iio.git on kernel.org later.
>
> Thanks, I can see it now.
>
> This patch almost wrong. Not by functionality it brings, but by style.

Oy vey, the second device is *not* accelerometer, it is a magnetometer [1].

[1]: https://www.mouser.com/ds/2/783/BST-BMC150-DS000-04-786477.pdf

> I'll send soon a series of fixes to the driver (compile tested only)
> to provide my view on the matters.
>
> P.S. In the future (I have some kind of deja vu I have told this
> already to someone), please, Cc one or more of Rafael, Mika and/or me
> for ACPI matters.

-- 
With Best Regards,
Andy Shevchenko
