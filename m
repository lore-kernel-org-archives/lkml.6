Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeC3Jwi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:52:38 -0400
Received: from mail.us.es ([193.147.175.20]:54934 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbeC3Jwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:52:36 -0400
Date: Fri, 30 Mar 2018 11:52:31 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Joe Perches <joe@perches.com>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bridge: netfilter: ebt_stp: Use generic functions for
 comparisons
Message-ID: <20180330095231.ph5hqdh2pboblhnk@salvia>
References: <c22b7398816c4533a65ff57aaa44629729fc7254.1521630169.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c22b7398816c4533a65ff57aaa44629729fc7254.1521630169.git.joe@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 04:03:22AM -0700, Joe Perches wrote:
> Instead of unnecessary const declarations, use the generic functions to
> save a little object space.
> 
> $ size net/bridge/netfilter/ebt_stp.o*
>    text	   data	    bss	    dec	    hex	filename
>    1250	    144	      0	   1394	    572	net/bridge/netfilter/ebt_stp.o.new
>    1344	    144	      0	   1488	    5d0	net/bridge/netfilter/ebt_stp.o.old

Applied, thanks Joe.
