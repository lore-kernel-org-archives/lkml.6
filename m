Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC122151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="VdXDqoRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC122151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeISUvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:51:01 -0400
Received: from cock.li ([185.100.85.212]:50448 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731221AbeISUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:51:01 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537369956; bh=q2HfgBQvAlHDXF+jzFTAN2HG8UdTwLlKb+Ilpnnr93k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VdXDqoRqvPQ9isUZDCYfZhodSnlmS0/xw5D9HLEP/LxhB5ZCHu+XqN9uYV18nm9xk
         Xfw7v9Q/FVbWDvqOyFTHQHSZfgCGwTEQFNpPu2dXaGZX7I+tziBgXBrOnaqw1lxdm1
         /ew56UMEXUy5ETY+D/3oxbdIvkgkAK5MjOVvUSh5KUyzmfRra7dV8WbnbpHDTkXsMp
         NCJPyvFa18oVS/lQNr2a9EzwSq1GYfd2E9qmHj/NfUvFTkPRAKIWPj3GZoAAsGdDyZ
         tCQBX49FYEtOOQCTsv5hx4/r20+RQxgbBRwvyfsPlscCmJNxseMqzutU73LicgXUjE
         XhSJVEvK51Zgg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Sep 2018 15:12:35 +0000
From:   observerofaffairs@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     dng@lists.dyne.org, debian-user@lists.debian.org
Subject: Fwd: Re: Fwd: Re: [DNG] GPL version 2 is a bare license. Recind.
 (Regarding (future) linux Code of Conduct Bannings).
In-Reply-To: <0bd7fb92f5b2d5f18e67fdc9b3f6e603@redchan.it>
References: <6b4a0cf6fa672938b8ab98acd1dea0a1@redchan.it>
 <BBFE2346-72C7-47D3-910A-DD720C7637DC@charter.net>
 <24cf6d6095c740903f16b56e22dd137c@redchan.it>
 <996c99ea4146a247730d87df14dfca1a@redchan.it>
 <E1g2TJn-0006lD-Lm@fencepost.gnu.org>
 <0bd7fb92f5b2d5f18e67fdc9b3f6e603@redchan.it>
Message-ID: <77f81bcb07d6a9193992f87dbd040658@redchan.it>
X-Sender: observerofaffairs@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would depend on the communications made by the copyright holder, or 
ratifications made by him (if any). Estopple arises when a grantee relys 
on the grantors' communication that he will not rescind, and the grantor 
takes an action based on that communication.

The clause in version 3 of the GPL (aswell as the CC licenses etc) 
furnishes a clear possibility of such a defense.

Version 2 of the GPL lacks such a clause, so one must look to the 
communications of the contributing copyright holder's statements, etc.

(Another problem is that the contributor may have never communicated to 
the people he might want to rescind from, which adds another hurdle to 
an estopple defense)

For instance, if the contributor was queried on the topic and gave a 
response publicly, then the next question would be "did the defendant 
know of and rely on that statement".

The linux-kernel's ... lassie-fair ... attitude when it comes to formal 
matters and the sheer volume of contributors makes one wonder if 
anything of the sort was done.

It is, indeed, a problem for Free-Software in the United States, as 
copyright is simply "alienable in all ways property is"; and a licensor, 
barring an attached interest or contract terms or communications that 
would give rise to estopple, has an absolute right to rescind a license 
regarding his property at his will; which is one feature that 
distinguishes a license from an easement, servitude, real covenant, etc.

(Note: My projects dual license GPLv2 and GPLv3 for this reason: v3 
furnishes an estoppel defense, v2 makes everyone happy because it's 
"what they know", the linux-kernel never made any real attempts to adopt 
the new license and omitted the "any-later-version codicil" from the 
very beginning)

On 2018-09-19 03:38, Richard Stallman wrote:
> [[[ To any NSA and FBI agents reading my email: please consider    ]]]
> [[[ whether defending the US Constitution against all enemies,     ]]]
> [[[ foreign or domestic, requires you to follow Snowden's example. ]]]
> 
>   > One is rescission of the license they granted regarding their code, 
> and
>   > then a lawsuit under copyright if/when the rescission is ignored.
>   > The others are breach of contract, libel, false light, etc.
> 
> If "rescission" is really a possibility, it would cause greast trouble
> for the free software community.  We would need to take steps to make
> sure it cannot happen.
> 
> However, that goes against everything I have been told by others.
