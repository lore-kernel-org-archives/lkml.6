Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeDQGS1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:18:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:35539 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbeDQGSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:18:25 -0400
Subject: Re: [PATCH v7 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and
 CONFIG_XEN_PVH
To: Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, pbonzini@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de, thomas.lendacky@amd.com,
        luto@kernel.org, dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com, rdunlap@infradead.org
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <1523920273-27516-1-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <eb2524dd-f74a-286c-81c9-1d81fd3edfab@suse.com>
Date: Tue, 17 Apr 2018 08:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523920273-27516-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 01:11, Maran Wilson wrote:
> In order to pave the way for hypervisors other than Xen to use the PVH
> entry point for VMs, we need to factor the PVH entry code into Xen specific
> and hypervisor agnostic components. The first step in doing that, is to
> create a new config option for PVH entry that can be enabled
> independently from CONFIG_XEN.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
