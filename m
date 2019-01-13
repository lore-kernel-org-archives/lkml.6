Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF58BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B722133F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547347254;
	bh=a9m+OtFuKnp20GxOytToM0mpD+ugRqPkn6hncnYCeIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nZRG43suSmXoggc4C19UTPIzHuvgjHQxlU7Uiwi1HqAPHHWWSXPRaEEOMB6oq8Ffn
	 +7AVeGI+EdOggseKwKvqGDNE+DX2QCXfxasiXpR150fJj6pwIoPjSAtT0dZCX+2zbl
	 Zmhcd9pPH+/fX/7WUa8HyPXwz9xaCxfQRAqxos5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfAMCkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 21:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfAMCkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 21:40:53 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF0C2063F;
        Sun, 13 Jan 2019 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547347252;
        bh=a9m+OtFuKnp20GxOytToM0mpD+ugRqPkn6hncnYCeIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2iPQ37gHteUV0q1Sr4gXuZ7UMSRC/ImlzB+Ihf5dzcH1dsjaNvQowNnGo0D0/cOBH
         d2jG9qvME8mqO04My8W+ZvKPcxQKtQq0Ff44gZ7huYMiF/Vvhe1OanjQrkasYIAvAs
         hdhTY8FK9JdAEFPWgrCTT/wdP2skplo4KegEEthQ=
Date:   Sun, 13 Jan 2019 10:40:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6sx: correct backward compatible of gpt
Message-ID: <20190113024036.GE11426@dragon>
References: <1546077384-5343-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546077384-5343-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 10:01:18AM +0000, Anson Huang wrote:
> i.MX6SX has same GPT type as i.MX6DL, in GPT driver, it uses
> below TIMER_OF_DECLARE, so the backward compatible should be
> "fsl,imx6dl-gpt", correct it.
> 
> TIMER_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
