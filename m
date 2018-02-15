Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425173AbeBOPvm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:51:42 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39608 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424582AbeBOPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:51:40 -0500
Date: Thu, 15 Feb 2018 23:51:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lionel Debieve <lionel.Debieve@st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH 0/3] crypto: stm32/hash: Correction to improve robustness
Message-ID: <20180215155133.GL7352@gondor.apana.org.au>
References: <20180129142811.13273-1-lionel.Debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129142811.13273-1-lionel.Debieve@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 03:28:08PM +0100, Lionel Debieve wrote:
> From: Lionel Debieve <lionel.debieve@st.com>
> 
> Hi,
> 
> This patch serie will improve global robustness for stm32-hash driver. 
> 
> Patch #1 is fixing dma-burst issue when configuration is not set.
> Patch #2 solves issue that occurs when irq append during final req processing.
> Patch #3 is fixing an issue that have been introduced while managing padding but
> breaking the padding length calculation by hardware to generate correct hash.
> 
> Regards,
> 
> Lionel Debieve (3):
>   crypto: stm32/hash: avoid error if maxburst not defined
>   crypto: stm32/hash: fix performance issues
>   crypto: stm32/hash: rework padding length

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
