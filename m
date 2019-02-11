Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD11C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D920873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549851581;
	bh=WBip9+yQal7fzQiqL8/PA7bzT8kCaPqfkOfQz3RPd1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WRLYe63wUIJ9hlyVCnvV5y+Gf4pOSE/a+cH668V6VakHAeI+WfDsTR6CTCISnoIpZ
	 Uq+Iz4v84qT2A1gBM1GmJcv72rA8Tjy9mra0EXCMNMCsP5nGjqlDiMdpI7cRUm7W2Q
	 W/HCHh7aurTZYPjfeAT6fmhHDRjherHdO6+E8Zvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBKCTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 21:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfBKCTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 21:19:35 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE472084D;
        Mon, 11 Feb 2019 02:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549851575;
        bh=WBip9+yQal7fzQiqL8/PA7bzT8kCaPqfkOfQz3RPd1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wA4hBMNG0KU/HJfGcK4MwX7WtKoBn1HOfnh9HIwOQpKlrnf2vdEU1dyoWnOMfzfzF
         GF4amOxyMsMkBw+wVYx5DoOgCURtZF/Fvl9mU3dnUW1u9hWYOMeP6G2H2hUGVNYP8p
         55kXWl1220qVbNtRNH5iCHxCDLX9irQoYoAJklgg=
Date:   Mon, 11 Feb 2019 10:19:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add RTC support
Message-ID: <20190211021921.GE22487@dragon>
References: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:01:22PM +0000, Abel Vesa wrote:
> Add RTC support for i.MX8MQ.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
