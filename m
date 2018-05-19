Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeESVzY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 17:55:24 -0400
Received: from imap.thunk.org ([74.207.234.97]:56324 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbeESVzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 17:55:23 -0400
Date: Sat, 19 May 2018 17:55:19 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: random: Wake up writers when random pools are zapped
Message-ID: <20180519215519.GA23448@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180518065736.szvspgdeyiaiqheb@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518065736.szvspgdeyiaiqheb@gondor.apana.org.au>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 02:57:36PM +0800, Herbert Xu wrote:
> As it is when the pool is zapped with RNDCLEARPOOL writers are
> not woken up and therefore the pool may remain in the empty state
> indefinitely.
> 
> This patch wakes them up unless the write threshold is set to zero.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks, applied.

Out of curiosity, how/when were you using RNDCLEARPOOL/RNDZAPENTCNT?
Hopefully it was only testing hw_random drivers, or some such?

	     	      	      		- Ted
