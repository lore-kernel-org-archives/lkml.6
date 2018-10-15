Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FEFC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDE2208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9pIUCnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDE2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJPAxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeJPAxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:53:25 -0400
Received: from localhost (unknown [106.201.39.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61608208AE;
        Mon, 15 Oct 2018 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539623240;
        bh=UYaB7YXdEiZMsIUW/cwkAaiGi73UuQuG7o0eBUQc3ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9pIUCnSKXtamEck4cUeIyi3hI0UMbRyvhC5oVw0rWMyRslOp0VVGWOm10WD7oBdM
         Cq6/0zd05qlhy2BPnbFCFrmu/EE8zhWVOBTysfZVuuZnjnTqJBfKQDArJ49jC4YxGL
         rqTFOWhczKNiwWEk/AjQY19ZkJ2K159HNutsmtnc=
Date:   Mon, 15 Oct 2018 22:37:11 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Wen He <wen.he_1@nxp.com>
Subject: Re: [PATCH 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by
 FSL_DMA_IN/OUT
Message-ID: <20181015170711.GK2400@vkoul-mobl>
References: <20181011094655.45707-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011094655.45707-1-peng.ma@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-10-18, 17:46, Peng Ma wrote:
> From: Wen He <wen.he_1@nxp.com>
> 
> This patch implement a standard macro call functions is
> used to NXP dma drivers.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Please read Documentation/process/submitting-patches.rst, we expect each
patch you send to have your signed off and signed off from orignal
authors

Also as Rob pointed out this patch series should be v8 or so as this is
following the previous work submitted to the list

Please also indicated changes from last rev which help in the review.


-- 
~Vinod
