Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753799AbeA3VUc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:20:32 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35518 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeA3VUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:20:30 -0500
X-Google-Smtp-Source: AH8x226aR62bQ0TZhouiYWbyXpueJtaQMTKuVxFYwhBbMLhxW2vCHvOpvk9goiNq+8EJ1QukliJzkx+HCJI+oYUxR1Q=
MIME-Version: 1.0
In-Reply-To: <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name> <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
 <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name> <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 23:20:28 +0200
Message-ID: <CAHp75VfPBP0TVt-==0wjcK6Oxg1kVN4mQf5Ji50RBy=SXf6yFw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Steven Presser <steve@pressers.name>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
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

On Tue, Jan 30, 2018 at 10:12 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jan 30, 2018 at 9:27 PM, Steven Presser <steve@pressers.name> wrote:
>> On 01/30/2018 02:05 PM, Andy Shevchenko wrote:
>>> On Tue, Jan 30, 2018 at 8:34 PM, Steven Presser <steve@pressers.name>
>>> wrote:

> Let's do this way. Create a bug on kernel bugzilla, attach output of
>
> % acpidump -o tables.dat # tables.dat file
> % grep -H 15 /sys/bus/acpi/devices/*/status
> % dmidecode
>
> and share the number here. I will take it.

Here [1] is the branch with another approach. Can you test it and tell
if it fixes the issue?

[1]: https://bitbucket.org/andy-shev/linux/branch/topic/iio-acpi
It's based on linux-next + compiletest branch of IIO subsystem.

-- 
With Best Regards,
Andy Shevchenko
