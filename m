Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeDIE3M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 00:29:12 -0400
Received: from namei.org ([65.99.196.166]:56062 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbeDIE3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 00:29:11 -0400
Date: Mon, 9 Apr 2018 14:29:02 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: David Howells <dhowells@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the efi-lock-down
 tree
In-Reply-To: <20180409142237.66d3466d@canb.auug.org.au>
Message-ID: <alpine.LRH.2.21.1804091428390.20797@namei.org>
References: <20180315183412.01412755@canb.auug.org.au> <20180406092216.4579a70c@canb.auug.org.au> <20180409115831.46a351ef@canb.auug.org.au> <alpine.LRH.2.21.1804091251380.14450@namei.org> <20180409142237.66d3466d@canb.auug.org.au>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018, Stephen Rothwell wrote:

> Hi James,
> 
> On Mon, 9 Apr 2018 12:51:53 +1000 (AEST) James Morris <jmorris@namei.org> wrote:
> >
> > That's odd, my next-general branch is merged to Linus.
> 
> The security tree in linux-next is
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git#next-testing
> 
> which has the efi-lock-down tree merged into it.

Ahh, I see.  I'll rebase next-testing.

-- 
James Morris
<jmorris@namei.org>
