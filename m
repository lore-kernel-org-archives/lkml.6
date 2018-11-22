Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A899C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACA8208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ylHLsHv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACA8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438274AbeKWGMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:12:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732733AbeKWGMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:12:42 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE4020824;
        Thu, 22 Nov 2018 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542915116;
        bh=wJCC+mT1892NeyloTFoQ31f+S3wkO7+SDEY5CgpjRWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylHLsHv0zNNUriQ1GdOT961CQYvSnZtKNk3yIhOVYldrrH85fIa1NmxgD8TnFZpob
         SgPST3WnOzVAOADfGMaiV2PKHLNtMgd3orsA3UFnutN+ha14au58dGxfSbPfhM7fLb
         GuP/du4aIWYwBb0c+zQQyHmOddayPEMFBIpZRT4A=
Date:   Thu, 22 Nov 2018 14:31:52 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.18 39/59] i2c: omap: Enable for ARCH_K3
Message-ID: <20181122193152.GA9725@sasha-vm>
References: <20181114222335.99339-1-sashal@kernel.org>
 <20181114222335.99339-39-sashal@kernel.org>
 <779d8829-c90d-120a-5b7d-749c07d2a2ed@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <779d8829-c90d-120a-5b7d-749c07d2a2ed@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:05:02AM +0530, Vignesh R wrote:
>Hi,
>
>On 15/11/18 3:53 AM, Sasha Levin wrote:
>> From: Vignesh R <vigneshr@ti.com>
>>
>> [ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]
>
>This patch depends on c77245722fb4 ("arm64: Add support for TI's K3
>Multicore SoC architecture") which adds ARCH_K3 Kconfig symbol and
>merged to mainline in v4.19. Since I don't see c77245722fb4 in
>stable tree, please drop this commit from stable queues prior to v4.19
>(4.18, 4.14, 4.9, 4.4 and 3.18).

Dropped, thank you!

--
Thanks,
Sasha
