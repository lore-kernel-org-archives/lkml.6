Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeFAHsK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:48:10 -0400
Received: from mail.us.es ([193.147.175.20]:54928 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbeFAHsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:48:08 -0400
Date: Fri, 1 Jun 2018 09:48:04 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: nfnetlink: Remove VLA usage
Message-ID: <20180601074804.44l66hj7lcwhpdmv@salvia>
References: <20180530191756.GA39504@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530191756.GA39504@beast>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:17:56PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates the maximum size expected for all possible attrs and adds
> sanity-checks at both registration and usage to make sure nothing
> gets out of sync.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Applied, thanks Kees.
