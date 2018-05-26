Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031808AbeEZObR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 10:31:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754951AbeEZObQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 10:31:16 -0400
Date: Sat, 26 May 2018 16:31:11 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] KVM: x86: hyperv: PV TLB flush for Windows guests
Message-ID: <20180526143111.GE23390@flask>
References: <20180516152131.30689-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516152131.30689-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-16 17:21+0200, Vitaly Kuznetsov:
> Changes since v3 [Radim Krcmar]:
> - PATCH2 fixing 'HV_GENERIC_SET_SPARCE_4K' typo added.
> - PATCH5 introducing kvm_make_vcpus_request_mask() API added.
> - Fix undefined behavior for hv->vp_index >= 64.
> - Merge kvm_hv_flush_tlb() and kvm_hv_flush_tlb_ex()
> - For -ex case preload all banks with a single kvm_read_guest().

I've pulled tip/hyperv into kvm/queue and applied on top, thanks.
