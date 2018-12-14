Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCCBC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E488208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544825064;
	bh=DiHJc3MJPqvNmdCgLQi7viXynrIsLwJVowKxz2yJWCk=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=sgCMR2k5zIDzAc3qeRdYvTqA9GADoIV3HiR7SYx5LAbL9phCC/y0Iw0Cnk7DJVzFG
	 Rvoshr5T+DsrNj73lVNfXo1lvIGbu+0dmJD+uDQBF6sWW8Qe0xstXj0YWGW75kdeI9
	 4T4B+rTcFt+5CboR2B6xPE3zXhxikaEVxi7oRSUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbeLNWEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731028AbeLNWEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:04:23 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7532080F;
        Fri, 14 Dec 2018 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544825063;
        bh=DiHJc3MJPqvNmdCgLQi7viXynrIsLwJVowKxz2yJWCk=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=yUvnBNBSSut5KINlZR9/oT8WVjSh62lH7YNiiLAQDPi2Hdz44zgF92A9zC6xJpYrM
         Drp3uJrDIo6Xt7USQQYCD9D/pCwut+LAbD/3dem62lj7lIDkv0PwwuOvsRFHA49ZWl
         p7A76RXZ4OyroVc8J/vqWu40DBXIF+EmCJJAKpwo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx7ulp: add HSRUN mode related clocks
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154482506164.19322.7034185431322331364@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Fri, 14 Dec 2018 14:04:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-12-07 02:03:29)
> There are HSRUN mode clock mux and divider in SCG1 module,
> and SMC1 can control i.MX7ULP CPU to run in RUN mode or
> HSRUN mode, the mode switch bits are actually a clock mux,
> add these clocks for clock driver and dtb to use.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

