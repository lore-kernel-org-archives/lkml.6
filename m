Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E61C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D347A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yRVYzUfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbeK3BkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbeK3BkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:40:01 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7CE20868;
        Thu, 29 Nov 2018 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543502067;
        bh=E0CGrg640ew5LzSiaxZV6UaU4pF+eMjBKJAsm/e6E2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yRVYzUfEBGloy/C0YXwnk9AljqF9QKMiDdW31aHt9smGkNnq/R7ijCwIq71jfcIcB
         cCt8R8x7JlqOvCZgRFMS8QUvXhg86/kD5Hfz+BiVXmz+GHaU4pGJDjFP/0jWfWziFT
         2o/oBf/pFglfXcPrQDP/lVkpYUffcJXd94YfnWaA=
Date:   Thu, 29 Nov 2018 20:04:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: QCS404 BLSP nodes
Message-ID: <20181129143418.GK3175@vkoul-mobl.Dlink>
References: <20181118200135.25258-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118200135.25258-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-18, 12:01, Bjorn Andersson wrote:
> This finalizes the definition of the BLSP UART, I2C and SPI devices found in
> the QCS404 SoC.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
