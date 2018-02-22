Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeBVPLs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:11:48 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:57036 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeBVPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:11:45 -0500
Date: Thu, 22 Feb 2018 23:11:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jinbum Park <jinb.park7@gmail.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH] crypto: arm/aes-cipher - move S-box to .rodata section
Message-ID: <20180222151138.GC29815@gondor.apana.org.au>
References: <20180212135237.GA3011@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212135237.GA3011@pjb1027-Latitude-E5410>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 10:52:37PM +0900, Jinbum Park wrote:
> Move the AES inverse S-box to the .rodata section
> where it is safe from abuse by speculation.
> 
> Signed-off-by: Jinbum Park <jinb.park7@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
