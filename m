Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935038AbeEIN2e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:28:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42351 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935055AbeEIN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:28:32 -0400
X-Google-Smtp-Source: AB8JxZpzUhmPBY3yLfYAESkt4DJ2KFBhlJerJTqZOboR6M0/3y4gFsHkU5gWsrwXzWDxgyvQqnOUfQ==
Date: Wed, 9 May 2018 15:28:24 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 jc_docs tree
Message-ID: <20180509132824.GA14503@andrea>
References: <20180509202508.15c3435a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509202508.15c3435a@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 08:25:26PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   Documentation/features/vm/pte_special/arch-support.txt
> 
> between commit:
> 
>   2bef69a385b4 ("Documentation/features/vm: Remove arch support status file for 'pte_special'")
> 
> from the jc_docs tree and commit:
> 
>   1099dc900e93 ("mm: introduce ARCH_HAS_PTE_SPECIAL")
> 
> from the akpm-current tree.
> 
> I fixed it up (the former removed the file, so I did that) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> BTW, it would be nice if the the question "Why was this file removed?" was
> answered by that jc_docs commit message ...  I actually wonder if this
> file needs to return (I have no way of knowing).

My bad; thanks for pointing this out.

Mmh... "why" would have been something like "the feature has no Kconfig". ;-)

I defer to your (community) decision regarding "if this file needs to return"
(Cc-ing Ingo, who created the file and also suggested its removal); I remain
available for preparing the patch to restore (and refresh) this file, should
you agree with this approach.

  Andrea


> 
> -- 
> Cheers,
> Stephen Rothwell
