Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03739C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35B7218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfADSL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:11:56 -0500
Received: from verein.lst.de ([213.95.11.211]:41090 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:11:55 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9489B68D93; Fri,  4 Jan 2019 19:11:54 +0100 (CET)
Date:   Fri, 4 Jan 2019 19:11:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: pci: Use the same attributes when freeing
 host_mem_desc_bufs.
Message-ID: <20190104181154.GB25557@lst.de>
References: <20181229172343.27300-1-liviu@dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229172343.27300-1-liviu@dudau.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-4.21.
