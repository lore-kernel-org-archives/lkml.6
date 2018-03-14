Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeCNUG4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:06:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:06:54 -0400
Date: Wed, 14 Mar 2018 21:06:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180314200649.GQ4064@hirez.programming.kicks-ass.net>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
 <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de>
 <87r2opcr6u.fsf@vitty.brq.redhat.com>
 <alpine.DEB.2.21.1803141618320.2481@nanos.tec.linutronix.de>
 <87k1uebmiu.fsf@vitty.brq.redhat.com>
 <alpine.DEB.2.21.1803142057400.1946@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803142057400.1946@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 08:59:25PM +0100, Thomas Gleixner wrote:
> We currently try to move the minimum compiler version to one which provides
> jump label support, so this should be a non issue.
> 
> @Peter: What was the final conclusion of this discussion?

We all said we'd do it. I just haven't come around to resending you that
patch. I'll try and do so tomorrow.
