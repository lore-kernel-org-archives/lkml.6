Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15146C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2022145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="T4d28uHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2022145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeJRW6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:58:13 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38802 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727175AbeJRW6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:58:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 229EE8EE108;
        Thu, 18 Oct 2018 07:56:51 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VAZJiHppaeLc; Thu, 18 Oct 2018 07:56:51 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BB2758EE0D5;
        Thu, 18 Oct 2018 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539874610;
        bh=IVw9cTpDkO2v40ZTEksJiZsk880GfM+bxQ0ViaAudKo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T4d28uHmJbHLRHFFXZ9fCdrybPDRmVjp0SaChR9FbVkhQ/SBnd7YarV7xBSdm3b8I
         gVwp+9jQgd7xrGKx3XnuGkHq5uvoYtmltDT+IdJVmApDf6mBaqWM7X+pldcYMEXIeC
         RlhWHrNYPEgCjleyyTOtdgyJRWdOk+4n/3A1fqfc=
Message-ID: <1539874609.2845.5.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 18 Oct 2018 07:56:49 -0700
In-Reply-To: <b056cdc3-29de-b6c8-b2a7-67b93b0fd730@gmail.com>
References: <1539701820.2805.6.camel@HansenPartnership.com>
         <1539701896.2805.7.camel@HansenPartnership.com>
         <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
         <1539744091.2805.108.camel@HansenPartnership.com>
         <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
         <1539803331.3769.62.camel@HansenPartnership.com>
         <b056cdc3-29de-b6c8-b2a7-67b93b0fd730@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 12:53 -0700, Frank Rowand wrote:
> On 10/17/18 12:08, James Bottomley wrote:
[...]
> > > Trying to understand how you are understanding my comment vs what
> > > I intended to communicate, it seems to me that you are focused on
> > > the "where allowed" and I am focused on the "which email
> > > addresses".
> > > 
> > > More clear?  Or am I still not communicating well enough?
> > 
> > I think the crux of the disagreement is that you think the carve
> > out equates to a permission which is not specific enough and I
> > think it
> 
> Nope.  That is a big place where I was not transferring my thoughts
> to clear communication.  I agree that what I wrote should have been
> written in terms of carve out instead of permission.
> 
> 
> > doesn't equate to a permission at all, which is why there's no need
> > to make it more explicit.  Is that a fair characterisation?
> 
> Nope.  My concern is "which email addresses".

The idea here was because it's a carve out that doesn't give permission
and because the permission is ruled by the project contribution
documents, the carve out should be broad enough to cover anything they
might say hence "email addresses not ordinarily collected by the
project" are still included as unacceptable behaviour.

Perhaps if you propose the wording you'd like to see it would help
because there still looks to be some subtlety I'm not getting.

James



