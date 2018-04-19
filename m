Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeDSN4R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:56:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752085AbeDSN4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:56:14 -0400
Date: Thu, 19 Apr 2018 15:56:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: jhogan@kernel.org, ralf@linux-mips.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, borntraeger@de.ibm.com,
        frankja@linux.vnet.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        christoffer.dall@linaro.org, marc.zyngier@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        willy@infradead.org
Subject: Re: [PATCH] kvm: Change return type to vm_fault_t
Message-ID: <20180419155606.45a85009.cohuck@redhat.com>
In-Reply-To: <20180418191958.GA25806@jordon-HP-15-Notebook-PC>
References: <20180418191958.GA25806@jordon-HP-15-Notebook-PC>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 00:49:58 +0530
Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  arch/mips/kvm/mips.c       | 2 +-
>  arch/powerpc/kvm/powerpc.c | 2 +-
>  arch/s390/kvm/kvm-s390.c   | 2 +-
>  arch/x86/kvm/x86.c         | 2 +-
>  include/linux/kvm_host.h   | 2 +-
>  virt/kvm/arm/arm.c         | 2 +-
>  virt/kvm/kvm_main.c        | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
