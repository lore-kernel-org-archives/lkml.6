Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99899C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A40F217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549271006;
	bh=gCCaxUI2ihsRU8je4qmeQg7XDZWRUxyYtyadjn+1yu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WJu5snjbYp1J5MO2PssiShwMpNaiaLyAzof0hsWpBk/ooNEppyEppSAQD6pgMSmDd
	 8BF5Yk7Wo84U7tKZC1EP4kyduOcNQbLz5u8PxK68ZulZJIoRQVXwwx5GxAEl2kqwzj
	 z6nQrQ42QYjdjKlUHnRQGeRV01nkKpfTpWmCxdpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfBDJDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfBDJDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:03:24 -0500
Received: from localhost (unknown [171.76.74.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A292F214DA;
        Mon,  4 Feb 2019 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549271003;
        bh=gCCaxUI2ihsRU8je4qmeQg7XDZWRUxyYtyadjn+1yu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsFBVisap5WIzXG+1TD7mHBiNEAdJHQ0IloO4oSvpN5No458kgFYJUx+sg47Dxvqh
         LoVjjkNj+fPWfSCVXC9JhgNgVCe65JR9GCj0I8DX3fENuRoh1EdGfogiue1ah7PnOe
         SulgsHR76cmRWLe/hxe6DY/9azrTeZNwfgmZNzB4=
Date:   Mon, 4 Feb 2019 14:31:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
Message-ID: <20190204090154.GM4296@vkoul-mobl>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-01-19, 12:24, John Stultz wrote:
> This patch series is based on recent work by Tanglei Han, and
> adds support for hi3660 SoCs as found on the HiKey960 board,
> along with a few patches I've been carrying.

Applied and fixed the minor style issues in patch 5, and retagged 3 thru
5 to dmaengine: xxx, thanks
-- 
~Vinod
