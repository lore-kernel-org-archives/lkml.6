Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DB12086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfBAPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:51:22 -0500
Received: from verein.lst.de ([213.95.11.211]:35533 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAPvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:51:21 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 545E168D93; Fri,  1 Feb 2019 16:51:20 +0100 (CET)
Date:   Fri, 1 Feb 2019 16:51:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Takao Indoh <indou.takao@jp.fujitsu.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Takao Indoh <indou.takao@fujitsu.com>
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190201155120.GA5180@lst.de>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 09:46:15PM +0900, Takao Indoh wrote:
> From: Takao Indoh <indou.takao@fujitsu.com>
> 
> Fujitsu A64FX processor has a feature to accelerate data transfer of
> internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> address is set to 1.
> 
> This patch introduces this acceleration feature to the NVMe driver to
> enhance NVMe device performance.

This has absolutely no business in a PCIe driver, sorry.
