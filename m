Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0AECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D298421470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw2No9+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298421470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJRCNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbeJRCNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:13:34 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB442145D;
        Wed, 17 Oct 2018 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539800202;
        bh=MJUVhLXS0nJ+lrjVH2czH8ETt4bV3aZv09GHZMpmTp8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bw2No9+LbPxuPJER3HIcriKH1I2PNZtKabw09N8y3sTRs7Pc5aQ3A1Lx630wZeNNB
         9hZ5E1KdbXjgjj8nlw+tYO5qZChBONaBAqlNGjO9Domqs98+M+hVweowl1NVM/PkqU
         T5hyqUEWpm3fzHU0UMKva9at3dJtYMOAS17mJcmQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anson Huang <Anson.Huang@nxp.com>, aisheng.dong@nxp.com,
        clement.peron@devialet.com, colin.didier@devialet.com,
        devicetree@vger.kernel.org, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        mturquette@baylibre.com, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1535701998-20443-3-git-send-email-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
 <1535701998-20443-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153980020125.5275.8353288870810048258@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/7] clk: imx6ul: add mmdc1 ipg clock
Date:   Wed, 17 Oct 2018 11:16:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-08-31 00:53:13)
> i.MX6UL has MMDC1 ipg clock in CCM CCGR, add it into
> clock tree for clock management.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

