Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932404AbeCMMvw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:51:52 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:40034 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeCMMvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:51:50 -0400
X-Google-Smtp-Source: AG47ELsiqN0TBF9XP4nXpdQ2HnidgD6N1E9CQ7Tn0u/FODa1jq+RjeQ0nVJlntEMqzwROElLbCVTznenm3QePHDi+mM=
MIME-Version: 1.0
In-Reply-To: <bf12c497-db2a-f1f0-efc3-07e6a6ee9daa@redhat.com>
References: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
 <29c1640a-cf19-ca19-7de9-96f202edfb5a@redhat.com> <CA+zpnLebtbjbA-Jg+RvMOqwDE5R--9V3hTwMk95Br4vM1LgBjQ@mail.gmail.com>
 <010001620bafa06b-41525407-603e-40a9-ba11-6033b2f5dcc7-000000@email.amazonses.com>
 <CA+zpnLdmg30Beg+uUJNgBQ5gbjXuJ0uVhyzCgf6m7xbx2yARBg@mail.gmail.com>
 <CAKv+Gu-KPU+kQ0z3jJ+CcgNPq3PuqjF_CCB_2LR_5VoYaynTJw@mail.gmail.com>
 <010001621a9e5069-0b1a6328-97e4-4396-9438-b90f5b8c82a4-000000@email.amazonses.com>
 <CAKv+Gu8+x=5nU9MmYQKKc=3fhMXoUYjGSjYYfhjaFtdGG2NkaA@mail.gmail.com>
 <010001621b287e42-58955302-cc14-4212-b7b0-e6e358633dab-000000@email.amazonses.com>
 <CAKv+Gu_hLR3YNZF=taLM++LdfqmPpGG+vR1O8NfKNP00PNeiYA@mail.gmail.com>
 <CA+zpnLdxGT08citakzZwZsSQAFeTJw-j6S7udHk6-sEJ9R3xpA@mail.gmail.com>
 <010001621b7ce5a3-b80c55b8-be68-4b44-ab52-4949e8ddb8d0-000000@email.amazonses.com>
 <CA+zpnLf=JDUxyorH7yP=08FD_u=+UoQ6ubsKyVLD+4w9raYAKQ@mail.gmail.com> <bf12c497-db2a-f1f0-efc3-07e6a6ee9daa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 14:51:49 +0200
Message-ID: <CAHp75Vdds=iv_aExbAWZBdcrVyR=zzb+BY7_=bNovrrc0oxwsA@mail.gmail.com>
Subject: Re: Regression from efi: call get_event_log before ExitBootServices
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thiebaud Weksteen <tweek@google.com>, Jeremy Cline <jeremy@jcline.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 9:47 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 12-03-18 20:55, Thiebaud Weksteen wrote:

>> Hans, you said you configured the tablet to use the 32-bit version of grub
>> instead
>> of 64. Why's that?

> Because this tablet, like (almost?) all Bay Trail hardware has a 32 bit
> UEFI,
> even though the processor is 64 bit capable (AFAIK 64 bit Windows drivers
> were
> not ready in time so all Bay Trail devices shipped with a 32 bit Windows).

Almost.

Lenovo Thinkpad 10 tablet has 64-bit firmware.

-- 
With Best Regards,
Andy Shevchenko
