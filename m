Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932072AbeC0RYI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:24:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeC0RYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:24:06 -0400
Date: Tue, 27 Mar 2018 19:23:59 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Petr Machata <petrm@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ipsec tree with the net tree
Message-ID: <20180327192359.4b1bb7d6@epycfail>
In-Reply-To: <wih7epx8u60.fsf@dev-r-vrt-156.mtr.labs.mlnx>
References: <20180326091610.148fc62d@canb.auug.org.au>
        <wih7epx8u60.fsf@dev-r-vrt-156.mtr.labs.mlnx>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 17:33:43 +0300
Petr Machata <petrm@mellanox.com> wrote:

> Hi, this conflict needs to be resolved differently. Below I'm adding a
> patch on top of linux-next. Squash or apply as you see fit.

Petr, thanks for spotting this. Stephen, you can carry these tags for
Petr's patch:

Fixes: adab890d00dc ("Merge remote-tracking branch 'ipsec/master'")
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Stefano Brivio <sbrivio@redhat.com>

> What's the right way to proceed from here? It looks to me like Stefano
> or Steffen should take this into the ipsec tree (possibly just squash to
> the clamping fix), as they'll hit this conflict the next time they
> rebase on top of net...? Let me know what to do, please.

Steffen, please let me know if you want me to submit anything for the
ipsec tree on top of my previous patches.

I guess another alternative would be that David fixes the conflict the
way Petr solved it, when merging to net?

-- 
Stefano
