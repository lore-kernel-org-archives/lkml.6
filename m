Return-Path: <deanbo422@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-201413-1517899182-2-8976566141210255220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.214.68', Host='mail-it0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: deanbo422@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517899181; b=u7vronHHsqjlltvmoDUUe+6ha3FFCo1LKhma/0DfSbD/fJw
    HWnZRGWjnZetTFpF8e95mFNgMtCEW21hCmNJGcD2nN+IeWZNe+hX/uSdmNxyiE4z
    RNuIrvVCpxWGfv9OUIp7kX0i/5Ig+YFfJEVGZlbP+r9j3SnRohfk5YpBbQOH8X6e
    wY+qM7Gm9dQWBVhsxBgUQ5J++gPDP8ZaLD1lhxHA2nuqljApWyR5KHt5jWMAeAjG
    nWJCSkzzuyQclVnSIkKL9VhutxWUPdbF3Gae2vMTUsoTGHbxRQoMPcvk1ETqPikq
    6KjVHU3zXsM+eaWRCc3pENoaD4y52jcDT2HT+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1517899181; bh=s1fC83Llk79JI4hIwXw7om4h9eyT5Pt45OV0JtDusaU=; b=e
    VoWD9DXSLScooIpG29fOouJsLpn0CmTq2pB/b1n0oMf+ck167ln5VZ3QQv6OStDT
    n57eSrZHTs2Ir4g3laSaUqmGlyHdjomO+jQqXBWwqpPbWmQYKVzZpyFr/WnfsvKe
    MT3Z0WKzyaX6YeD4A5gEvwHUZyWEuKt5vwh3ga9aLmfoWmYqMG52pasGA+TmA/hB
    lHA6EO/5xlyyt5s+FNCP5KOkU6ijS/HAkSrGhOpMYyImdU2uheu1WsTnmCenREiH
    Ns+DI6BqGpJBoTkrUTqMByaVmxLKJ+QDwpW6GbtOKoktORh61/5LgV7lXIAMFPsq
    IfFnb+UXssztEzbB9rarg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uneBW0N/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.214.68 (mail-it0-f68.google.com);
    spf=pass smtp.mailfrom=deanbo422@gmail.com smtp.helo=mail-it0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i9VQ58If;
    x-ptr=pass x-ptr-helo=mail-it0-f68.google.com x-ptr-lookup=mail-it0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uneBW0N/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.214.68 (mail-it0-f68.google.com);
    spf=pass smtp.mailfrom=deanbo422@gmail.com smtp.helo=mail-it0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i9VQ58If;
    x-ptr=pass x-ptr-helo=mail-it0-f68.google.com x-ptr-lookup=mail-it0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225CK4rYTk3jl9lvvWva5ln74j8bbAiwe1WTMG0I62RE2wIbv16unCkniVWCOhcskrGAYE4kl5mfZkphm1TKC6c=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0eeJKAOZjJ-XVQwLOCuVzSqdUtCaS4F90zZ=WvRQ8sBQ@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e145c39b3c50b3aee05bc60ad0117f1ec7cc5153.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2HR6be9Fm+o1Oq-V5p51xEiuhbyqkgVWprD5BxuU29xQ@mail.gmail.com>
 <CAJsyPhyGpJVQegd7ns9oZOjM=XsGVixCQaH9nT_jOQsSpyRs+g@mail.gmail.com> <CAK8P3a0eeJKAOZjJ-XVQwLOCuVzSqdUtCaS4F90zZ=WvRQ8sBQ@mail.gmail.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Tue, 6 Feb 2018 14:39:38 +0800
Message-ID: <CAJsyPhxmZx_S=imSxDyW3POhRcHd66q1p0kkX0B4f-W2APxJkA@mail.gmail.com>
Subject: Re: [PATCH v6 20/36] nds32: Signal handling support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>,
	Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>,
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	Vincent Chen <vincentc@andestech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks, I got it.

After referring to arm64 and risc-v, we try to refine our code, such as
removing unneeded checking and refining syscall restart flow. We
hope these modifications can enhance the reliability and readability.
However, the following 2 files which you had acked are included in
this modification.
1. arch/nds32/include/asm/nds32.h
    (patch: Assembly macros and definitions)
     The definition of  macro tbl and why are removed.
       - Now, we use pt_reg->syscallno instead of 'why' to determine
         whether entering kernel is via syscall or not. Therefore, macro
         'why' is unneeded.

--- a/arch/nds32/include/asm/nds32.h
+++ b/arch/nds32/include/asm/nds32.h
@@ -66,10 +66,6 @@ static inline unsigned long CACHE_LINE_SIZE

 #endif /* __ASSEMBLY__ */

-/* tbl and why is used in ex-scall.S and ex-exit.S */
-#define tbl $r8
-#define why $r8
-
 #define IVB_BASE               PHYS_OFFSET


2. arch/nds32/kernel/ex-scall.S    (patch: System calls handling)
    a. Define macro tbl
        - The marco tbl is used only in this file. So, I move its definition
          from arch/nds32/include/asm/nds32.h to here.
    b. Remove 'set why = 0'  when issuing syscall number is invalid
    c. Adjust input arguments of syscall_trace_enter

--- a/arch/nds32/kernel/ex-scall.S
+++ b/arch/nds32/kernel/ex-scall.S
...
+#define tbl $r8

 /*
  * $r7 will be writen as syscall nr
- * by retrieving from $ITYPE 'SWID' bitfiled
  */
        .macro  get_scno
        lwi     $r7, [$sp + R15_OFFSET]
@@ -54,7 +49,6 @@ ENTRY(eh_syscall)
        get_scno
        gie_enable

-ENTRY(eh_syscall_phase_2)
        lwi     $p0, [tsk+#TSK_TI_FLAGS]

        andi    $p1, $p0, #_TIF_WORK_SYSCALL_ENTRY
@@ -71,7 +65,6 @@ jmp_systbl:
        jr      $p1                             ! no return

 _SCNO_EXCEED:
-       movi    why, 0
        ori     $r0, $r7, #0
        ori    $r1, $sp, #0
        b       bad_syscall
@@ -81,8 +74,7 @@ _SCNO_EXCEED:
  * context switches, and waiting for our parent to respond.
  */
 __sys_trace:
-       move    $r1, $sp
-       move    $r0, $r7                        ! trace entry [IP = 0]
+       move    $r0, $sp
        bal     syscall_trace_enter
        move    $r7, $r0
        la      $lp, __sys_trace_return         ! return address


If you think these modifications in acked files are not permitted,
we will recover it.

We verify all modifications by LTP 2017 related cases and glibc
2.26 testsuite. We plan to add it in the next version patch and
hope you can give us some comments as before.

Thanks

Vincent



2018-01-24 19:13 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Jan 24, 2018 at 1:56 AM, Vincent Chen <deanbo422@gmail.com> wrote:
>> 2018-01-18 18:30 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> From: Greentime Hu <greentime@andestech.com>
>>>>
>>>> This patch adds support for signal handling.
>>>>
>>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>>
>>> I never feel qualified enough to properly review signal handling code, so
>>> no Ack from me for this code even though I don't see anything wrong with it.
>>> Hopefully someone else can give an Ack after looking more closely.
>>>
>>
>> Dear Arnd:
>>
>> We'd be glad to improve signal handling code to meet your requirement.
>> Could you
>> tell us which part we need to refine or which implementation is good
>> for us to refer?
>
> No, as I said, the problem is on my side, I just don't understand enough of it.
> I would assume that the arm64 and risc-v implementations are the most
> thoroughly reviewed, but haven't looked at those in enough detail either.
> If your code does something that risc-v doesn't do, try to understand whether
> there should be a difference or not.
>
>       Arnd
