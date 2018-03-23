Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeCWQCg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:02:36 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:36226 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeCWQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:02:34 -0400
Date: Sat, 24 Mar 2018 00:02:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 19/47] crypto: remove blackfin CRC driver
Message-ID: <20180323160224.GE2186@gondor.apana.org.au>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-20-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-20-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:35:32PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this
> driver won't be used any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
