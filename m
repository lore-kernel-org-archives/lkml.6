Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E94E20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E94E20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJBDsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:48:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:56747 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeJBDsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:48:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w91KpNKg021353;
        Mon, 1 Oct 2018 15:51:24 -0500
Message-ID: <7b94786fb357c70f905a90f9172ab984418271ce.camel@kernel.crashing.org>
Subject: Re: dma mask related fixups (including full bus_dma_mask support) v2
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 02 Oct 2018 06:51:23 +1000
In-Reply-To: <20181001143259.GA5655@lst.de>
References: <20180927223539.28449-1-hch@lst.de>
         <20181001143259.GA5655@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 16:32 +0200, Christoph Hellwig wrote:
> FYI, I've pulled this into the dma-mapping tree to make forward
> progress.  All but oatch 4 had formal ACKs, and for that one Robin
> was fine even without and explicit ack.  I'll also send a patch to
> better document the zone selection as it confuses even well versed
> people like Ben.

Thanks. I"ll try to dig out some older systems to test.

Cheers,
Ben.

