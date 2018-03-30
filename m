Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeC3JyN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:54:13 -0400
Received: from mail.us.es ([193.147.175.20]:55476 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3JyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:54:11 -0400
Date: Fri, 30 Mar 2018 11:54:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] netfilter: ipset: Use is_zero_ether_addr instead of
 static and memcmp
Message-ID: <20180330095406.chw56e7rizhmcfuo@salvia>
References: <687a4edaed07441681d3bfe3b63aa4feb55b9d61.1521567319.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687a4edaed07441681d3bfe3b63aa4feb55b9d61.1521567319.git.joe@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:35:47AM -0700, Joe Perches wrote:
> To make the test a bit clearer and to reduce object size a little.
> 
> Miscellanea:
> 
> o remove now unnecessary static const array
> 
> $ size ip_set_hash_mac.o*
>    text	   data	    bss	    dec	    hex	filename
>   22822	   4619	     64	  27505	   6b71	ip_set_hash_mac.o.allyesconfig.new
>   22932	   4683	     64	  27679	   6c1f	ip_set_hash_mac.o.allyesconfig.old
>   10443	   1040	      0	  11483	   2cdb	ip_set_hash_mac.o.defconfig.new
>   10507	   1040	      0	  11547	   2d1b	ip_set_hash_mac.o.defconfig.old

Applied, thanks Joe.
