Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BA6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8850C2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAtR/GJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8850C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbeKGDOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389392AbeKGDOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:14:44 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D9A20827;
        Tue,  6 Nov 2018 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541526504;
        bh=vbZx1W5N+RmgL75SgJTPwIGMHlSQu+bTEXbhMq/CipU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAtR/GJwn+e7eg0+4RQk5A4TtQ38sZGXxYZm2v7XZvANuUnC+2hPXqe0cDkFak+Ae
         yAMl6nAsNBdjzfAMjMDLYvh692WKFjAEJpDPWkt/iD6zCb3hUVmLy1uBehXBs/bJ3s
         kZNBgOYTjmDSxwNLW6qT08RPk7yjvQBMYuPocWE8=
Date:   Tue, 6 Nov 2018 23:18:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/17] arm64: dts: qcom: qcs404: Add BAM DMA node
Message-ID: <20181106174816.GC12092@vkoul-mobl>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-16-vkoul@kernel.org>
 <20181105191201.GT2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105191201.GT2523@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-18, 11:12, Bjorn Andersson wrote:
> On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:
> 
> > Add the BAM DMA instance found in BLSP1 node of the QCS404
> 
> What about blsp2 bam?

Haven't tested that yet :( Serial helped on this one so added :)

-- 
~Vinod
