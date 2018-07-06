Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07617C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1A220896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaxtsoBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1A220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934514AbeGFF6u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932684AbeGFF6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:58:46 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA5522B27;
        Fri,  6 Jul 2018 05:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530856725;
        bh=FDUa6eB6FzhTVRBA4rxTN20RHE6j4cyfSogldhNHcnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaxtsoBn7NBCmQ2Y27Bn3lt+Ols3Tb0tfXCizXKWvz4opR62wlAlrpJ9YBhcxGAGI
         ow20WRpdwr4ve6rFx7LcNmELTSV9ng2EfPel9ejlY6cPbK94vKVxDP0CA4SrbN9/Vs
         A+O1nk846sEMD4pm38qQrmcyMqkuXG/BejD2LRrk=
Date:   Fri, 6 Jul 2018 11:28:37 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v2] dmaengine: imx-sdma: add missing structure description
Message-ID: <20180706055837.GQ22377@vkoul-mobl>
References: <1530698802-23468-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530698802-23468-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-18, 18:06, Robin Gong wrote:
> Some member description or colons missing cause build warning with
> 'W=1' as below:
> 
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'vd' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'num_bd' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'bd_phys' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'buf_tail' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'buf_ptail' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'period_len' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'chn_real_count' not described in 'sdma_desc'
> drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'chn_count' not described in 'sdma_desc

Applied, thanks

-- 
~Vinod
