Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeEQLwg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:52:36 -0400
Received: from mail.us.es ([193.147.175.20]:32780 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbeEQLwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:52:34 -0400
Date: Thu, 17 May 2018 13:52:30 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        ffmancera@riseup.net
Subject: Re: [PATCH nf-next] netfilter: fix fallout from xt/nf osf separation
Message-ID: <20180517115230.wzyqkrlbf6ndr735@salvia>
References: <20180508102101.768d5c52@canb.auug.org.au>
 <20180508080538.31992-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508080538.31992-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 10:05:38AM +0200, Florian Westphal wrote:
> Stephen Rothwell says:
>   today's linux-next build (x86_64 allmodconfig) produced this warning:
>   ./usr/include/linux/netfilter/nf_osf.h:25: found __[us]{8,16,32,64} type without #include <linux/types.h>
> 
> Fix that up and also move kernel-private struct out of uapi (it was not
> exposed in any released kernel version).
> 
> tested via allmodconfig build + make headers_check.

Applied, thanks Florian.
