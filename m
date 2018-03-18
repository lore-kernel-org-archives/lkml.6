Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeCRPrA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:47:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeCRPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:46:58 -0400
Date: Sun, 18 Mar 2018 16:46:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] x86/hyper-v: detect nested features
In-Reply-To: <20180316142220.32506-7-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1803181642520.1509@nanos.tec.linutronix.de>
References: <20180316142220.32506-1-vkuznets@redhat.com> <20180316142220.32506-7-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Vitaly Kuznetsov wrote:
>  
> +	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED)
> +		ms_hyperv.nested_features =
> +			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);

Please add curly braces. Rationale:

       https://marc.info/?l=linux-kernel&m=148467980905537

I know it's a pet pieve, ...

Thanks,

	tglx
