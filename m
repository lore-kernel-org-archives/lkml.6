Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867FCECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55817214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxORb6Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55817214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeJRCNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbeJRCNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:13:50 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E938214C2;
        Wed, 17 Oct 2018 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539800218;
        bh=H9752mg8Xk+dRwrIar+Zj1nz2ER7n2A9bjQ2wt38elc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TxORb6AxAsmKyqkQ5t06DRW8zxRQn4ihoh9XHvhIhMrj6ew0ryFNHJBitzDg6q39K
         K7ifI+9I5CaepUascCbZ+Ye4/qtOhsRNxy40BtU9gSnooAikmiDfiNTpUJ/wyyKLpX
         5st9Ejo+o3nHwWrbbq+4b4em4IcLA26Q+DoF4oUw=
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
In-Reply-To: <1535701998-20443-7-git-send-email-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
 <1535701998-20443-7-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153980021754.5275.12236034739532021121@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 6/7] clk: imx6q: add mmdc0 ipg clock
Date:   Wed, 17 Oct 2018 11:16:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-08-31 00:53:17)
> i.MX6Q has MMDC0 ipg clock in CCM CCGR, add it into
> clock tree for clock management.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

