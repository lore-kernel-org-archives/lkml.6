Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF8AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A212089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBTUui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:50:38 -0500
Received: from namei.org ([65.99.196.166]:53318 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBTUuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:50:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1KKnVDP001538;
        Wed, 20 Feb 2019 20:49:31 GMT
Date:   Thu, 21 Feb 2019 07:49:31 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] MAINTAINERS: add linux-security-module mailing list to
 TPM drivers
In-Reply-To: <20190220150445.GA4794@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1902210747510.1411@namei.org>
References: <20190220035846.6272-1-jsnitsel@redhat.com> <20190220070413.GB23027@linux.intel.com> <20190220140357.5vbepgmexso3jc6d@cantor> <20190220150445.GA4794@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019, Jarkko Sakkinen wrote:

> > being cc'd to linux-security-module? Looking back at
> > recent patches, it looked like it was a general request.
> > If it is, I'll be more likely to remember if get_maintainers.pl
> > brings it up. :)
> 
> I'm all open here. Not sure which practices apply to IMA. I kind of tend
> to dilate to question does it make sense to CC to LSM for two reasons:
> 
> 1. I think the original reason was that tpmdd mailing list was small.
> Now with the new linux-integrity mailing list up and running there is
> more eyes looking at the code. And more importantly the people are
> subscribed who use TPM for something, like IMA developers.
> 2. I don't remember ever reading within the time that I've been
> maintaining even a single comment from anyone that works with LSM's. The
> value of CC'ing there is not very significant, which means that most of
> the time the TPM traffic is just noise on that list.

Sounds about right, there used to be more security folk on LSM and not as 
many on the TPM list, but the new integrity list works well for TPM now.


-- 
James Morris
<jmorris@namei.org>

