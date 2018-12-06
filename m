Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F97C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6309B208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544058202;
	bh=fp6YQJQ+2ktuQldreucjw5Y0QwE7iamNV2fcco2bcB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wuMajKrGGjrlsqpx1L6Ct3bggsCteaZjFAI9aFztGK6XcIZfg0IeKntwHmJqLRivF
	 G2RYTB5PxH2QAKCW1X341ISTEOzoNVhzFrW/M8wsD3DPja/k5ruK4FV9cCFMY9u7fX
	 r4PLuWxQQuhNT6+Y6NOQF/bFX8ONXRo1ShE9xojc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6309B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbeLFBDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLFBDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:03:20 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E39B20879;
        Thu,  6 Dec 2018 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544058199;
        bh=fp6YQJQ+2ktuQldreucjw5Y0QwE7iamNV2fcco2bcB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLFtWDqgEMvhudW4QrpwNhEv5WEDqGgNt9pHUoZEjhTtahWeCImttY7LXbUL7nc8q
         4ALDXK7jjSqK2hTuKbwRq2y3qSlkEdhDStkimPO/gT09f2k7lHLCw+IyNDaYrAV04s
         mvr2WmNdQN4uI9lAxbMUF6G4RL44x1MbCsyb5Mkc=
Date:   Thu, 6 Dec 2018 09:02:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Wen He <wen.he_1@nxp.com>
Subject: Re: [v11 4/7] arm: dts: ls1021a: add qdma device tree nodes
Message-ID: <20181206010237.GP3987@dragon>
References: <20181030023604.34027-1-peng.ma@nxp.com>
 <20181030023604.34027-4-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030023604.34027-4-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:36:01AM +0800, Peng Ma wrote:
> add the qDMA device tree nodes for LS1021A devices.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
