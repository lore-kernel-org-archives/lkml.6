Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeCOPqK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:46:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32960 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752525AbeCOPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:46:06 -0400
Date: Thu, 15 Mar 2018 16:45:54 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: Re: [PATCH 00/12] crypto: inside-secure - hmac(sha256/sha224) support
Message-ID: <20180315154554.GD2947@kwain>
References: <20180315153851.9958-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180315153851.9958-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Thu, Mar 15, 2018 at 04:38:39PM +0100, Antoine Tenart wrote:
> 
> This series brings hmac(sha256) and hmac(sha224) support to the Inside
> Secure cryptographic engine driver.
> 
> The first 10 patches are fixes and reworks needed for the hmac(sha256)
> and hmac(224) support to land in. Then 2 patches adds the 2 new
> algorithms.

I made a small mistake as the first 3 patches of the series already
were merged into your tree, as they already were sent in a previous
series. You can just ignore them.

Sending a v2 is probably unnecessary but I can if needed.

Sorry for this,
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
