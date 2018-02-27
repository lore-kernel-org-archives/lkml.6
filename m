Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeB0HUP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:20:15 -0500
Received: from goliath.siemens.de ([192.35.17.28]:54151 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeB0HUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:20:14 -0500
Subject: Re: [PATCH 4/6] x86: Consolidate PCI_MMCONFIG configs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <cover.1516601570.git.jan.kiszka@siemens.com>
 <5dcaec50bb59140c1cb63c35ce566ccc02188bcb.1516601570.git.jan.kiszka@siemens.com>
 <CAHp75Vd3AsdOayA0FSaug6L4K+Xx5pk=Eeh4F5mZQsKiV3RxwA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45f0d934-c4cf-fdc7-d7ca-17373c01e733@siemens.com>
Date: Tue, 27 Feb 2018 08:19:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd3AsdOayA0FSaug6L4K+Xx5pk=Eeh4F5mZQsKiV3RxwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-28 18:26, Andy Shevchenko wrote:
> On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Not sure if those two worked by design or just by chance so far. In any
>> case, it's at least cleaner and clearer to express this in a single
>> config statement.
> 
> Congrats! You found by the way a bug in
> 
> commit e279b6c1d329e50b766bce96aacc197eae8a053b
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Tue Nov 6 20:41:05 2007 +0100
> 
>    x86: start unification of arch/x86/Kconfig.*
> 
> ...and proper fix seems to split PCI stuff to common + X86_32 only + X86_64 only
> 

Hmm, is that a change request on this patch?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
