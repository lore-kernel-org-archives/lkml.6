Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeEQGmE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:42:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbeEQGmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:42:03 -0400
Subject: Re: [PATCH v5] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
To: Paul Durrant <paul.durrant@citrix.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20180509131612.21107-1-paul.durrant@citrix.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <69c96876-e5b7-dd6e-8ebe-3493d736e578@suse.com>
Date: Thu, 17 May 2018 08:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509131612.21107-1-paul.durrant@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/18 15:16, Paul Durrant wrote:
> My recent Xen patch series introduces a new HYPERVISOR_memory_op to
> support direct priv-mapping of certain guest resources (such as ioreq
> pages, used by emulators) by a tools domain, rather than having to access
> such resources via the guest P2M.
> 
> This patch adds the necessary infrastructure to the privcmd driver and
> Xen MMU code to support direct resource mapping.
> 
> NOTE: The adjustment in the MMU code is partially cosmetic. Xen will now
>       allow a PV tools domain to map guest pages either by GFN or MFN, thus
>       the term 'mfn' has been swapped for 'pfn' in the lower layers of the
>       remap code.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Pushed to xen/tip.git for-linus-4.18


Juergen
