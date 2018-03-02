Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933702AbeCBVWV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:22:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933644AbeCBVWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:22:20 -0500
Date: Fri, 2 Mar 2018 22:21:42 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH RESEND v5 1/2] KVM: X86: Introduce kvm_get_msr_feature()
Message-ID: <20180302212141.GA13606@flask>
References: <1519797811-4560-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519797811-4560-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28 14:03+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Introduce kvm_get_msr_feature() to handle the msrs which are supported 
> by different vendors and sharing the same emulation logic.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

Applied both, thanks.
