Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEF020851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1vk3dmrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEF020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeLEI5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEI5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:57:37 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA592084C;
        Wed,  5 Dec 2018 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544000257;
        bh=mtSppcnR7BU3OhYZ/Wef9lpXOaQs5IgCK2l3+Zyoqfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vk3dmrjsAh5TLsMKuIbnhul9F283n7AnUg/f2Fp9xAakDl23BQBp5KNzSM86L0fY
         ZH+W+a4k9lGBTEnGJjUEJJMLiSqg/yizNqvaqTkuTOx/usW2FoADIB2wjWDv+pR0QV
         +xnGoUF2i12ewX/bYH8Prg1a5yhv3CxMFRj6IZlE=
Date:   Wed, 5 Dec 2018 14:27:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@unisoc.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/7] Add some fixes and new feature for SPRD DMA
Message-ID: <20181205085728.GH2847@vkoul-mobl>
References: <cover.1541480353.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-18, 13:01, Baolin Wang wrote:
> This patchset removes the direction usage from struct dma_slave_config,
> and add one new field to save the direction. It also fixes some issues
> for link-list transfer. Moreover this patchset adds new 2-stage transfer
> support for our DMA.

Applied, thanks

-- 
~Vinod
