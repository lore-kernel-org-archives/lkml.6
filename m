Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA946C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4982075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4982075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIECC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:02:27 -0400
Received: from verein.lst.de ([213.95.11.211]:42474 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbeIECC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:02:27 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 57E4368D40; Tue,  4 Sep 2018 23:38:59 +0200 (CEST)
Date:   Tue, 4 Sep 2018 23:38:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Message-ID: <20180904213859.GA10394@lst.de>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com> <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com> <20180904211107.GA8202@lst.de> <C2D7FE5348E1B147BCA15975FBA23075012B091717@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B091717@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:34:43PM +0000, Vineet Gupta wrote:
> Sorry I missed that request of yours on top of the last msg. I would really want
> this to get into 4.19 (understand that merge window is done etc) given that
> there's a bunch of other changes lined up behind this one. I was just sucked up
> into "other" stuff and could not get to it sooner. Please bear with me this once -
> hopefully it would be smoother going fwd.

Oh, if you manage to get it into 4.19 and do so quickly that is fine
as well.  I just don't want it in your 4.20 queue creating conflicts.
