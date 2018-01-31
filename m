Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeAaBGR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:06:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeAaBGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:06:16 -0500
Subject: Re: [9/8] KVM: x86: limit MSR_IA32_SPEC_CTRL access based on CPUID
 availability
To: David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Jim Mattson <jmattson@google.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20180109120311.27565-10-pbonzini@redhat.com>
 <6dc02278-7004-1794-3705-69c8cad86be4@oracle.com>
 <CALMp9eSVC=LO-SrPkA3m6eSpgJ6X4rNCRCf3uvtJEdMG_B72cQ@mail.gmail.com>
 <beb9f9b4-7bc0-4a3a-73c2-0828febbd06c@oracle.com>
 <CALMp9eT6i9bhG005S5sqV-Y1RUhsc+AXE42ww8Ej+TXSjD6tEg@mail.gmail.com>
 <1517332457.18619.132.camel@infradead.org>
 <alpine.DEB.2.20.1801301842310.1797@nanos>
 <75049dca-3389-9cc7-44e3-a487a797c605@redhat.com>
 <1517356066.18619.139.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ffa03746-05f6-d29c-4847-ef81d2d0918d@redhat.com>
Date: Tue, 30 Jan 2018 20:06:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517356066.18619.139.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2018 18:47, David Woodhouse wrote:
> On Tue, 2018-01-30 at 18:11 -0500, Paolo Bonzini wrote:
> 
>> Great, then the "per-VCPU MSR bitmaps" branch
>> (git://git.kernel.org/pub/scm/virt/kvm/kvm.git refs/heads/msr-bitmaps)
>> that I created last weekend can be pulled directly in tip/x86/pti.
>>
>> It cherry-picks directly to both 4.14 so it will be fine for Greg too.
> 
> Right, I've switched to pulling that branch in to my tree at 
> http://git.infradead.org/linux-retpoline.git/shortlog/refs/heads/ibpb
> 
> I seem to recall there was some hecking at it, and I expected it to
> change? :)

No, apart from adding a "!" in v1->v2 it's all fixed.  SHA1 ids won't
change.

Paolo
