Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeFAKtE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:49:04 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:57762 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFAKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:49:01 -0400
Date: Fri, 1 Jun 2018 18:48:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/18] rhashtable: split rhashtable.h
Message-ID: <20180601104856.zdawjbtejcpr22aa@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824932.30340.8068908844678938422.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152782824932.30340.8068908844678938422.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
> Due to the use of rhashtables in net namespaces,
> rhashtable.h is included in lots of the kernel,
> so a small changes can required a large recompilation.
> This makes development painful.
> 
> This patch splits out rhashtable-types.h which just includes
> the major type declarations, and does not include (non-trivial)
> inline code.  rhashtable.h is no longer included by anything
> in the include/ directory.
> Common include files only include rhashtable-types.h so a large
> recompilation is only triggered when that changes.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
