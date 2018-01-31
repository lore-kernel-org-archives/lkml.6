Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeAaPTT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:19:19 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35823 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeAaPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:19:16 -0500
X-Google-Smtp-Source: AH8x224cYYP1sP6VvE1W/tDg9P58vtRd93BPEpcHNwlrNh95C9pTsJvZMkz/ZGM7oi+WDMrohZVy2hUDmPr6HpNvITU=
MIME-Version: 1.0
In-Reply-To: <84f1a817-60e8-774a-3fd8-78865e53608a@redhat.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <9171d401-32de-b334-40da-5e80a00e24d9@redhat.com> <CAHp75Vc4JpQ7X9AEFgK0S8SZ89=Mbj8t-jqnWYuPg+LvW9cKWQ@mail.gmail.com>
 <84f1a817-60e8-774a-3fd8-78865e53608a@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 17:19:14 +0200
Message-ID: <CAHp75VfGLGr_W1hUjYr2ijQMFfkFcuZ49xu1+8B4PSnwWjA-WQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Hans de Goede <hdegoede@redhat.com>
Cc: Steve Presser <steve@pressers.name>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
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

On Wed, Jan 31, 2018 at 4:58 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 31-01-18 13:25, Andy Shevchenko wrote:

>> Have you chance a look at the branch I pushed yesterday?

> I assume you mean:
>
> https://bitbucket.org/andy-shev/linux/branch/topic/iio-acpi

Correct.

> This looks very nice and a much better solution then what
> Jeremy Cline posted, which is my fault as I suggested that
> approach to Jeremy :)

NP.

> I've not done a full review, only a quick look, from a quick
> look this looks good. Especially from a code-design pov.

Thanks.
I will wait for test results and if everything okay I will submit
through a normal process with Cc list including you.

-- 
With Best Regards,
Andy Shevchenko
