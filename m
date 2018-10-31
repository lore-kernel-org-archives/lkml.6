Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF45FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F5720821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zcL9BUv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F5720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJaQme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbeJaQmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:42:33 -0400
Received: from localhost (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A378B20821;
        Wed, 31 Oct 2018 07:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540971934;
        bh=ZKfxSBsgfIjSSqXO8YbZkl3uWPGxfOadLFKbAKajKHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zcL9BUv7koBFKrq+02rjmWmPPHURoDw7Zvv7wjRLz0c29imiTldNizZmYkovuH8cY
         B4us3QqNnxatCNNPRfHnteDSc3xAt04R5wHY03JBSUpzUuwOvZQrFYCla2uM8CdA07
         Uqs9dEaLR/8JBJM1Qk29aeSN+DnUh1VPC4aeAdDQ=
Date:   Wed, 31 Oct 2018 13:15:24 +0530
From:   Vinod <vkoul@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH v1 0/4] thermal: tsens: Add support for QCS404 platform
Message-ID: <20181031074524.GI12092@vkoul-mobl>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539627762.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-18, 00:10, Amit Kucheria wrote:
> Add support for the Qualcomm QCS404 platform that contains v1 of the TSENS
> IP. Introduce a fallback binding to handle "v1" functionality.


Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
