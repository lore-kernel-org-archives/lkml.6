Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83074ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91B213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A91B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeJRDXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:23:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36407 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeJRDXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:23:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ACCAA20790; Wed, 17 Oct 2018 21:26:01 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80BFB20703;
        Wed, 17 Oct 2018 21:26:01 +0200 (CEST)
Date:   Wed, 17 Oct 2018 21:26:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Message-ID: <20181017192602.GA17341@piout.net>
References: <1539701820.2805.6.camel@HansenPartnership.com>
 <1539701896.2805.7.camel@HansenPartnership.com>
 <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
 <1539744091.2805.108.camel@HansenPartnership.com>
 <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 17/10/2018 11:49:06-0700, Frank Rowand wrote:
> Permission vs exclusion is orthogonal to my comments.
> 
> "building linux" is not the patch wording.  "ordinarily collected by the
> project" is a much broader universe.
> 
> A very simplistic definition of public _could_ be:
> 
>   - Visible on a project mail list that any one can subscribe to
>   - Visible on a project mail list whose archive is available via
>     the public internet
>   - Visible on an interactive communication ("chat") platform that
>     is open to the public internet
>   - Published on a web page intended for public access (for example
>     this could cover opt-in conference attendee lists and emails
>     that conference presenters voluntarily place in their slides).

What about properly formatted patches (with From and SoB) sent to the
maintainer, without copying any mailing lists? To me, a patch sent to a
maintainer is obviously sent for inclusion in the kernel.

>   - (I am guessing the above covers 97% or more of possible public
>     sources, but maybe there are some more common sources.)
> 
> I'm sure that the professionals that deal with information privacy
> could provide better wording for the above list.  I am but an
> amateur in that field.
> 
> Anything else collected by the project would not be considered public.
> For example, an email address provided in an email sent to me and not
> copied to any mail list would not be public.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
