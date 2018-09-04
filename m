Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B358C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FD4206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FD4206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeIEBe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:34:28 -0400
Received: from verein.lst.de ([213.95.11.211]:42389 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbeIEBe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:34:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ECAF768D00; Tue,  4 Sep 2018 23:11:07 +0200 (CEST)
Date:   Tue, 4 Sep 2018 23:11:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Message-ID: <20180904211107.GA8202@lst.de>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com> <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 01:14:49PM -0700, Vineet Gupta wrote:
> Apologies for the delay in getting to this - series applied and pushed to for-curr

This is going to create really annoying merge conflicts with
work pending for the dma-mapping tree.  That's why I requested earlier
to merge it either via the dma-mapping tree or some shared branch.
