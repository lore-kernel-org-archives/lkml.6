Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5DC20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RzxNeoSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5DC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIDRL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:11:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51696 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIDRL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=syCamkU+UTFIEXM42Eazv0r4YIyRinzhtaoVxQy82wA=;
        b=RzxNeoSzkJRfutxL/YRcU9ETWrRtgEUcGe4/jLmeWiAPAbNTf9INa24uuTEnncbQOQQz8XB1VsW/iVqCA+xDoAiYCwHFmslRdyqNYE+lYQeduk/Jl1/M60I0ZRuF+Nyjoc/vc3Zb4I8RZcfp7dDIm72SwUDPes96UcoHCZNjAbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fxAiq-0007jx-HD; Tue, 04 Sep 2018 14:46:20 +0200
Date:   Tue, 4 Sep 2018 14:46:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     sunil.kovvuri@gmail.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        davem@davemloft.net, Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH v2 00/15] soc: octeontx2: Add RVU admin function driver
Message-ID: <20180904124620.GC29121@lunn.ch>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 05:24:35PM +0530, sunil.kovvuri@gmail.com wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
> 
> Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> PF0 is called administrative / admin function (AF) and has privilege access
> to registers to provision different RVU functional blocks to each of
> PF/VF.

Hi Sunil

Please keep netdev in the loop. The people with most experience with
PF/VF tend to hang out there, not arm-soc.

      Andrew
