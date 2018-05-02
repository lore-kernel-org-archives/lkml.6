Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeEBHlR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:41:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751346AbeEBHlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:41:14 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Cc: x86@kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] KVM: x86: hyperv: PV TLB flush for Windows guests
References: <20180416110806.4896-1-vkuznets@redhat.com>
Date: Wed, 02 May 2018 09:41:10 +0200
In-Reply-To: <20180416110806.4896-1-vkuznets@redhat.com> (Vitaly Kuznetsov's
        message of "Mon, 16 Apr 2018 13:08:00 +0200")
Message-ID: <87y3h2sdwp.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

>
> Qemu (and other userspaces) need to enable CPUID feature bits to make
> Windows aware the feature is supported. I'll post Qemu enablement patch
> separately.

Radim, Paolo,

I'd like to send Qemu feature enablement patch for this feature but
before I do that I'd like to get your feedback on this series.

Thanks!

-- 
  Vitaly
