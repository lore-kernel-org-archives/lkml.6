Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeESMRI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:17:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeESMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:17:06 -0400
Date: Sat, 19 May 2018 14:17:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
cc: KY Srinivasan <kys@microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
 definitions to common header
In-Reply-To: <87d0xuiwx5.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1805191415240.1599@nanos.tec.linutronix.de>
References: <20180516152131.30689-1-vkuznets@redhat.com> <20180516152131.30689-2-vkuznets@redhat.com> <MW2PR2101MB1113225D3DBAF5A62FAA990AA0920@MW2PR2101MB1113.namprd21.prod.outlook.com> <87d0xuiwx5.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018, Vitaly Kuznetsov wrote:
> KY Srinivasan <kys@microsoft.com> writes:
> > We should  coordinate on this; I have patches in flight that conflict with
> > the changes here.
> 
> I see you also fixed 'HV_GENERIC_SET_SPARCE_4K' typo. I don't think it's
> a big deal as we fix it in the same way :-)
> 
> I see you also altered hv_flush_pcpu_ex definition but kept it in mmu.c:
> I think my patches should be applied on top of yours, I only need to
> move it to hyperv-tlfs.h header and get rid of _pcpu suffix.
> 
> I hope Thomas will merge your patches very soon. In case Paolo/Radim
> decide that my series is ready too we'll ask their guidance on how to
> resolve the conflict (topic branch?). It should be relatively easy.

I've applied KY's series to tip/x86/hyperv. It has no other changes in
there. So it could be pulled into KVM if necessary w/o pulling other stuff.

Thanks,

	tglx
