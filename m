Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0973FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4B82172D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4B82172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeHCJCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:02:34 -0400
Received: from verein.lst.de ([213.95.11.211]:42958 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbeHCJCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:02:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D01216FD11; Fri,  3 Aug 2018 09:12:26 +0200 (CEST)
Date:   Fri, 3 Aug 2018 09:12:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: linux-next: manual merge of the mips tree with the kbuild tree
Message-ID: <20180803071226.GA2099@lst.de>
References: <20180803092100.7d0fda13@canb.auug.org.au> <20180803064128.GA1715@lst.de> <20180803164252.5f519701@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803164252.5f519701@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 04:42:52PM +1000, Stephen Rothwell wrote:
> Hi Christoph,
> 
> On Fri, 3 Aug 2018 08:41:28 +0200 Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Fri, Aug 03, 2018 at 09:21:00AM +1000, Stephen Rothwell wrote:
> > > I fixed it up (see below)  
> > 
> > I can't find any fixup below..
> 
> Sorry about that - see below.

Thanks.  So just another trivial removals near additions case.
