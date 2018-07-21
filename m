Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C57BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC53206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC53206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeGUN0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:26:39 -0400
Received: from verein.lst.de ([213.95.11.211]:41910 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeGUN0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:26:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1F9E768D5B; Sat, 21 Jul 2018 14:37:08 +0200 (CEST)
Date:   Sat, 21 Jul 2018 14:37:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for openrisc
Message-ID: <20180721123708.GA635@lst.de>
References: <20180719130232.1819-1-hch@lst.de> <20180721053142.GC9742@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721053142.GC9742@lianli.shorne-pla.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 02:31:42PM +0900, Stafford Horne wrote:
> For upstreaming, do you want me to send these through the openrisc tree, or do
> you want to send with the dma tree?

Feel free to merge them through the openrisc tree.
