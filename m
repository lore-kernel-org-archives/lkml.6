Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754950AbeE3J2R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:28:17 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38090 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeE3J2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:28:14 -0400
Date: Tue, 29 May 2018 17:13:45 +0100
From: Simon Horman <horms@verge.net.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/5] crypto: ccree: silence debug prints
Message-ID: <20180529161345.rhx73mixbnxrfzum@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-4-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527171551-21979-4-git-send-email-gilad@benyossef.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 03:19:08PM +0100, Gilad Ben-Yossef wrote:
> The cache parameter register configuration was being too verbose.
> Use dev_dbg() to only provide the information if needed.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
