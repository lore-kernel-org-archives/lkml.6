Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27E8208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wChi7e4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27E8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIZP3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbeIZP3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:29:16 -0400
Received: from dragon (unknown [45.56.155.164])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77DAF20842;
        Wed, 26 Sep 2018 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537953436;
        bh=TPQ34Kc9TEgSSN8IpTT2aFdZ71JT9QDEsSpRVtfc0AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wChi7e4LpjqykMym7kbo7JSR1jkq2W8YbcR/e0N0/Dm5qW19XULLHsXR41iAiWBz6
         Ts5uvEYzyz2QzRpM07evp0CSkAak/XF/cCp+aacKGehXJajBWuEFplRQEPVOMhbhbH
         WPdc4dVqCBYbOY/RvIsAPJL4kIwzgLaN6Y51NXr4=
Date:   Wed, 26 Sep 2018 17:15:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed
 grading
Message-ID: <20180926091533.GD26692@dragon>
References: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:59:21AM +0800, Anson Huang wrote:
> On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first, so use the nvmem-cells binding instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied this one, thanks.
