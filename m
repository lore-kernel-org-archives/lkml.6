Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D66EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E6D21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfACJdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:33:03 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:34830 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbfACJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:33:02 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=[192.168.66.118]); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gezN4-0001KU-Sz; Thu, 03 Jan 2019 10:32:58 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
 <9260c3aa-5c52-c35d-7a6a-ef5c58b82b10@leemhuis.info>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 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
 5iv6NKaV29GWHbY=
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
Message-ID: <dd132506-c53b-216d-bd2a-fc21ec2392ce@leemhuis.info>
Date:   Thu, 3 Jan 2019 10:32:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <9260c3aa-5c52-c35d-7a6a-ef5c58b82b10@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1546507981;f913e40f;
X-HE-SMSGID: 1gezN4-0001KU-Sz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan! If you have a minute could you provide feedback on below
mail? I sent it right before Christmas to get it of my todo list, but
due to the timing it afaics fell through the cracks a bit, as I had
feared already (no worries). Ciao, Thorsten

Am 21.12.18 um 16:26 schrieb Thorsten Leemhuis:
> Hi! Am 17.12.18 um 19:24 schrieb Jonathan Corbet:
>> On Mon, 17 Dec 2018 16:20:42 +0100
>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>>> +might be relevant later when investigating problems. Don't worry
>>> +yourself too much about this, most of the time it's not a problem to run
>> s/yourself//
> 
> Thx for this and other suggestions or fixes, consider them implemented when
> not mentioned in this mail. Find the current state of the text at the end of
> this mail for reference.
>  
>> [...]
>>> +At runtime, you can query the tainted state by reading
>>> +``/proc/sys/kernel/tainted``. If that returns ``0``, the kernel is not
>>> +tainted; any other number indicates the reasons why it is. You might
>>> +find that number in below table if there was only one reason that got
>>> +the kernel tainted. If there were multiple reasons you need to decode
>>> +the number, as it is a bitfield, where each bit indicates the absence or
>>> +presence of a particular type of taint. You can use the following python
>>> +command to decode::
>> Here's an idea if you feel like improving this: rather than putting an
>> inscrutable program inline, add a taint_status script to scripts/ that
>> prints out the status in fully human-readable form, with the explanation
>> for every set bit.
> 
> I posted the script earlier today and noticed now that it prints only
> the fully human-readable form, not if a bit it set or unset. Would you
> prefer if it did that as well?
> 
>>> +===  ===  ======  ========================================================
>>> +Bit  Log     Int  Reason that got the kernel tainted
>>> +===  ===  ======  ========================================================
>>> + 1)  G/P       0  proprietary module got loaded
>> I'd s/got/was/ throughout.  Also, this is the kernel, we start counting at
>> zero! :)
> 
> Hehe, yeah :-D At first I actually started at zero, but that looked
> odd as the old explanations (those already in the file) start to could at one.
> Having a off-by-one within one document is just confusing, that's why I
> decided against starting at zero here.
> 
> Another reason that came to my mind when reading your comment: Yes, this
> is the kernel, but the document should be easy to understand even for
> inexperienced users (e.g. people that know how to open and use command
> line tools, but never learned programming). That's why I leaning towards
> starting with one everywhere. But yes, that can be confusing, that's
> why I added a note, albeit I'm not really happy with it yet:
> 
> """
> Note: This document is aimed at users and thus starts to count at one here and
> in other places.  Use ``seq 0 17`` instead to start counting at zero, as it's
> normal for developers.
> """
> 
> See below for full context. Anyway: I can change the text to start at zero if
> you prefer it.
> 
> Ciao, Thorsten
> 
> ---
> 
> Tainted kernels
> ---------------
> 
> The kernel will mark itself as 'tainted' when something occurs that might be
> relevant later when investigating problems. Don't worry too much about this,
> most of the time it's not a problem to run a tainted kernel; the information is
> mainly of interest once someone wants to investigate some problem, as its real
> cause might be the event that got the kernel tainted. That's why bug reports
> from tainted kernels will often be ignored by developers, hence try to reproduce
> problems with an untainted kernel.
> 
> Note the kernel will remain tainted even after you undo what caused the taint
> (i.e. unload a proprietary kernel module), to indicate the kernel remains not
> trustworthy. That's also why the kernel will print the tainted state when it
> notices an internal problem (a 'kernel bug'), a recoverable error
> ('kernel oops') or a non-recoverable error ('kernel panic') and writes debug
> information about this to the logs ``dmesg`` outputs. It's also possible to
> check the tainted state at runtime through a file in ``/proc/``.
> 
> 
> Tainted flag in bugs, oops or panics messages
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> You find the tainted state near the top in a line starting with 'CPU:'; if or
> why the kernel is shown after the Process ID ('PID:') and a shortened name of
> the command ('Comm:') that triggered the event:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> Oops: 0002 [#1] SMP PTI
> CPU: 0 PID: 4424 Comm: insmod Tainted: P        W  O      4.20.0-0.rc6.fc30 #1
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> RIP: 0010:my_oops_init+0x13/0x1000 [kpanic]
> [...]
> 
> You'll find a **'Not tainted: '** there if the kernel was not tainted at the
> time of the event; if it was, then it will print **'Tainted: '** and characters
> either letters or blanks. The meaning of those characters is explained in the
> table below. In above example it's '``Tainted: P        W  O     ``' as as the
> kernel got tainted earlier because a proprietary Module (``P``) was loaded, a
> warning occurred (``W``), and an externally-built module was loaded (``O``).
> To decode other letters use the table below.
> 
> 
> Decoding tainted state at runtime
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> At runtime, you can query the tainted state by reading
> ``cat /proc/sys/kernel/tainted``. If that returns ``0``, the kernel is not
> tainted; any other number indicates the reasons why it is. The easiest way to
> decode that number is the script ``tools/debugging/kernel-chktaint``, which your
> distribution might ship as part of a package called ``linux-tools`` or
> ``kernel-tools``; if it doesn't you can download the script from
> `git.kernel.org <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/debugging/kernel-chktaint>`_.
> and execute it with ``sh kernel-chktaint``
> 
> If you do not want to run that script you can try to decode the number yourself.
> That's easy if there was only one reason that got your kernel tainted, as in
> this case you can find the number with the table below. If there were multiple
> reasons you need to decode the number, as it is a bitfield, where each bit
> indicates the absence or presence of a particular type of taint. It's best to
> leave that to the aforementioned script, but if you need something quick you can
> use this shell command to check which bits are set:
> 
> 	$ for i in $(seq 18); do echo $i $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
> 
> Note: This document is aimed at users and thus starts to count at one here and
> in other places.  Use ``seq 0 17`` instead to start counting at zero, as it's
> normal for developers.
> 
> Table for decoding tainted state
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ====  ===  ======  ========================================================
> Pos.  Log  Number  Reason that got the kernel tainted
> ====  ===  ======  ========================================================
>   1)  G/P       0  proprietary module was loaded
>   2)  _/F       2  module was force loaded
>   3)  _/S       4  SMP kernel oops on an officially SMP incapable processor
>   4)  _/R       8  module was force unloaded
>   5)  _/M      16  processor reported a Machine Check Exception (MCE)
>   6)  _/B      32  bad page referenced or some unexpected page flags
>   7)  _/U      64  taint requested by userspace application
>   8)  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
>   9)  _/A     256  ACPI table overridden by user
>  10)  _/W     512  kernel issued warning
>  11)  _/C    1024  staging driver was loaded
>  12)  _/I    2048  workaround for bug in platform firmware applied
>  13)  _/O    4096  externally-built ("out-of-tree") module was loaded
>  14)  _/E    8192  unsigned module was loaded
>  15)  _/L   16384  soft lockup occurred
>  16)  _/K   32768  Kernel live patched
>  17)  _/K   65536  Auxiliary taint, defined for and used by distros
>  18)  _/K  131072  Kernel was built with the struct randomization plugin
> ====  ===  ======  ========================================================
> 
> Note: To make reading easier ``_`` is representing a blank in this
> table.
> 
> More detailed explanation for tainting
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  1)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
>      any proprietary module has been loaded.  Modules without a
>      MODULE_LICENSE or with a MODULE_LICENSE that is not recognised by
>      insmod as GPL compatible are assumed to be proprietary.
> 
>  2)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
>      modules were loaded normally.
> 
>  3)  ``S`` if the oops occurred on an SMP kernel running on hardware that
>      hasn't been certified as safe to run multiprocessor.
>      Currently this occurs only on various Athlons that are not
>      SMP capable.
> 
>  4)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
>      modules were unloaded normally.
> 
>  5)  ``M`` if any processor has reported a Machine Check Exception,
>      ``' '`` if no Machine Check Exceptions have occurred.
> 
>  6)  ``B`` if a page-release function has found a bad page reference or
>      some unexpected page flags.
> 
>  7)  ``U`` if a user or user application specifically requested that the
>      Tainted flag be set, ``' '`` otherwise.
> 
>  8)  ``D`` if the kernel has died recently, i.e. there was an OOPS or BUG.
> 
>  9)  ``A`` if the ACPI table has been overridden.
> 
>  10) ``W`` if a warning has previously been issued by the kernel.
>      (Though some warnings may set more specific taint flags.)
> 
>  11) ``C`` if a staging driver has been loaded.
> 
>  12) ``I`` if the kernel is working around a severe bug in the platform
>      firmware (BIOS or similar).
> 
>  13) ``O`` if an externally-built ("out-of-tree") module has been loaded.
> 
>  14) ``E`` if an unsigned module has been loaded in a kernel supporting
>      module signature.
> 
>  15) ``L`` if a soft lockup has previously occurred on the system.
> 
>  16) ``K`` if the kernel has been live patched.
> 
>  17) ``X`` Auxiliary taint, defined for and used by Linux distributors.
> 
>  18) ``T`` Kernel was build with randstruct plugin, which can intentionally
>      produce extremely unusual kernel structure layouts (even performance
>      pathological ones), which is important to know when debugging. Set at
>      build time.
> 
