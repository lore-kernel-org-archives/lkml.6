Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeE3Q21 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:28:27 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:54634 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeE3Q2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:28:24 -0400
Date: Thu, 31 May 2018 00:28:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv2 0/2] Add new SEV commands
Message-ID: <20180530162819.4xbwb3jbbx5dey24@gondor.apana.org.au>
References: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:23:28PM -0500, Janakarajan Natarajan wrote:
> This patchset adds two new SEV commands, introduced in SEV API v0.15
> and v0.16 respectively.
> 
> * DOWNLOAD_FIRMWARE allows the SEV firmware to be updated if a blob newer
>   than or similar to the exisiting build is available.
> 
> * GET_ID allows to query for a unique ID that can be used to retrieve the
>   Chip Endorsment Key (CEK) public key signed by the AMD SEV Signing Key
>   (ASK). 
> 
> v1->v2:
> * Added cover letter.
> * Misc changes based on Boris' feedback.
> 
> Janakarajan Natarajan (2):
>   crypto: ccp: Add DOWNLOAD_FIRMWARE SEV command
>   crypto: ccp: Add GET_ID SEV command
> 
>  drivers/crypto/ccp/psp-dev.c | 143 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/crypto/ccp/psp-dev.h |   4 ++
>  include/linux/psp-sev.h      |  23 +++++++
>  include/uapi/linux/psp-sev.h |  12 ++++
>  4 files changed, 172 insertions(+), 10 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
