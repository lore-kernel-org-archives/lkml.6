Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeBBHiA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:38:00 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:45188 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeBBHhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:37:52 -0500
Date: Fri, 2 Feb 2018 08:37:50 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Colin King <colin.king@canonical.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "Hideaki YOSHIFUJI" <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] esp4: remove redundant initialization of pointer esph
Message-ID: <20180202073750.t5gcqfp7cv7vdxiu@gauss3.secunet.de>
References: <20180130145348.32202-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180130145348.32202-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 2718E553-53DE-4511-8BCF-B79176403651
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 02:53:48PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer esph is being assigned a value that is never read, esph is
> re-assigned and only read inside an if statement, hence the
> initialization is redundant and can be removed.
> 
> Cleans up clang warning:
> net/ipv4/esp4.c:657:21: warning: Value stored to 'esph' during
> its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I've queued this for ipsec-next, will be applied
after the merge window.
