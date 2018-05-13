Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeEMUeY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:34:24 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46114 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeEMUeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:34:21 -0400
X-Google-Smtp-Source: AB8JxZpGWcdAQ+HUWevebjkWTdMUmuEjGucfigDmyXNgmT18D4vXXSFeHxH0gPgWY1Kuaf+3FbJsDTtUF6LBTfZOIYQ=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805132119510.1582@nanos.tec.linutronix.de>
References: <20180503211217.47822-1-andriy.shevchenko@linux.intel.com> <alpine.DEB.2.21.1805132119510.1582@nanos.tec.linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 23:34:20 +0300
Message-ID: <CAHp75Vc1_+9+vLxJLA6eCtcvcdiqekO0m_jnWH5DZsPfugJXRg@mail.gmail.com>
Subject: Re: [PATCH v1] x86/mtrr: Convert to use match_string() helper
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 10:23 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 4 May 2018, Andy Shevchenko wrote:
>
>> The new helper returns index of the matching string in an array.
>
> new helper? match_string() is in tree for 2 years.

Old template.

>> We are going to use it here.
>
> Are we going to use it ? When?
>
> "Replace the open coded array lookup." or something like that would be more
> appropriate.

Will change this.
Thanks for review!

-- 
With Best Regards,
Andy Shevchenko
