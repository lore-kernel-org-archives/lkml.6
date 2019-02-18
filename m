Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8501E217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfBRJtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:49:51 -0500
Received: from verein.lst.de ([213.95.11.211]:43927 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBRJtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:49:50 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 64A3B68D93; Mon, 18 Feb 2019 10:49:48 +0100 (CET)
Date:   Mon, 18 Feb 2019 10:49:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/4] provide a generic free_initmem implementation
Message-ID: <20190218094948.GA5892@lst.de>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com> <20190214170416.GA32441@lst.de> <20190214183854.GA10795@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214183854.GA10795@rapoport-lnx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:38:55PM +0200, Mike Rapoport wrote:
> On Thu, Feb 14, 2019 at 06:04:16PM +0100, Christoph Hellwig wrote:
> > This look fine to me, but I'm a little worried that as-is this will
> > just create conflicts with my series..
> 
> I'll rebase on top of your patches once they are in. Or I can send both
> series as a single set.
> Preferences? 

So far there wasn't really much a reason to rebase my series, hope
this gets picked up either by Andrew or Al (not sure what the right
place is).  I think for now just rebase your series on top, we can
then figure out how to proceed.
