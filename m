Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeETDCW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 23:02:22 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:50256 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeETDCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 23:02:20 -0400
Date: Sun, 20 May 2018 11:02:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: random: Wake up writers when random pools are zapped
Message-ID: <20180520030214.u4hkx7webjgkoy3m@gondor.apana.org.au>
References: <20180518065736.szvspgdeyiaiqheb@gondor.apana.org.au>
 <20180519215519.GA23448@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519215519.GA23448@thunk.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 05:55:19PM -0400, Theodore Y. Ts'o wrote:
>
> Out of curiosity, how/when were you using RNDCLEARPOOL/RNDZAPENTCNT?
> Hopefully it was only testing hw_random drivers, or some such?

I wasn't actually using it myself.  Someone else filed a bug
against RHEL complaining about this and I was just clearing my
decks :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
