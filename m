Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F7C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A7E21C36
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/6rDsTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A7E21C36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeHIFJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeHIFJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:09:33 -0400
Received: from localhost (unknown [122.167.122.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E34421C2B;
        Thu,  9 Aug 2018 02:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533782822;
        bh=ZsuV57SUjtixXYoHVwWM7g7ojyczHHU5kcmfCO+FoKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/6rDsTUlSZW0pZ845DhSXvLkRn33SJxMhe+SpE5TJA0h5wcln78RbYlFe8Xh7FAU
         cBPzFDPHmSGql0GL1SgAGctDkZYSNWFPq9PRT7L1MdVDsFPyUKVn4RJr/nl0XxRnez
         j4Kc0TkzIbPCw61tyLn6R+cCU3V1qP9/yEzjPzbg=
Date:   Thu, 9 Aug 2018 08:16:58 +0530
From:   Vinod <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH v3 3/4] dmaengine: Add Actions Semi Owl family S900 DMA
 driver
Message-ID: <20180809024658.GR2395@vkoul-mobl>
References: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
 <20180726050658.1399-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726050658.1399-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-18, 10:36, Manivannan Sadhasivam wrote:
> Add Actions Semi Owl family S900 DMA driver.

Applied, thanks

-- 
~Vinod
