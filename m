Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeC1A6R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:58:17 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43707 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbeC1A6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:58:16 -0400
X-Google-Smtp-Source: AIpwx49sZ7DbJzeY1wOe11MMJ3w21vwXAe9kwZuTInHD81ONeL7YO1BOjejSTHjSLVWKC8vi4MJnqQGlesooyXl3thc=
MIME-Version: 1.0
In-Reply-To: <201803280558.NGUoaoTS%fengguang.wu@intel.com>
References: <1522141616-9825-3-git-send-email-wanpengli@tencent.com> <201803280558.NGUoaoTS%fengguang.wu@intel.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 28 Mar 2018 08:58:15 +0800
Message-ID: <CANRm+CxXz-3VrWZvva72rjkDa7Q5h37zXWkgRPafOtU-OT-gzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: X86: Add Force Emulation Prefix for "emulate
 the next instruction"
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-28 5:15 GMT+08:00 kbuild test robot <lkp@intel.com>:
> Hi Wanpeng,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on kvm/linux-next]
> [also build test WARNING on next-20180327]
> [cannot apply to v4.16-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Wanpeng-Li/KVM-X86-Add-Force-Emulation-Prefix-for-emulate-the-next-instruction/20180328-025804
> base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> arch/x86/kvm/x86.c:149:20: sparse: symbol 'force_emulation_prefix' was not declared. Should it be static?
>    arch/x86/kvm/x86.c:2196:38: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const [noderef] <asn:1>*<noident> @@    got d const [noderef] <asn:1>*<noident> @@
>    arch/x86/kvm/x86.c:2196:38:    expected void const [noderef] <asn:1>*<noident>
>    arch/x86/kvm/x86.c:2196:38:    got unsigned char [usertype] *
>    arch/x86/kvm/x86.c:7911:5: sparse: symbol 'kvm_valid_sregs' was not declared. Should it be static?
>    arch/x86/kvm/x86.c:8786:16: sparse: incompatible types in comparison expression (different address spaces)
>    arch/x86/include/asm/paravirt.h:783:9: sparse: context imbalance in 'vcpu_enter_guest' - unexpected unlock
>
> Please review and possibly fold the followup patch.

Thanks for the report, I will fix it in the next version.

Regards,
Wanpeng Li
