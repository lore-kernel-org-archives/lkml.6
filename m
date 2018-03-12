Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeCLLm0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:42:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32978 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeCLLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:42:23 -0400
X-Google-Smtp-Source: AG47ELstbRhNsgV3WU5a9XoCer0w9UgLX2t+MTM1pJbhuiiiB1l4v8zfqXlT+9fBE8J4G1g91mwLkRkTMXqbB+rfU2s=
MIME-Version: 1.0
In-Reply-To: <20180312113349.seolbpec7e3czad3@gmail.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0g7XO2N0vCi-A95MDjgJpTS0M=ZXrSGu2fqkwSHZ79GEg@mail.gmail.com>
 <1519383078.10722.107.camel@linux.intel.com> <1520427371.10722.453.camel@linux.intel.com>
 <20180312110122.x7srrgui6r4e7jxm@gmail.com> <CAJZ5v0hN0SjwLhFiK_5u25CaNVeVXOF=HAd8UrBM3LEU8rgVVQ@mail.gmail.com>
 <20180312113349.seolbpec7e3czad3@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Mar 2018 12:42:22 +0100
X-Google-Sender-Auth: Qbt-s9n7q7HAO1k-lB7jTdtY0NI
Message-ID: <CAJZ5v0gTzC8bqqzrpHJ_ZaO1LQEdubnGu9ePDoJ+ixPOocYBxA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ACPI / x86: boot: Split out acpi_generic_reduce_hw_init()
 and export
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:33 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> On Mon, Mar 12, 2018 at 12:01 PM, Ingo Molnar <mingo@kernel.org> wrote:
>> >
>> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >
>> >> On Fri, 2018-02-23 at 12:51 +0200, Andy Shevchenko wrote:
>> >> > On Tue, 2018-02-20 at 19:42 +0100, Rafael J. Wysocki wrote:
>> >> > > On Tue, Feb 20, 2018 at 7:05 PM, Andy Shevchenko
>> >> > > <andriy.shevchenko@linux.intel.com> wrote:
>> >> > > > This is a preparation patch to allow override the hardware reduced
>> >> > > > initialization on ACPI enabled platforms.
>> >> > > >
>> >> > > > No functional change intended.
>> >> > > >
>> >> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >> > >
>> >> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> >
>> >> > Thanks, Rafael!
>> >> >
>> >> > Ingo, can it be applied?
>> >>
>> >> Hmm... It seems Ingo is busy with something else.
>> >
>> > Sorry, it all looks good to me:
>> >
>> >   Acked-by: Ingo Molnar <mingo@kernel.org>
>>
>> It depends on some material in -tip AFAICS, so can you apply it, please?
>
> Sure, done!
>
> Once they have passed testing it will live in tip:x86/mm, that's where the
> dependent x86/boot commits ended up in this development cycle.

Thanks!
