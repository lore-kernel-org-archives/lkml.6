Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeCEWKc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:10:32 -0500
Received: from mail.us.es ([193.147.175.20]:51136 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbeCEWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:10:31 -0500
Date: Mon, 5 Mar 2018 23:10:27 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: ipt_ah: return boolean instead of integer
Message-ID: <20180305221027.vmailsqb5gkvxmcg@salvia>
References: <20180213142557.GA9008@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213142557.GA9008@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 08:25:57AM -0600, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use
> true/false instead of 1/0.
> 
> This issue was detected with the help of Coccinelle.

This one didn't get in time for the previous merge window.

Now applied, thanks.
