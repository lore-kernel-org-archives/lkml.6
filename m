Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbeEIMcL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:32:11 -0400
Received: from mail.us.es ([193.147.175.20]:32878 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934126AbeEIMcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:32:09 -0400
Date: Wed, 9 May 2018 14:32:03 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Colin King <colin.king@canonical.com>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_tables: fix memory leak on error exit
 return
Message-ID: <20180509123203.ppangv6gdzppj3iv@salvia>
References: <20180509122256.16859-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509122256.16859-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 01:22:56PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the -EBUSY error return path is not free'ing resources
> allocated earlier, leaving a memory leak. Fix this by exiting via the
> error exit label err5 that performs the necessary resource clean
> up.
> 
> Detected by CoverityScan, CID#1432975 ("Resource leak")

Applied, thanks.
