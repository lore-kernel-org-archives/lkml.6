Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeA3Nyp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:54:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752285AbeA3Nyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:54:43 -0500
Date: Tue, 30 Jan 2018 14:54:26 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pixo@polepetko.eu
Subject: Re: [PATCH] KVM:x86: AMD Processor Topology Information
Message-ID: <20180130135426.GA22015@flask>
References: <20171029215633.3102-1-pixo@polepetko.eu>
 <20180129163944.114684-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129163944.114684-1-babu.moger@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-29 11:39-0500, Babu Moger:
> From: Stanislav Lanci <pixo@polepetko.eu>
> 
> This patch allow to enable x86 feature TOPOEXT. This is needed to provide
> information about SMT on AMD Zen CPUs to the guest.
> 
> Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> Tested-by: Nick Sarnie <commendsarnex@gmail.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> 
> Rebased on top of linux-next.
> Maximum extended functions are already set to 0x8000001f after the commit
> 8765d75329a3 KVM: X86: Extend CPUID range to include new leaf

Queued, thanks.
