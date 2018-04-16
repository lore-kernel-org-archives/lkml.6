Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3595654-1523894810-2-7206037108210026534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523894810; b=vTFliu+qnH8Ze1QJZ0+7i19pmynaKhPVrprYjjjjvHLLuPcGLf
    2F0Y2HqC5du61br8ewNaY8PtdzORwASJcqkK2oQewFEwPHUFXFb/g3+JAAi9grtR
    Lz7C29ihkiplh3HYv39GafykPRQ5n3qNSnTpbE8HHY2inpmnbYewXERAu01Q4s4q
    LxxUqo6TRtWd6pQGCXpltngzVGho7cmafl/TFRLo6DOW9fA2T4K1FT8Hqwfr1L+v
    StbnR6Xbe+7KZ0GD7I9qbKAihO961sXJY+6jsG7BCJGs+hgyH0/MMSHew2M6IsJ1
    X0lMbmLDUxp3cSpcDlycgjMEa2us2xlX40Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523894810; bh=33TVCAydUPr8bz7kgZ3/ggouLpUrc/
    JIuojzumOFNMY=; b=Y9yaAHVSIXDxoTTyJN9algPBtb92Z9dD7t0JIJ6PhNlVo0
    /gSaw6OlsIknjIu5n60ywUZc6tBtXoe0M1D8poT6xxAiLTWPbGw8+Jek0rgggN7m
    v6I0ucyOi/GEfL1NS0dztk/nN/2GsHYq4GigkTP10fPVRfdQyBgEfyxKeICMB6v4
    6ex62XO7FCsC7gSF6BOTuNm7AfxNrc+H73O0M2EkTQMw0+ZWKtEVRgDqc+IQVdrr
    soxvDe/MXMcQCNIg24KqrBFNlQyj30OpS9Juz1pjKNiJefgcTHtgXduRIaSyK9b5
    ruVT+XHcVxPn1CmXcvxSmvBL9yvddO1SL4dyg9ow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=morinfr.org header.i=@morinfr.org header.b=Vlj1gCa+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170427;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=morinfr.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=morinfr.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=morinfr.org header.i=@morinfr.org header.b=Vlj1gCa+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170427;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=morinfr.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=morinfr.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIAQQ5PKhhVGXn6jp3cWRrFhWJX2y78l6F6dC/pMyJungKnYDxH6yBk0j7Ggii8x+kP2LSf7X2YG6YaXDIdMVehvhUjHQQehySdU+7Nuz9UoMVjuFNhi
    0fVA/CXLw+kms/UTNAF5IvqpH9wkZ/wrXuUv3Zf4xoz5U3OQ2X8s1Lrt5nnnDCbO6aSgQ6NYXSF2gQr0t0z/wlwygqTSjVqGcGgARimUbZ+45Eoi+8nw7eFw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=oHCsiuIfAAAA:8 a=EePCTitOv4r-aG-WyjYA:9 a=_LRuFIMeJx80u_h7:21
    a=H0Alytw_npKQh7cX:21 a=CjuIK1q_8ugA:10 a=UHnoZFfxFVgncpI3GP2V:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeDPQGf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:06:35 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:15262 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752831AbeDPQGe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:06:34 -0400
Date: Mon, 16 Apr 2018 18:06:31 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: Jan Kara <jack@suse.cz>
Cc: Pavlos Parissis <pavlos.parissis@gmail.com>,
        stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180416160631.2jepytqz5phrg3g3@bender.morinfr.org>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
        Pavlos Parissis <pavlos.parissis@gmail.com>, stable@vger.kernel.org,
        decui@microsoft.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16 Apr 16:40, Jan Kara wrote:
> Can you please run RIP through ./scripts/faddr2line to see where exactly
> are we looping? I expect the loop iterating over marks to notify but better
> be sure.
> 
> How easily can you hit this? Are you able to run debug kernels / inspect
> crash dumps when the issue occurs? Also testing with the latest mainline
> kernel (4.16) would be welcome whether this isn't just an issue with the
> backport of fsnotify fixes from Miklos.

I do have one proper kernel crash dump for one of the lockups we saw

PID: 30407  TASK: ffff9584913b2180  CPU: 8   COMMAND: "python"
 #0 [ffff959cb7883d80] machine_kexec at ffffffff890561ff
 #1 [ffff959cb7883dd8] __crash_kexec at ffffffff890f6dde
 #2 [ffff959cb7883e90] panic at ffffffff89074f03
 #3 [ffff959cb7883f10] watchdog_timer_fn at ffffffff89117388
 #4 [ffff959cb7883f40] __hrtimer_run_queues at ffffffff890dc65c
 #5 [ffff959cb7883f88] hrtimer_interrupt at ffffffff890dcb76
 #6 [ffff959cb7883fd8] smp_apic_timer_interrupt at ffffffff89802f6a
 #7 [ffff959cb7883ff0] apic_timer_interrupt at ffffffff8980227d
--- <IRQ stack> ---
 #8 [ffffafa5c894f880] apic_timer_interrupt at ffffffff8980227d
    [exception RIP: unknown or invalid address]
    RIP: 0000000000000000  RSP: ffffffff8a696820  RFLAGS: 00000002
    RAX: ffff95908f520c20  RBX: 0000000000000000  RCX: 0000000000000000
    RDX: ffff959c83c4d000  RSI: 0000000000000000  RDI: ffffafa5c894f9f8
    RBP: 0000000053411000   R8: 0000000000000000   R9: ffff95908f520c48
    R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000001000
    R13: 0000000000001000  R14: 0000000000001000  R15: 0000000053410000
    ORIG_RAX: 0000000000000000  CS: 0000  SS: ffffffffffffff10
bt: WARNING: possibly bogus exception frame
 #9 [ffffafa5c894f928] fsnotify at ffffffff892293e7
#10 [ffffafa5c894f9e8] __fsnotify_parent at ffffffff89229686
#11 [ffffafa5c894fa48] __kernel_write at ffffffff891e9962
#12 [ffffafa5c894fa70] dump_emit at ffffffff892445af
#13 [ffffafa5c894faa8] elf_core_dump at ffffffff8923f546
#14 [ffffafa5c894fc60] do_coredump at ffffffff89244c3f
#15 [ffffafa5c894fda0] get_signal at ffffffff89083ed0
#16 [ffffafa5c894fe18] do_signal at ffffffff89028323
#17 [ffffafa5c894ff10] exit_to_usermode_loop at ffffffff8900308c
#18 [ffffafa5c894ff38] prepare_exit_to_usermode at ffffffff89003753
    RIP: 00007f69706935c3  RSP: 00007ffeb8c1b4a8  RFLAGS: 00010206
    RAX: 00007f686d200034  RBX: 00005591f24f0170  RCX: 00007f68cb800000
    RDX: 00007f696d200000  RSI: 0000000000000061  RDI: 00007f686d200034
    RBP: 00007f686d200010   R8: ffffffffffffffff   R9: 00000000000000ff
    R10: 00000000e0a9a400  R11: 0000000000000246  R12: 0000000100000000
    R13: 0000000100000000  R14: 0000000000000000  R15: 0000000000000083
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

faddr2line gives "fsnotify at fs/notify/fsnotify.c:368" (it's a 4.14.22).  So
it does seem that you were right about the location.

This happens with systemd handling coredumps.  It's using fsnotify to learn
about new dumps.

Note that on this machine, the dumps are on a loop mount:
/dev/loop0 /usr/cores ext4 rw,relatime,data=ordered 0 0

-- 
Guillaume Morin <guillaume@morinfr.org>
