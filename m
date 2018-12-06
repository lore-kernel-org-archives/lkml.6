Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2E020850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2E020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLFPA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:00:56 -0500
Received: from verein.lst.de ([213.95.11.211]:57689 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLFPAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:00:55 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3238668D83; Thu,  6 Dec 2018 16:00:54 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:00:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] csky, h8300, riscv: remove <asm/scatterlist.h>
 leftovers
Message-ID: <20181206150054.GA25702@lst.de>
References: <20181109090008.24150-1-hch@lst.de> <20181109090008.24150-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109090008.24150-2-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like generic-y is mostly going away anyway, so I'm going to skip
this to avoid conflicts with the kbuild tree.
