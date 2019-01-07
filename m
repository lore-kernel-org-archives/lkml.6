Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED37C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25462147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfAGS4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:56:52 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:57096 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfAGS4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:56:52 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=[192.168.66.118]); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gga4l-0007sx-I4; Mon, 07 Jan 2019 19:56:39 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
 <9260c3aa-5c52-c35d-7a6a-ef5c58b82b10@leemhuis.info>
 <20190103111211.14a81d95@lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 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
 5iv6NKaV29GWHbY=
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
Message-ID: <fc9a76ab-9327-47ed-5597-b3b1ce8b8580@leemhuis.info>
Date:   Mon, 7 Jan 2019 19:56:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190103111211.14a81d95@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1546887410;4537d55c;
X-HE-SMSGID: 1gga4l-0007sx-I4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.01.19 um 19:12 schrieb Jonathan Corbet:
> On Fri, 21 Dec 2018 16:26:31 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>> Here's an idea if you feel like improving this: rather than putting an
>>> inscrutable program inline, add a taint_status script to scripts/ that
>>> prints out the status in fully human-readable form, with the explanation
>>> for every set bit.  
>> I posted the script earlier today and noticed now that it prints only
>> the fully human-readable form, not if a bit it set or unset. Would you
>> prefer if it did that as well?
> Not sure I have an opinion; perhaps if it can be done in a readable way
> putting more information is better than less.

I think I found a way, the script output looks like this now:

Kernel is Tainted for following reasons:
 * Proprietary module was loaded (#0)
 * Kernel issued warning (#9)
 * Externally-built ('out-of-tree') module was loaded  (#12)
For a more detailed explanation of the various taint flags see
 Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel sources
 or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
Raw taint value as int/string: 4609/'P        W  O    
 
>>>> +===  ===  ======  ========================================================
>>>> +Bit  Log     Int  Reason that got the kernel tainted
>>>> +===  ===  ======  ========================================================
>>>> + 1)  G/P       0  proprietary module got loaded  
>>> I'd s/got/was/ throughout.  Also, this is the kernel, we start counting at
>>> zero! :)  
>> Hehe, yeah :-D At first I actually started at zero, but that looked
>> odd as the old explanations (those already in the file) start to could at one.
>> Having a off-by-one within one document is just confusing, that's why I
>> decided against starting at zero here.
>> Another reason that came to my mind when reading your comment: Yes, this
>> is the kernel, but the document should be easy to understand even for
>> inexperienced users (e.g. people that know how to open and use command
>> line tools, but never learned programming). That's why I leaning towards
>> starting with one everywhere. But yes, that can be confusing, that's
>> why I added a note, albeit I'm not really happy with it yet:
>> """
>> Note: This document is aimed at users and thus starts to count at one here and
>> in other places.  Use ``seq 0 17`` instead to start counting at zero, as it's
>> normal for developers.
>> """
>> See below for full context. Anyway: I can change the text to start at zero if
>> you prefer it.
> This is a kernel document in the end, so I do really think that we should
> be consistent with kernel conventions.  

Okay. I still don't like it, but well, maybe your are right. And in the
end we can change it easily later if we want to.
 
> [...]
>>  3)  ``S`` if the oops occurred on an SMP kernel running on hardware that
>>      hasn't been certified as safe to run multiprocessor.
>>      Currently this occurs only on various Athlons that are not
>>      SMP capable.
> I wonder if any such hardware has ever run anything remotely resembling a
> current kernel.  In any case, a quick grep suggests that this taint can be
> set in a number of other places as well.

I looked into this and...
 
> [...]
>>  11) ``C`` if a staging driver has been loaded.
> There's a couple of other situations where this one is set as well; not
> sure if it's worth the trouble to try to describe them.

...this, but decided that takes things too far for now. Thus I'll leave 
those as they are for now, but will take a closer look and start a discussion
dedicated to this with the relevant parties that use those flags.
 
>>  17) ``X`` Auxiliary taint, defined for and used by Linux distributors.
> Do we know anything about whether anybody uses this?

Seems SUSE does: https://www.suse.com/de-de/support/kb/doc/?id=3582750 
Or at least did in the not to distant past, which I'd say is good enough 
for now.

> [...]
> Overall, just nits except for the start-with-zero thing.

All the other nits stripped from the reply fixed, will sent out and 
update patch series tomorrow.

Side note FYI: While at it I decided to update the tainted section in 
Documentation/sysctl/kernel.txt and reuse the short description
used it the table of the revamped tainted-kernels.rst, which results
in the patch at the end (sigh, this patch slowly gets too big):

Ciao, Thorsten

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 1b8775298cf7..8e1c21e1fdf6 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -93,7 +93,7 @@ show up in /proc/sys/kernel:
 - stop-a                      [ SPARC only ]
 - sysrq                       ==> Documentation/admin-guide/sysrq.rst
 - sysctl_writes_strict
-- tainted
+- tainted                     ==> Documentation/admin-guide/tainted-kernels.rst
 - threads-max
 - unknown_nmi_panic
 - watchdog
@@ -1005,36 +1005,31 @@ compilation sees a 1% slowdown, other systems and workloads may vary.
 
 ==============================================================
 
-tainted:
+tainted
 
 Non-zero if the kernel has been tainted. Numeric values, which can be
 ORed together. The letters are seen in "Tainted" line of Oops reports.
 
-     1 (P):  A module with a non-GPL license has been loaded, this
-             includes modules with no license.
-             Set by modutils >= 2.4.9 and module-init-tools.
-     2 (F): A module was force loaded by insmod -f.
-            Set by modutils >= 2.4.9 and module-init-tools.
-     4 (S): Unsafe SMP processors: SMP with CPUs not designed for SMP.
-     8 (R): A module was forcibly unloaded from the system by rmmod -f.
-    16 (M): A hardware machine check error occurred on the system.
-    32 (B): A bad page was discovered on the system.
-    64 (U): The user has asked that the system be marked "tainted". This
-            could be because they are running software that directly modifies
-            the hardware, or for other reasons.
-   128 (D): The system has died.
-   256 (A): The ACPI DSDT has been overridden with one supplied by the user
-            instead of using the one provided by the hardware.
-   512 (W): A kernel warning has occurred.
-  1024 (C): A module from drivers/staging was loaded.
-  2048 (I): The system is working around a severe firmware bug.
-  4096 (O): An out-of-tree module has been loaded.
-  8192 (E): An unsigned module has been loaded in a kernel supporting module
-            signature.
- 16384 (L): A soft lockup has previously occurred on the system.
- 32768 (K): The kernel has been live patched.
- 65536 (X): Auxiliary taint, defined and used by for distros.
-131072 (T): The kernel was built with the struct randomization plugin.
+     1 (P): proprietary module was loaded
+     2 (F): module was force loaded
+     4 (S): SMP kernel oops on an officially SMP incapable processor
+     8 (R): module was force unloaded
+    16 (M): processor reported a Machine Check Exception (MCE)
+    32 (B): bad page referenced or some unexpected page flags
+    64 (U): taint requested by userspace application
+   128 (D): kernel died recently, i.e. there was an OOPS or BUG
+   256 (A): an ACPI table was overridden by user
+   512 (W): kernel issued warning
+  1024 (C): staging driver was loaded
+  2048 (I): workaround for bug in platform firmware applied
+  4096 (O): externally-built ("out-of-tree") module was loaded
+  8192 (E): unsigned module was loaded
+ 16384 (L): soft lockup occurred
+ 32768 (K): kernel has been live patched
+ 65536 (X): Auxiliary taint, defined and used by for distros
+131072 (T): The kernel was built with the struct randomization plugin
+
+See Documentation/admin-guide/tainted-kernels.rst for more information.
 
 ==============================================================
 
