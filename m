Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C69920867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuczvUzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C69920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeIDR6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeIDR6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:58:10 -0400
Received: from localhost (unknown [171.61.91.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08D920659;
        Tue,  4 Sep 2018 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536067980;
        bh=BrHJh3l4UOtaITkskeESl134o+ZNNMzBUyWhnLMFPSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuczvUztObCPm/5VWybhfJFtelRGPlrNcMy7vDjJ8FLPUGT3pycpeZyg8LsSJS2Bd
         a36yUC4s4ZPwvm0H9sItWDhvtONQ13cCdejRzT2he+wTnb7ZtsqMzdcOkkZTgW4m6R
         7pf+UystGPR/0LNhDz8LK1IfBCgf+gu3epez7qXU=
Date:   Tue, 4 Sep 2018 19:02:50 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        devicetree@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 1/3] ASoC: q6asm-dai: dt-bindings: Add support to
 compress dais
Message-ID: <20180904133250.GJ2322@vkoul-mobl>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
 <20180903123455.9290-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903123455.9290-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-18, 13:34, Srinivas Kandagatla wrote:
> This patch adds board specific bindings required for dais, In particular
> for compressed dais and dai direction.
> 
> Board specific setup involves setting up some of dais as compressed dais
> and also specify direction of any dai. Some of the dais might only
> support capture/playback depending on the board level wiring.
> 
> These two new dt properties will allow such flexibilty at board level dts.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
