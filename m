Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeC1F73 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 01:59:29 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:43532 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeC1F72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 01:59:28 -0400
Date: Wed, 28 Mar 2018 07:59:25 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kevin Easton <kevin@guarana.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] af_key: Use DIV_ROUND_UP() instead of open-coded
 equivalent
Message-ID: <20180328055925.skrjbax24he3vcpk@gauss3.secunet.de>
References: <cover.1522063171.git.kevin@guarana.org>
 <930c4e2a88e93c6863ddb97df9ebd0fa1b32149e.1522063171.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <930c4e2a88e93c6863ddb97df9ebd0fa1b32149e.1522063171.git.kevin@guarana.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 14466D38-76BB-42C7-9978-D51C37D71149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 07:39:16AM -0400, Kevin Easton wrote:
> Several places use (x + 7) / 8 to convert from a number of bits to a number
> of bytes.  Replace those with DIV_ROUND_UP(x, 8) instead, for consistency
> with other parts of the same file.
> 
> Signed-off-by: Kevin Easton <kevin@guarana.org>

Is this a fix or just a cleanup?
If it is just a cleanup, please resent it based on ipsec-next.
