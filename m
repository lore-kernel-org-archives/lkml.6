Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbeB1REC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:04:02 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49174 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeB1REA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:04:00 -0500
Date: Wed, 28 Feb 2018 12:03:58 -0500 (EST)
Message-Id: <20180228.120358.511315280246637626.davem@davemloft.net>
To: joeypabalinas@gmail.com
Cc: netdev@vger.kernel.org, shemminger@linux-foundation.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tcp/illinois: replace broken algorithm reference
 link
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180228080553.wfgmz46fn452hddn@gmail.com>
References: <20180228080553.wfgmz46fn452hddn@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joey Pabalinas <joeypabalinas@gmail.com>
Date: Tue, 27 Feb 2018 22:05:53 -1000

> The link to the pdf containing the algorithm description is now a
> dead link; it seems http://www.ifp.illinois.edu/~srikant/ has been
> moved to https://sites.google.com/a/illinois.edu/srikant/ and none of
> the original papers can be found there...
> 
> I have replaced it with the only working copy I was able to find.
> 
> n.b. there is also a copy available at:
> 
> http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.296.6350&rep=rep1&type=pdf
> 
> However, this seems to only be a *cached* version, so I am unsure
> exactly how reliable that link can be expected to remain over time
> and have decided against using that one.
> 
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

Applied, thank you.
