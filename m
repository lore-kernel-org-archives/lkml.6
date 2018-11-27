Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763CB20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763CB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeK0SeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:34:15 -0500
Received: from verein.lst.de ([213.95.11.211]:57076 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbeK0SeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:34:14 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 37E5A68BDF; Tue, 27 Nov 2018 08:37:15 +0100 (CET)
Date:   Tue, 27 Nov 2018 08:37:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: move the arm arch_dma_alloc implementation to common code
Message-ID: <20181127073715.GA30033@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181109075238.GA27578@lst.de> <20181115195041.GC4535@brain-police> <b3267453-0c2d-4bda-2122-d6212967dafc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3267453-0c2d-4bda-2122-d6212967dafc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:58:04PM -0800, Robin Murphy wrote:
> On 2018-11-15 11:50 am, Will Deacon wrote:
>> On Fri, Nov 09, 2018 at 08:52:38AM +0100, Christoph Hellwig wrote:
>>> Can I get a quick review from the arm64 folks?  I think it should
>>> be fine there as it basically is a code move, but an additional pair
>>> or two of eyes always helps to weed out bugs.
>>
>> I reviewed the arm64 parts, but it would be ideal if Robin could have a look
>> as well.
>
> Yup, from a quick skim the general shape of the whole series looks 
> pleasing, but I've been holding off going through it in detail until I've 
> figured out what's up with the last thing I thought I'd reviewed 
> exhaustively...
>
> Either way I'll make some time for a proper look next week once I'm back.

Did you get a chance to look over this?
