Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeDIKeq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:34:46 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:52920 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeDIKeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:34:44 -0400
Date: Mon, 9 Apr 2018 12:34:42 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kevin Easton <kevin@guarana.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] af_key: Use DIV_ROUND_UP() instead of open-coded
 equivalent
Message-ID: <20180409103442.oiib3bi7rms5sgg3@gauss3.secunet.de>
References: <cover.1523115061.git.kevin@guarana.org>
 <494dcebdc07530d6afbd7eda300da890a3e68e1c.1523115061.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <494dcebdc07530d6afbd7eda300da890a3e68e1c.1523115061.git.kevin@guarana.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 2D3CB95D-EC16-459E-8E72-F73B2BC8F050
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 11:40:47AM -0400, Kevin Easton wrote:
> Several places use (x + 7) / 8 to convert from a number of bits to a number
> of bytes.  Replace those with DIV_ROUND_UP(x, 8) instead, for consistency
> with other parts of the same file.
> 
> Signed-off-by: Kevin Easton <kevin@guarana.org>

Please resubmit this one to ipsec-next after the
merge window. Thanks!
