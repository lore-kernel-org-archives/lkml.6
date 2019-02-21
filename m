Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542662084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfBUNk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:40:26 -0500
Received: from verein.lst.de ([213.95.11.211]:36423 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfBUNkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:40:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CBCF268CEB; Thu, 21 Feb 2019 14:40:24 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:40:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] MIPS: BCM63XX: provide DMA masks for ethernet devices
Message-ID: <20190221134024.GA20320@lst.de>
References: <20190221095642.26962-1-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221095642.26962-1-jonas.gorski@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:56:42AM +0100, Jonas Gorski wrote:
> The switch to the generic dma ops made dma masks mandatory, breaking
> devices having them not set. In case of bcm63xx, it broke ethernet with
> the following warning when trying to up the device:

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
