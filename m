Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeEJVo3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:44:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:59542 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752324AbeEJVoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:44:13 -0400
Date: Thu, 10 May 2018 15:44:08 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the jc_docs
 tree
Message-ID: <20180510154359.4aea2351@lwn.net>
In-Reply-To: <20180511074049.26072ec8@canb.auug.org.au>
References: <20180511074049.26072ec8@canb.auug.org.au>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 07:40:49 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commit
> 
>   5a779c40a8ad ("Revert "Documentation/features/vm: Remove arch support status file for 'pte_special'"")
> 
> is missing a Signed-off-by from its author and committer.  Reverts are
> commits too. ;-)

Argh.  I'm really not having a good time with this.

I've rebase-fixed it, I doubt anybody (except you! :) has pulled my tree
in the half-hour it was there...apologies if I'm wrong.

Thanks,

jon
