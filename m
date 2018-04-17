Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeDQGlo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:41:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeDQGlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:41:42 -0400
Subject: Re: [PATCH v7 7/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To: Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, pbonzini@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        roger.pau@citrix.com, boris.ostrovsky@oracle.com, rkrcmar@redhat.com
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <1523920430-27952-1-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <12a7d9fc-2cff-821c-68c3-05d61c2640e2@suse.com>
Date: Tue, 17 Apr 2018 08:41:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523920430-27952-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 01:13, Maran Wilson wrote:
> For certain applications it is desirable to rapidly boot a KVM virtual
> machine. In cases where legacy hardware and software support within the
> guest is not needed, Qemu should be able to boot directly into the
> uncompressed Linux kernel binary without the need to run firmware.
> 
> There already exists an ABI to allow this for Xen PVH guests and the ABI
> is supported by Linux and FreeBSD:
> 
>    https://xenbits.xen.org/docs/unstable/misc/pvh.html
> 
> This patch enables Qemu to use that same entry point for booting KVM
> guests.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>

You might want to send a follow-up patch to rename the functions in
arch/x86/platform/pvh/* from xen_* to pvh_*.


Juergen
