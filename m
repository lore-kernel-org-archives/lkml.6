Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeBKKls (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:41:48 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52673 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBKKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:41:46 -0500
X-Google-Smtp-Source: AH8x2271yQjAwTKah/P5P3dg5mL25FCK+yvgyGdp4JHAm8zTY4zdMWN96e2c5rtezNRVmiIHinjy7A==
Date: Sun, 11 Feb 2018 11:41:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 0/6] Spectre v2 updates
Message-ID: <20180211104141.boxyofjfknxmggsj@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paolo, Radim,

* David Woodhouse <dwmw@amazon.co.uk> wrote:

> David Woodhouse (4):
>   KVM: x86: Reduce retpoline performance impact in slot_handle_level_range()
> KarimAllah Ahmed (2):
>   X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
>   KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap

Similarly to the previous Spectre patches I've applied these three KVM patches to 
tip:x86/pti too, to keep them all in a single backportable group of commits. They 
all look correct to me and solve real problems, and there's no conflict with 
current upstream KVM code.

Let me know if that's OK to you or if you'd like to see any changes to them.

Thanks,

	Ingo
