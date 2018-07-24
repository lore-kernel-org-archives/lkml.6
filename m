Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF33C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B1120875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw07A1gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B1120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbeGXHBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388196AbeGXHBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:01:14 -0400
Received: from localhost (unknown [106.201.120.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C6E20856;
        Tue, 24 Jul 2018 05:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532411788;
        bh=RkQYC1kxq83LtafQ1F45BSfhXIUJ058jJPEjkQAkULQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iw07A1gCJD8kQj+QzKxkXzkwDcucKY0L63KCBBaleCZt8BhX/orCH5faI5vQTFrVF
         a83IxCL/LmvZwLoV4eGWE4MUoMdjlc5y27cZm0eEv59vd4JY0OQb7zH2wvmlxGfaBt
         UcmSyBcTn/DH498vBB+0zo2hfg1UcoARgn/3kHB4=
Date:   Tue, 24 Jul 2018 11:26:20 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/12] mfd: dt-bindings: Add wcd9335 mfd bindings
Message-ID: <20180724055620.GJ3219@vkoul-mobl>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723155410.9494-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-18, 16:53, Srinivas Kandagatla wrote:
> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
> Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
> the MSM8996, MSM8976, and MSM8956 chipsets. It has in-build

in-built perhaps?

-- 
~Vinod
