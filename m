Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B74C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A742D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebTtlnHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A742D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeIKM2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeIKM2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:28:00 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6AA20865;
        Tue, 11 Sep 2018 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536651002;
        bh=2ADZAPA+oOEOKQA5tW1u/Y95m+EabwiGs8TtKaRMAeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebTtlnHiECsYWtz8LVq4xtXzjNXCdKi6CeuDCB6k0PzyryReOAccPFAnJ33z5jN1n
         4U/4ObxrF8TYDAyTeJhZ6HWPhlapfVonDNoX7aK5m70nKvzlCk4GpzMA9QRWnyPaqU
         GEhcRwFPurz19DrzgmJpgmoPpUdB+u/8dVbTiV2E=
Date:   Tue, 11 Sep 2018 12:59:52 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 00/18] JZ4780 DMA patchset v5
Message-ID: <20180911072952.GJ2634@vkoul-mobl>
References: <20180829213300.22829-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-18, 23:32, Paul Cercueil wrote:
> Hi Vinod,
> 
> This is the V5 of my Ingenic JZ4780 DMA patchset.

Applied all, thanks

> 
> - Patch [01/18] dropped the "doc:" in the patch title;
> - Patches [11/18] and [12/18] now use the GENMASK() macro.
> - The rest is untouched.
> 
> Thanks,
> -Paul Cercueil

-- 
~Vinod
