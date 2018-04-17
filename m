Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDQGai (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:30:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36275 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeDQGah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:30:37 -0400
Subject: Re: [PATCH v7 6/7] xen/pvh: Add memory map pointer to hvm_start_info
 struct
To: Maran Wilson <maran.wilson@oracle.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com
Cc: JBeulich@suse.com, roger.pau@citrix.com, boris.ostrovsky@oracle.com,
        rkrcmar@redhat.com
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <1523920396-27855-1-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <f970ce90-e47a-b106-ee36-ace5e364f44b@suse.com>
Date: Tue, 17 Apr 2018 08:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523920396-27855-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 01:13, Maran Wilson wrote:
> The start info structure that is defined as part of the x86/HVM direct boot
> ABI and used for starting Xen PVH guests would be more versatile if it also
> included a way to pass information about the memory map to the guest. This
> would allow KVM guests to share the same entry point.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
