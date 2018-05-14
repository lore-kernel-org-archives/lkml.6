Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeENMQS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:16:18 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:42380 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeENMQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:16:16 -0400
X-Google-Smtp-Source: AB8JxZqfmGFgldp5wdsvks1Epx4WWAFOPuzNS1bdSiekj1feV/FBs0CvkKaWnGnAosjKTwFLCTXUQpENTtLe6u2FaIs=
MIME-Version: 1.0
In-Reply-To: <20180514072355.GB12198@hirez.programming.kicks-ass.net>
References: <CAEJqkgjMMMwK0Y7xSJCGVnbPor1MirA30HrN=U2EsGZNRQFs8A@mail.gmail.com>
 <20180514072355.GB12198@hirez.programming.kicks-ass.net>
From: Gabriel C <nix.or.die@gmail.com>
Date: Mon, 14 May 2018 14:15:44 +0200
Message-ID: <CAEJqkgh2C_t+pq72Y8uOLYk7nCCtFRnrt1La0hsJL2taa4k35g@mail.gmail.com>
Subject: Re: commit bd9240a18edfbfa72e957fc2ba831cf1f13ea073 seems to break
 with intel-ucode 20180425
To: Peter Zijlstra <peterz@infradead.org>
Cc: kevin.b.stanton@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-14 9:23 GMT+02:00 Peter Zijlstra <peterz@infradead.org>:
> On Sat, May 12, 2018 at 12:55:35PM +0200, Gabriel C wrote:
>> Hi Peter,
>>
>> after updating ucode to 20180425 on my laptop I always hit the
>> 'TSC_DEADLINE disabled' error and so early microcode update from
>> inird breaks.
>>
>> Also I'm able to late load the microcode from command line but
>> not from initrd.
>>
>> Going back to ucode 20180312 make things work again.
>>
>> I've tested on latest 4.16.8 kernel for now.
>>
>> lscpu output:
>
> Please provide /proc/cpuinfo (a single cpu is sufficient) for both
> firmwares.
>
> lscpu (whatever that is) lacks useful information, like the microcode
> version.

ucode 20180312:

http://ftp.frugalware.org/pub/other/people/crazy/ucode/dmesg-ucode-20180312
http://ftp.frugalware.org/pub/other/people/crazy/ucode/cpuinfo-ucode-20180312

ucode 20180425:

http://ftp.frugalware.org/pub/other/people/crazy/ucode/dmesg-ucode-20180425
http://ftp.frugalware.org/pub/other/people/crazy/ucode/cpuinfo-ucode-20180425

Loading microcode manually is working

http://ftp.frugalware.org/pub/other/people/crazy/ucode/reload-late-working-ucode-20180425

Also initramfs is made with dracut and his early microcode option.

Please let me know if you need more infos or want me to test different kernels.

Best Regards,

Gabriel C
