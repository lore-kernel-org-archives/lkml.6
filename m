Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeA3Srr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:47:47 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:41098 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeA3Srq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:47:46 -0500
X-Google-Smtp-Source: AH8x225V0v2YZMh7aeBE9uKlasZcibE9mn1lapW21Dn7D3tSTW+ytPy+wXRMUkevAbsTEwAxZ5u/X2hVQLpzSgK3p20=
MIME-Version: 1.0
In-Reply-To: <20180130184625.3ca09e82@archlinux>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <CAHp75Vd3pDFk5NnJrak_smS-AeHh+d-GXaOwp-8mHtyaK+y0jg@mail.gmail.com>
 <20180130183343.2bf379d0@archlinux> <20180130184625.3ca09e82@archlinux>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 20:47:44 +0200
Message-ID: <CAHp75Ve2wavStf-1f8JaOCf4B5nGyngjO1+Z_6yvJK74cE806w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Steve Presser <steve@pressers.name>,
        Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 8:46 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:

>> Whilst the question is still open I have dropped the patch.
>> Was not yet in a non rebasing tree (just in a build test one)
>> so fine to drop it.
>
> Should have said this isn't the final decision or anything, but
> whilst there are open questions we should take the time to sure
> of the answer!

Please, drop it. It's broken anyway. I'm going to explain this in the
mail to Steve asap.

-- 
With Best Regards,
Andy Shevchenko
