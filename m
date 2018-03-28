Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeC1UXq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:23:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753256AbeC1UXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:23:45 -0400
Date: Wed, 28 Mar 2018 22:23:38 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 0/7] Enlightened VMCS support for KVM on Hyper-V
Message-ID: <20180328202338.GH26753@flask>
References: <20180320140211.7600-1-vkuznets@redhat.com>
 <87muyv2ek9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muyv2ek9.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-26 14:42+0200, Vitaly Kuznetsov:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > Changes since v5:
> > - Fix a couple of issues reported by kbuild test robot, both in
> >   PATCH7 (hope Radim's Reviewed-by: stands).
> >
> > When running nested KVM on Hyper-V it's possible to use so called
> > 'Enlightened VMCS' and do normal memory reads/writes instead of
> > doing VMWRITE/VMREAD instructions. In addition, clean field mask
> > provides a huge room for optimization on L0's side.
> >
> > Tight CPUID loop test shows significant speedup (E5-2667 v4 @ 3.20GHz):
> >   Before: 18890 cycles
> >   After: 8304 cycles
> >
> 
> Paolo, Radim,
> 
> with Thomas' ACK on the series:
> https://www.spinics.net/lists/kvm/msg166309.html
> 
> is there anything else needed for it to get merged (hoping for 4.17)?

Not from me;  I've queued it, thanks.
