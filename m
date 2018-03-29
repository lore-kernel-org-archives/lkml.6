Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC2Bf2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:35:28 -0400
Received: from la.guarana.org ([173.254.219.205]:44664 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeC2Bf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:35:27 -0400
Date: Wed, 28 Mar 2018 21:35:26 -0400
From: Kevin Easton <kevin@guarana.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] af_key: Use DIV_ROUND_UP() instead of open-coded
 equivalent
Message-ID: <20180329013526.GA27752@la.guarana.org>
References: <cover.1522063171.git.kevin@guarana.org>
 <930c4e2a88e93c6863ddb97df9ebd0fa1b32149e.1522063171.git.kevin@guarana.org>
 <20180328055925.skrjbax24he3vcpk@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328055925.skrjbax24he3vcpk@gauss3.secunet.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 07:59:25AM +0200, Steffen Klassert wrote:
> On Mon, Mar 26, 2018 at 07:39:16AM -0400, Kevin Easton wrote:
> > Several places use (x + 7) / 8 to convert from a number of bits to a number
> > of bytes.  Replace those with DIV_ROUND_UP(x, 8) instead, for consistency
> > with other parts of the same file.
> > 
> > Signed-off-by: Kevin Easton <kevin@guarana.org>
> 
> Is this a fix or just a cleanup?
> If it is just a cleanup, please resent it based on ipsec-next.

Hi Steffen,

This patch (1/2) is just a cleanup, but it's in preparation for patch 2/2
which is a fix and modifies some of the same lines.

    - Kevin
