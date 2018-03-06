Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753472AbeCFKlG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:41:06 -0500
Received: from mail.us.es ([193.147.175.20]:41048 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753419AbeCFKk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:40:58 -0500
Date: Tue, 6 Mar 2018 11:40:54 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Simon Horman <horms@verge.net.au>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Wensong Zhang <wensong@linux-vs.org>, Julian Anastasov <ja@ssi.bg>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipvs: use true and false for boolean values
Message-ID: <20180306104054.glcbnnqbyb5ztctk@salvia>
References: <20180305213557.GA12365@embeddedor.com>
 <20180306080208.xxz27gffcd7z5fqi@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306080208.xxz27gffcd7z5fqi@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:02:08AM +0100, Simon Horman wrote:
> On Mon, Mar 05, 2018 at 03:35:57PM -0600, Gustavo A. R. Silva wrote:
> > Assign true or false to boolean variables instead of an integer value.
> > 
> > This issue was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Pablo, could you take this one?

Applied, thanks Simon!
