Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5410C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9655A20833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548908167;
	bh=/zZvhYd0VGdsV7BF7WxAJ7nWi1/WUUedIQYhmzPckzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iQ3BlLkL+wRN8kAfvWe8uILAvN33DO/H+loaOiFM3LSpjgqM9EiDWnyrASQookXeM
	 j3toYqi4hTPUXFhxQDAq+L04mdUIal4ISdcVJUAKksK+aqthfoN5wNGhAQpDFIUb0O
	 GLMXv9GQXCeZWJVKNE79TAxenI13uNbp3jqARd1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfAaEQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:32994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfAaEQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:16:05 -0500
Received: from localhost (unknown [171.76.100.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5DE20833;
        Thu, 31 Jan 2019 04:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548908165;
        bh=/zZvhYd0VGdsV7BF7WxAJ7nWi1/WUUedIQYhmzPckzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjplm7F4ctZyeoTqxVPugirNcK54s25NLrgcnH9qS2dZZBpTPWIPE7BpuziXmq7Q1
         TRdaAofgsT4W70gpVY7EvWRisYHixAyioD6L+x/3mfUeNL/M7qX0GgmD3t1dmb9i+K
         8ES9a5E/0oHeTnXTysaQ5sNjIAgnhspO79Hu8tWg=
Date:   Thu, 31 Jan 2019 09:44:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add rpmcc node
Message-ID: <20190131041434.GI4635@vkoul-mobl>
References: <20190125181422.21434-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125181422.21434-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-01-19, 10:14, Bjorn Andersson wrote:
> Add the rpm clock controller node, to provide the low-noise baseband
> clock for the USB PHYs, among other things.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
