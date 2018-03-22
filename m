Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeCVLIb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:08:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33195 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeCVLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:08:28 -0400
X-Google-Smtp-Source: AG47ELvsw0KQejnSFCHwek4fAGOV9HxzEkvcmGbW1z5RP3M0gL/vsWoKMrcL1v+Rk4Ucg0vE0FShWX0V4hOH5gqMf+U=
MIME-Version: 1.0
In-Reply-To: <20180321181856.GA7890@roeck-us.net>
References: <20180316152259.964532775@linuxfoundation.org> <20180316152303.262268098@linuxfoundation.org>
 <20180316225537.GA5989@anatevka.americas.hpqcorp.net> <20180318101416.GD13276@kroah.com>
 <1521587979.23626.117.camel@codethink.co.uk> <CAD9gYJLVS2UVUgqsaJynNjeUcg9oDxhPX26narY6eXW_2kwPAA@mail.gmail.com>
 <20180321181856.GA7890@roeck-us.net>
From: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Date: Thu, 22 Mar 2018 12:08:26 +0100
Message-ID: <CAD9gYJLmWjpEd_ZH6BE7rdR267Vd31MrKdEJMGVVvxd9BzAruQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 29/63] watchdog: hpwdt: fix unused variable warning
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you completed the port to v4.4 already, can you make it available
> for others ?
>
> Thanks,
> Guenter
Hi Guenter,

Sorry for confusion, the part I've ported already pushed to 4.4.118,
the list is just missing part for Ben as a reference.

Cheers,
Jack

>
>> d3eba77440 x86/cpufeatures: Add CPUID_7_EDX CPUID leaf
>> 40532f65cc x86/cpufeatures: Add Intel feature bits for Speculatio
>> c26a6bea26 x86/cpufeatures: Add AMD feature bits for Speculation
>>  Control
>> af57d43c908 x86/msr: Add definitions for new speculation control
>> a8799fd14d x86/pti: Do not enable PTI on CPUs which are not
>>  vulnerable to Meltdown
>> 6c5e49150a x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early
>>  Spectre v2 microcodes
>> 31fd9eda7f6 x86/speculation: Add basic IBPB (Indirect Branch
>>  Prediction Barrier) support
>> 77b3b3ee238 x86/cpufeatures: Clean up Spectre v2 related CPUID
>>  flags
>> 77d1424d2fb x86/retpoline: Simplify vmexit_fill_RSB()
>> d7f8d17406d x86/entry/64: Remove the SYSCALL64 fast path
>> 572e509178 x86/entry/64: Push extra regs right away
>> e06d7bfb223 x86: Introduce __uaccess_begin_nospec() and
>>  uaccess_try_nospec
>> ae75f83e79 x86/usercopy: Replace open coded stac/clac with
>>  __uaccess_{begin, end}
>> 065eae4be83 x86/uaccess: Use __uaccess_begin_nospec() and
>>  uaccess_try_nospec
>> cda6b6074cc6f9 x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature
>>  bits on Intel
>> 4b234a253e52 x86/pti: Mark constant arrays as __initconst
>> b7649e1776706 KVM: nVMX: mark vmcs12 pages dirty on L2 exit
>> 46e24dfc2df KVM: nVMX: Eliminate vmcs02 pool
>> ff546f9d83d3 KVM: VMX: introduce alloc_loaded_vmcs
>> 6236b782eba37 KVM: VMX: make MSR bitmaps per-VCPU
>> 7013129a403 KVM/x86: Add IBPB support
>> 755502f810c6 KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
>> e5a83419c957 KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
>> fc00dde96099a1 KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL
>>
>> commit id is from linux-4.9.y
>>
>> Might be more due to dependency.
>>
>> Thanks,
>> Jack Wang
