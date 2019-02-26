Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF992173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfBZJRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:17:19 -0500
Received: from 8bytes.org ([81.169.241.247]:41270 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfBZJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:17:19 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B493F41A; Tue, 26 Feb 2019 10:17:17 +0100 (CET)
Date:   Tue, 26 Feb 2019 10:17:15 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Message-ID: <20190226091715.GA19617@8bytes.org>
References: <20190128094301.151252-1-drinkcat@chromium.org>
 <20190130182137.GN18558@fuggles.cambridge.arm.com>
 <CANMq1KAsZHZ42Kt98eSy8Lmh+87S9cob2uSNWjZtLDrWmEEk3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KAsZHZ42Kt98eSy8Lmh+87S9cob2uSNWjZtLDrWmEEk3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 08:21:46AM +0800, Nicolas Boichat wrote:
> Joerg: Just to make sure, is this patch in your queue? Thanks.

It is now, thanks.

