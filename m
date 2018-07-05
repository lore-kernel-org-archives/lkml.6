Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6082123EFE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT1sO1Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6082123EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeGEHhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753002AbeGEHhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:37:11 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94802224E7;
        Thu,  5 Jul 2018 07:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530776231;
        bh=VMD5Lnj4/EYfy7Yjk7JaP9cKAc9KRpP/Imh8kZCfqNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hT1sO1BjZzam9gbvhF4xEroZL1vQl9/kMrGHkxYPnCso3wI5J71OfYmPSyNuzqfyE
         q/bWGJgFY+XfENJy0wSyuZu8nleR5j+yBA+Hd00mVJ/ib60B5TobCh5uVai15AecpC
         LoFH3+6aqrNXnGLPw2fOV3oLGUZBolUoaAKi+MCQ=
Date:   Thu, 5 Jul 2018 13:07:03 +0530
From:   Vinod <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, dmaengine@vger.kernel.org,
        Angelo Dureghello <angelo@sysam.it>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: Re: [BUG] Serial/dma stall/failure after "dmaengine: fsl-edma:
 extract common fsl-edma code (no changes in behavior intended)"
Message-ID: <20180705073703.GJ22377@vkoul-mobl>
References: <CAJKOXPcVFrkEA4YV3gi-gPYhtTXHeKtv4CvL29gstfTacz2sMg@mail.gmail.com>
 <0f3e3ba4-d9fc-ee66-23c2-319db48cd622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3e3ba4-d9fc-ee66-23c2-319db48cd622@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-18, 18:10, Randy Dunlap wrote:
> On 07/04/18 01:54, Krzysztof Kozlowski wrote:
> 
> BTW, there is also this warning in linux-next:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-edma-common.o

That has been fixed.

-- 
~Vinod
