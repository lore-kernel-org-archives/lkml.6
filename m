Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDD4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D0D222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436947AbfBMVr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:47:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:47:27 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC2C51389;
        Wed, 13 Feb 2019 21:47:25 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:47:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] of: fix kmemleak crash caused by imbalance in early
 memory reservation
Message-Id: <20190213134724.f134e3388b591016e96cbf56@linux-foundation.org>
In-Reply-To: <20190213211329.GD15270@rapoport-lnx>
References: <20190213181921.GB15270@rapoport-lnx>
        <20190213121237.b6df41e4fb6317e58c0716a3@linux-foundation.org>
        <20190213211329.GD15270@rapoport-lnx>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 23:13:29 +0200 Mike Rapoport <rppt@linux.ibm.com> wrote:

> > > As a bonus, since memblock_find_in_range() ensures the allocation in the
> > > specified range, the bounds check can be removed.
> > 
> > hm, why is this against -mm rather than against mainline?
> > 
> > Do the OF maintainers intend to merge the fix?
> 
> There's a conflict this fix and resent memblock related changes in -mm.
> Rob said he anyway wasn't planning to to send this for 5.0 [1] and
> suggested to merge it via your tree.
> 
> [1] https://lore.kernel.org/lkml/CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com/

OK, thanks, no probs.
