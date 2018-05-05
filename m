Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeEEHRw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:17:52 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35194 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeEEHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:17:50 -0400
Date: Sat, 5 May 2018 15:17:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: David Binderman <dcb314@hotmail.com>, Radu Alexe <radu.alexe@nxp.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam - fix size of RSA prime factor q
Message-ID: <20180505071739.v7l46xlvj5lkg7hj@gondor.apana.org.au>
References: <AM4PR08MB28197AB3772FC2932C58EBFC9C8E0@AM4PR08MB2819.eurprd08.prod.outlook.com>
 <20180427084011.26234-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427084011.26234-1-horia.geanta@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 11:40:11AM +0300, Horia Geantă wrote:
> Fix a typo where size of RSA prime factor q is using the size of
> prime factor p.
> 
> Cc: <stable@vger.kernel.org> # 4.13+
> Fixes: 52e26d77b8b3 ("crypto: caam - add support for RSA key form 2")
> Fixes: 4a651b122adb ("crypto: caam - add support for RSA key form 3")
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
