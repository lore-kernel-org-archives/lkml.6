Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD190C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A87A204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A87A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJONdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:33:54 -0400
Received: from verein.lst.de ([213.95.11.211]:39935 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeJONdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:33:53 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 91FE368C7A; Mon, 15 Oct 2018 07:50:08 +0200 (CEST)
Date:   Mon, 15 Oct 2018 07:50:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/33] powerpc/powernv: remove dead npu-dma code
Message-ID: <20181015055008.GA23344@lst.de>
References: <20181009132500.17643-1-hch@lst.de> <20181009132500.17643-17-hch@lst.de> <7709932d-efb8-2c9b-5128-99cc491c302b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7709932d-efb8-2c9b-5128-99cc491c302b@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:34:02PM +1100, Alexey Kardashevskiy wrote:
> 
> On 10/10/2018 00:24, Christoph Hellwig wrote:
> > This code has been unused since it was merged and is in the way of
> > cleaning up the DMA code, thus remove it.
> > 
> > This effectively reverts commit 5d2aa710 ("powerpc/powernv: Add support
> > for Nvlink NPUs").
> 
> 
> This code is heavily used by the NVIDIA GPU driver.

Not by the that actually exists in the kernel tree, so it simply doesn't
matter.
