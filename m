Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D92C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC08921871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546614064;
	bh=/zwwNu++gfkmKjPWwxQJjZZPc5F2wQfM4f/iVJ3vzEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2iO8cPMVBryEi6D2g1tCafYnhxAK4O0sJ1h2jGHuc/sOEPRNaIpnsYPQJZGoa3TiP
	 U2j8OW02HfqNM1Olvv4A/b5DZ2PzP9xf7nPYn3b4pda+yx4ZiBiTkGu9/tFiLfqXIU
	 oGmTcb5GVQ40nGz+wev8EQLA6kkX0mU5I8uzaCxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfADPBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbfADPBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:01:03 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D853A2087F;
        Fri,  4 Jan 2019 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546614062;
        bh=/zwwNu++gfkmKjPWwxQJjZZPc5F2wQfM4f/iVJ3vzEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyKFB4dj0IIAk7hKnjzC5TziXU43j8Q0TLIqSlYzJaDRGW76YaanJ20jDX6dwn1Jr
         XWyFXTSAznXRI/EYpYsZrp5E8t8QE+9zM1HD14QdvFFHnK3cyAVs+xpr8gSbopl8CY
         SMGpPiCRoNvTwQLhQDTp8PSzgz69Dzcmd14sjbBU=
Date:   Fri, 4 Jan 2019 20:29:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v6 1/7] dmaengine: xilinx_dma: commonize DMA copy size
 calculation
Message-ID: <20190104145924.GG13372@vkoul-mobl.Dlink>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-18, 16:31, Andrea Merello wrote:
> This patch removes a bit of duplicated code by introducing a new
> function that implements calculations for DMA copy size, and
> prepares for changes to the copy size calculation that will
> happen in following patches.

Applied all, thanks
-- 
~Vinod
