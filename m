Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1399B2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1399B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbeHPSMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:12:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeHPSMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:12:05 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1EDBB25A;
        Thu, 16 Aug 2018 15:12:58 +0000 (UTC)
Date:   Thu, 16 Aug 2018 17:12:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yannik Sembritzki <yannik@sembritzki.me>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH 1/2] Replace magic for trusting the secondary keyring
 with #define
Message-ID: <20180816151252.GD10648@kroah.com>
References: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
 <18610.1534425319@warthog.procyon.org.uk>
 <07e17009-18bb-df72-3408-7e8c0c11e16f@sembritzki.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e17009-18bb-df72-3408-7e8c0c11e16f@sembritzki.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 03:17:47PM +0200, Yannik Sembritzki wrote:
> On 16.08.2018 15:15, David Howells wrote:
> > I would suggest something like that.  I've switched the patches over as has
> > been suggested.  I think it makes more sense to create the constant first and
> > then use that.
> >
> > I've also fleshed out the patch description a bit and added cc and Fixes
> > fields as appropriate.
> 
> Thanks, that looks good to me.
> I see that you only cc'd stable@ in the (now) second patch. I'm curious,
> will this automatically apply the first patch to stable?

No, but I'll try to remember to do it in order to get it right :)

thanks,

greg k-h
