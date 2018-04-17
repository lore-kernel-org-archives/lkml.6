Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeDQG3z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:29:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbeDQG3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:29:52 -0400
Subject: Re: [PATCH v7 3/7] xen/pvh: Create a new file for Xen specific PVH
 code
To: Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com
Cc: boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <1523920360-27743-1-git-send-email-maran.wilson@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <d197e3b9-99b8-dd1d-a073-40d64bb17198@suse.com>
Date: Tue, 17 Apr 2018 08:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523920360-27743-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 01:12, Maran Wilson wrote:
> We need to refactor PVH entry code so that support for other hypervisors
> like Qemu/KVM can be added more easily.
> 
> The first step in that direction is to create a new file that will
> eventually hold the Xen specific routines.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
