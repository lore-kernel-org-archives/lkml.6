Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB8EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286842089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcH6+7KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286842089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbeGKNT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732641AbeGKNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:19:26 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2D120846;
        Wed, 11 Jul 2018 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531314909;
        bh=2nnNQirWrdfGwHRjuNgnaBzZHHvyPveMqpIWQw5QmBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcH6+7KXOGuuTiKqVl+4WOpAFJ1ko6BN8q6gMkgXy4A6m2TSRLl+Mrx+hdLBPb+g/
         H9bVkUMeUhjnO0nwruKEfSzDPMWAPPQ8Gg5+qFl5u+q3zL7Q59O0AlLgx+ozA0Rola
         fO6c6aT2ACglyBabtQNkbJMbd4PsgZe3IPIr3SDM=
Date:   Wed, 11 Jul 2018 21:14:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx: add ocram_s support
Message-ID: <20180711131431.GJ6959@dragon>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
 <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531270739-3075-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:58:59AM +0800, Anson Huang wrote:
> i.MX6SX has a 16KB always-on ocram bank called
> ocram_s, enable it as another mmio sram.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Since the clock ID has already been defined before, this dts patch can
be applied independently to clock driver one.

Applied, thanks.
