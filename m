Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeC1UO2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:14:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751976AbeC1UO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:14:27 -0400
Date: Wed, 28 Mar 2018 22:14:24 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM: X86: Fix disable pv tlb flush when steal time
 is enabled
Message-ID: <20180328201424.GE26753@flask>
References: <1521951515-5139-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521951515-5139-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-24 21:18-0700, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> PV TLB FLUSH can be turned on when steal time is enabled. The condition 
> reverse when the patch is sent out for several rounds review by mistake. 

It was just one round and the m/l patch actually looks correct,

> This patch fixes it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

I've modified the commit message and rebased it for kvm/master, thanks.
