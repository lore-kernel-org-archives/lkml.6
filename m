Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E0C218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfADSLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:11:41 -0500
Received: from verein.lst.de ([213.95.11.211]:41082 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:11:40 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3E39E68D93; Fri,  4 Jan 2019 19:11:39 +0100 (CET)
Date:   Fri, 4 Jan 2019 19:11:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix the wrong setting of nr_maps
Message-ID: <20190104181139.GA25557@lst.de>
References: <1545621353-1443-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545621353-1443-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, this looks like some sort of merge error.

Applied to nvme-4.21.
