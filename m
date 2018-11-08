Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4907ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A745120684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSoZ5SVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A745120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKIDe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeKIDe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:34:26 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D049320684;
        Thu,  8 Nov 2018 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541699868;
        bh=nl/LWSJQlY368GrGavLMCwT7STv00Vf6HqGoplg7PAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSoZ5SVHLrWSpdSZ+wFgs+8gm1jZJM+Vlk98JzoMHfrR7B39huqApfDP93ikyAXPE
         tB8iAZ41pGph2JEggZtrYD8v7YT13bdD/Kanvwefi7R0xjRCHfLEm0GcPdo+SRhAGa
         yfRgIugd39/J2GY1poNTBhwGcNBBjJQiZ7NJ5U4w=
Date:   Thu, 8 Nov 2018 23:27:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/18] arm64: dts: qcom: qcs404: Add Device tree nodes
Message-ID: <20181108175739.GG12092@vkoul-mobl>
References: <20181108175049.7090-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108175049.7090-1-vkoul@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-18, 23:20, Vinod Koul wrote:
> This series adds support for various nodes for QCS404-EVB.
> 
> Based on v4.20-rc1
> 
> Changes in v3:
>  - Make the DTS files sorted alphabetcially and by node addresses
>  - Add reviewed by from Bjorn
>  - Split out the DTS files for EVB 1000 and EVB 4000 boards and add common
>    evb dts files for common part

Sorry I sent out the wrong branch :( will send updated one shortly,
apologies for the noise

-- 
~Vinod
