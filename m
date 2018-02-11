Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeBKKzJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:55:09 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37033 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBKKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:55:07 -0500
X-Google-Smtp-Source: AH8x227J6jckeDsaXteayLZ+EJCK2NTnt81yIPWwu/oHlVyWIGk44caQGNbWa/Kf3NxOzGya3Tvr+A==
Date: Sun, 11 Feb 2018 11:55:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Raslan, KarimAllah" <karahmed@amazon.de>,
        "arjan.van.de.ven@intel.com" <arjan.van.de.ven@intel.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Sironi, Filippo" <sironi@amazon.de>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 5/6] KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we
 have a valid L02 MSR bitmap
Message-ID: <20180211105502.tnovwfxczkkbm26l@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
 <20180211101924.vztfslwqoh7km6q2@gmail.com>
 <1518345844.3677.365.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518345844.3677.365.camel@amazon.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Woodhouse, David <dwmw@amazon.co.uk> wrote:

> On Sun, 2018-02-11 at 11:19 +0100, Ingo Molnar wrote:
> > Note, I fixed the changelog to refer to the correct upstream SHA1,
> > which is:
> > 
> >   d28b387fb74d: KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
> 
> Thanks for catching that.
> 
> Wouldn't it be nice if 'git rebase --interactive tip/x86/pti' had done
> that *for* me? :)

Yeah, but given that the commit title changed as well:

   086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
   d28b387fb74d ("KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL")

I'd rather not have tooling guess about such things.

Thanks,

	Ingo
