Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeCLLSy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:18:54 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46685 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeCLLSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:18:52 -0400
X-Google-Smtp-Source: AG47ELuOV4cav6dZctb7XtiT1sZT8ZMmtm9CzNaql2bn99IsmFt+6/Mc+FmjHJuTGCyKgGERQHz/5WopBAW/Y1tmOFA=
MIME-Version: 1.0
In-Reply-To: <20180312110122.x7srrgui6r4e7jxm@gmail.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0g7XO2N0vCi-A95MDjgJpTS0M=ZXrSGu2fqkwSHZ79GEg@mail.gmail.com>
 <1519383078.10722.107.camel@linux.intel.com> <1520427371.10722.453.camel@linux.intel.com>
 <20180312110122.x7srrgui6r4e7jxm@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Mar 2018 12:18:51 +0100
X-Google-Sender-Auth: LrLpVcTrBLvj2x8XYgDut-wxagI
Message-ID: <CAJZ5v0hN0SjwLhFiK_5u25CaNVeVXOF=HAd8UrBM3LEU8rgVVQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ACPI / x86: boot: Split out acpi_generic_reduce_hw_init()
 and export
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Mon, Mar 12, 2018 at 12:01 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Fri, 2018-02-23 at 12:51 +0200, Andy Shevchenko wrote:
>> > On Tue, 2018-02-20 at 19:42 +0100, Rafael J. Wysocki wrote:
>> > > On Tue, Feb 20, 2018 at 7:05 PM, Andy Shevchenko
>> > > <andriy.shevchenko@linux.intel.com> wrote:
>> > > > This is a preparation patch to allow override the hardware reduced
>> > > > initialization on ACPI enabled platforms.
>> > > >
>> > > > No functional change intended.
>> > > >
>> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > >
>> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > Thanks, Rafael!
>> >
>> > Ingo, can it be applied?
>>
>> Hmm... It seems Ingo is busy with something else.
>
> Sorry, it all looks good to me:
>
>   Acked-by: Ingo Molnar <mingo@kernel.org>

It depends on some material in -tip AFAICS, so can you apply it, please?
