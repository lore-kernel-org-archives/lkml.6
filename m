Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22204C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65FB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549957851;
	bh=y54w9EVZv3V4cIoqB14SOBglamNvK7jiiy/RQSg6X5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X9/uPZwyW9ulafT7n/XrFXsshWL6sr8mLKZOTLYfrsDxY1+G+vOqKunCB3ABA+uk8
	 7ovbWNEWk8Knv9cTxPTMVYIzZ5r+1hbYtwzMpBLfS/X/kkYMZWF9VjyqriZkL7FJVa
	 VG6N6XsQcSm/DxnSFNZZ/qRUi4x/FqqLyoDFHMFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfBLHut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfBLHut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:50:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C93F206BA;
        Tue, 12 Feb 2019 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549957848;
        bh=y54w9EVZv3V4cIoqB14SOBglamNvK7jiiy/RQSg6X5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4ob1CoclM+2KgvxA8amFcdXCyApEpbZ5eSfbs/Fk51eeAHy55EsXsTUkCtwgtrS4
         QXxd1VWIhcst00kfjK25dVwATnNhcqIdtqk24VFh3JTUd5YbDv8EG9NBNuewmYRSb1
         05PU4ofDaxp+G3bEZZtHF/W2Stb7n6g7TLXWaUXQ=
Date:   Tue, 12 Feb 2019 08:50:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] dma-mapping: move CONFIG_DMA_CMA to
 kernel/dma/Kconfig
Message-ID: <20190212075046.GD5924@kroah.com>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211133554.30055-8-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:35:49PM +0100, Christoph Hellwig wrote:
> This is where all the related code already lives.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/Kconfig | 77 --------------------------------------------
>  kernel/dma/Kconfig   | 77 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 77 deletions(-)

Much nicer, thanks!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
