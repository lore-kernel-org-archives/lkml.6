Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C14EC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3CA214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbeLSQ7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:59:42 -0500
Received: from verein.lst.de ([213.95.11.211]:48161 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbeLSQ7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:59:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9C8FA68AFE; Wed, 19 Dec 2018 17:59:39 +0100 (CET)
Date:   Wed, 19 Dec 2018 17:59:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: Re: ensure dma_alloc_coherent always returns zeroed memory
Message-ID: <20181219165939.GA26087@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214082515.14835-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I've picked this up for dma-mapping for-next now.
