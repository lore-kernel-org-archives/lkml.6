Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E65207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E65207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJZEBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:01:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725725AbeJZEBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:01:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65979ADCD;
        Thu, 25 Oct 2018 19:27:44 +0000 (UTC)
Message-ID: <2dfa9cf81411feafa2c7426be0e1363945dd388f.camel@suse.de>
Subject: Re: [PATCH 0/9 v3] locks: avoid thundering-herd wake-ups
From:   Martin Wilck <mwilck@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Oct 2018 21:27:43 +0200
In-Reply-To: <20181025160401.GB5539@fieldses.org>
References: <154033435272.29542.13985568983074440924.stgit@noble>
         <20181025160401.GB5539@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 12:04 -0400, J. Bruce Fields wrote:
> On Wed, Oct 24, 2018 at 09:43:54AM +1100, NeilBrown wrote:
> > This took longer that I had wanted, due to various reasons - sorry.
> > And I'm now posting it in a merge window, which is not ideal.  I
> > don't
> > expect it to be included in this merge window and I won't be at all
> > impatient for review, but I didn't want to delay it further.
> 
> Yes, apologies, I've been looking forward to finding out how this
> turned
> out, but I'd like to track down a bug or two and also review Olga's
> copy
> patches....  Bug me if I haven't gotten to this in a week or two.
> 
> I'd also be really interested in any details of the performance
> experiments that you could share.

I pushed my test code to https://github.com/mwilck/lockscale.

Cheers,
Martin


