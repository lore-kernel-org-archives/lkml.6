Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeBEMK7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:10:59 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40023 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeBEMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:10:41 -0500
X-Google-Smtp-Source: AH8x226UqR9dfWfJ9Fnf0yG2Rb7u1s9mRufLKKNEj9EB/Fh1WGxDxmocNktPj3OJwUozYdULvRY89A==
Date: Mon, 5 Feb 2018 13:10:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [9/8] KVM: x86: limit MSR_IA32_SPEC_CTRL access based on CPUID
 availability
Message-ID: <20180205121036.aevgzwoituzbtif6@gmail.com>
References: <20180109120311.27565-10-pbonzini@redhat.com>
 <6dc02278-7004-1794-3705-69c8cad86be4@oracle.com>
 <CALMp9eSVC=LO-SrPkA3m6eSpgJ6X4rNCRCf3uvtJEdMG_B72cQ@mail.gmail.com>
 <beb9f9b4-7bc0-4a3a-73c2-0828febbd06c@oracle.com>
 <CALMp9eT6i9bhG005S5sqV-Y1RUhsc+AXE42ww8Ej+TXSjD6tEg@mail.gmail.com>
 <1517332457.18619.132.camel@infradead.org>
 <alpine.DEB.2.20.1801301842310.1797@nanos>
 <75049dca-3389-9cc7-44e3-a487a797c605@redhat.com>
 <20180205111034.ie6vbui62wx2irkl@gmail.com>
 <1517829346.31953.146.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517829346.31953.146.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Mon, 2018-02-05 at 12:10 +0100, Ingo Molnar wrote:
> > 
> > Can this branch still be rebased, to fix the SoB chain of:
> > 
> >   de3a0021a606 ("KVM: nVMX: Eliminate vmcs02 pool")
> > 
> > ?
> 
> It can't. Linus pulled it already.

Ah, indeed, freshly so in 35277995e179 - never mind then!

Thanks,

	Ingo
