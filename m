Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97B9C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C28827100
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C28827100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeF1I44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:56:56 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:45104 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeF1I4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:56:55 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fYSjJ-0000wf-E5; Thu, 28 Jun 2018 10:56:41 +0200
Message-ID: <1530176199.4988.2.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the xarray tree with the
 wireless-drivers-next tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Jun 2018 10:56:39 +0200
In-Reply-To: <20180628084612.GB7646@bombadil.infradead.org>
References: <20180628145900.4ca1e648@canb.auug.org.au>
         <1530172269.4988.1.camel@sipsolutions.net>
         <20180628084612.GB7646@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 01:46 -0700, Matthew Wilcox wrote:
> On Thu, Jun 28, 2018 at 09:51:09AM +0200, Johannes Berg wrote:
> > On Thu, 2018-06-28 at 14:59 +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the xarray tree got a conflict in:
> > > 
> > >   lib/Kconfig.debug
> > > 
> > > between commit:
> > > 
> > >   0e2dc70e3d0d ("bitfield: add tests")
> > > 
> > > from the wireless-drivers-next tree and commit:
> > > 
> > >   d968f529e39f ("xarray: Add XArray load operation")
> > > 
> > > from the xarray tree.
> > 
> > Thanks for the heads-up! Not really sure where/how we'll be able to get
> > that resolved before it hits Linus, but as the conflict seems rather
> > easy (overlapping additions), I guess it's not such a big deal.
> 
> I don't care which order the tests are presented in.  I'll happily move the
> XArray addition to a different location in the file.

Good point, that works.

Thanks!

johannes
