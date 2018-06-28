Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87748C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5926F90
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPJYEWCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE5926F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbeF1Fyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeF1Fyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:54:37 -0400
Received: from localhost (unknown [106.201.104.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA2026E51;
        Thu, 28 Jun 2018 05:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530165276;
        bh=KaOiyUWEORTL1g9NceXdtsdt+VHmLlQRHZQSdpyhXWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPJYEWCXq6C5ZGuoKjLamNMmZDxiqHqwDHJAI3Tt9WHKc1e5GSMjEJrNS50K0PyYm
         fxLduMgs6mRG3pbRFx5oZIoPKIk6s5OTUYpqOO51N/RtjFCZfMhTRcRrbwVu/MgSNj
         lzEGyC3Xp2/VSkhxKENbuD/kQ4S84Texjd9jN8w8=
Date:   Thu, 28 Jun 2018 11:24:28 +0530
From:   Vinod <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: pl330: report BURST residue granularity
Message-ID: <20180628055428.GM22377@vkoul-mobl>
References: <CGME20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4@eucas1p2.samsung.com>
 <20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4~5klprrrtK1347113471eucas1p2M@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4~5klprrrtK1347113471eucas1p2M@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 15:20, Marek Szyprowski wrote:
> The reported residue is already calculated in BURST unit granularity, so
> advertise this capability properly to other devices in the system.

Applied, thanks

-- 
~Vinod
