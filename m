Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7BDECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FE020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+2xxctb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FE020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbeGXOOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388295AbeGXOOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:14:50 -0400
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB2F20874;
        Tue, 24 Jul 2018 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532437705;
        bh=gh8M3RsLkOlq21ztZGDCkNmj6QeZKzuHwORTvldK7rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+2xxctbM51RnG0jZhipsMpX/QYJZbCkzI+ql+HfIc/pKn/Ls7qmbgtRxOjXgYtqi
         v0W9nVbWKSP47GsWVR3MJlNAIK49DqNqZ5ipqoYAdImAvZN2BKzyrsMpyfTLg6q5hp
         MDVLdN1y6WVhJSzJyEXXzeZXbsZYE3oIw3wow4qA=
Date:   Tue, 24 Jul 2018 18:38:16 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: Add binding for Actions Semi
 Owl SoCs
Message-ID: <20180724130816.GC3661@vkoul-mobl>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
 <20180723041743.32024-2-manivannan.sadhasivam@linaro.org>
 <20180724121604.GA2587@vkoul-mobl>
 <b3db9b84-d01a-408d-e3f7-fdc61bbedb38@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3db9b84-d01a-408d-e3f7-fdc61bbedb38@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-18, 14:19, Andreas Färber wrote:
> Hi Vinod,
> 
> Am 24.07.2018 um 14:16 schrieb Vinod:
> > Patch title should be dmaengine: ... Please always use the apt tags and
> > one can find them using git log <subsystem>
> 
> Do you mean dt-bindings: dmaengine: ...? Because this is clearly a DT
> binding and not a driver patch.

for the driver patch :)

-- 
~Vinod
