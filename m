Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeCRPt6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:49:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58592 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeCRPtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:49:53 -0400
Date: Sun, 18 Mar 2018 16:49:46 +0100 (CET)
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
Subject: Re: [PATCH v4 0/7] Enlightened VMCS support for KVM on Hyper-V
In-Reply-To: <20180316142220.32506-1-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1803181648480.1509@nanos.tec.linutronix.de>
References: <20180316142220.32506-1-vkuznets@redhat.com>
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

> Ladi Prosek (1):
>   x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
>     HV_X64_MSR_VP_ASSIST_PAGE
> 
> Vitaly Kuznetsov (6):
>   x86/hyper-v: move hyperv.h out of uapi
>   x86/hyper-v: move definitions from TLFS to hyperv-tlfs.h
>   x86/hyper-v: allocate and use Virtual Processor Assist Pages
>   x86/hyper-v: define struct hv_enlightened_vmcs and clean field bits
>   x86/hyper-v: detect nested features
>   x86/kvm: use Enlightened VMCS when running on Hyper-V

Paolo, I have no hyperv related changes pending for 4.17. Feel free to
route it through your tree with my;

Acked-by: Thomas Gleixner <tglx@linutronix.de>
