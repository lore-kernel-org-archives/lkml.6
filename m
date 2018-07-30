Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A529FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C2E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C2E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeG3Kge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:36:34 -0400
Received: from verein.lst.de ([213.95.11.211]:51279 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeG3Kgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:36:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 971F99ED64; Mon, 30 Jul 2018 11:06:48 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:06:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Landley <rob@landley.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        iommu@lists.linux-foundation.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for sh V2
Message-ID: <20180730090648.GA18361@lst.de>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de> <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:20:21AM -0500, Rob Landley wrote:
> Speaking of DMA:

Which really has nothing to do with the dma mapping code, which
also means I can't help you much unfortunately.

That being said sh is the last pending of the initial dma-noncoherent
conversion, I'd greatly appreciate if we could get this reviewed and
merge for the 4.19 merge window..
