Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965363AbeCPPxu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:53:50 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59480 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754116AbeCPPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:53:43 -0400
Date: Fri, 16 Mar 2018 23:53:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-crypto@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        "David S. Miller" <davem@davemloft.net>, Gary Hook <gary.hook@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        kvm@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] crypto: ccp: Use memdup_user() rather than duplicating
 its implementation
Message-ID: <20180316155327.GB7095@gondor.apana.org.au>
References: <ccd82e60-ba87-d224-3662-365662fa4e6e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd82e60-ba87-d224-3662-365662fa4e6e@users.sourceforge.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 02:10:20PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Mar 2018 13:50:13 +0100
> 
> Reuse existing functionality from memdup_user() instead of keeping
> duplicate source code.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
