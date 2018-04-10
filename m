Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDJLiX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:38:23 -0400
Received: from la.guarana.org ([173.254.219.205]:49040 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752354AbeDJLiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:38:22 -0400
Date: Tue, 10 Apr 2018 07:38:22 -0400
From: Kevin Easton <kevin@guarana.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] af_key: Use DIV_ROUND_UP() instead of open-coded
 equivalent
Message-ID: <20180410113822.GA18690@la.guarana.org>
References: <cover.1523115061.git.kevin@guarana.org>
 <494dcebdc07530d6afbd7eda300da890a3e68e1c.1523115061.git.kevin@guarana.org>
 <20180409103442.oiib3bi7rms5sgg3@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409103442.oiib3bi7rms5sgg3@gauss3.secunet.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:34:42PM +0200, Steffen Klassert wrote:
> On Sat, Apr 07, 2018 at 11:40:47AM -0400, Kevin Easton wrote:
> > Several places use (x + 7) / 8 to convert from a number of bits to a number
> > of bytes.  Replace those with DIV_ROUND_UP(x, 8) instead, for consistency
> > with other parts of the same file.
> > 
> > Signed-off-by: Kevin Easton <kevin@guarana.org>
> 
> Please resubmit this one to ipsec-next after the
> merge window. Thanks!

Will do!

    - Kevin
