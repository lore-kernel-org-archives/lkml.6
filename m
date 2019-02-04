Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAAFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C1F217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549263903;
	bh=XcqyzFC2TFTTtXDlpve6vVmTMZhYC0RKNB5E/l808qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mFyAmr3oOnaboZvrGBzTTEXCECafvMYpXstGjZu9eeEsMY0m6Yt/zeag5is3/oPDf
	 uNSGmlWBZ8wS7/FZwmkQ8dNvZebuzmGS8rddcGE4oqSov7ILtjroj4U5pzysDb4sHb
	 4xHKYP9jx0jkyrEggwFrjBpztSUvD+fxr5TchNBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfBDHFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfBDHFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:05:01 -0500
Received: from localhost (unknown [171.76.74.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A7A20815;
        Mon,  4 Feb 2019 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549263900;
        bh=XcqyzFC2TFTTtXDlpve6vVmTMZhYC0RKNB5E/l808qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nA+0+xtdxRlMEpDAWZzwqdwmo32IxAxXIwwa3o+yuCE52Fnc+lBZAXDMtFqFpomW/
         Xo9EKqpLglCz2PfFTmB6KhX3yJUYDEvk7b0dyJaZ06K9KBgBJgFJcU2DV+9qED9lef
         tNx/2pfJOUMo7+PV6dnuQmh+cJFW9Qj+PDM+ECn8=
Date:   Mon, 4 Feb 2019 12:33:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com
Subject: Re: [PATCH] dmaengine: fsl-edma: dma map slave device address
Message-ID: <20190204070330.GG4296@vkoul-mobl>
References: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-19, 12:06, Laurentiu Tudor wrote:
> This mapping needs to be created in order for slave dma transfers
> to work on systems with SMMU. The implementation mostly mimics the
> one in pl330 dma driver, authored by Robin Murphy.

Applied, thanks

-- 
~Vinod
