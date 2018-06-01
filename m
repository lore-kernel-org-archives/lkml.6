Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeFAQYY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:24:24 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:58052 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeFAQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:24:16 -0400
Date: Sat, 2 Jun 2018 00:24:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] rhashtable: simplify INIT_RHT_NULLS_HEAD()
Message-ID: <20180601162403.wt5stkdeler5axtp@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824947.30340.2254332178823222989.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152782824947.30340.2254332178823222989.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
> The 'ht' and 'hash' arguments to INIT_RHT_NULLS_HEAD() are
> no longer used - so drop them.  This allows us to also
> from the nhash argument from nested_table_alloc().

The second sentence is missing a word.

> Signed-off-by: NeilBrown <neilb@suse.com>

Otherwise,

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
