Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BDDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F293420882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1SOD3qVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F293420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbeGYR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbeGYR6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:58:55 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DC220843;
        Wed, 25 Jul 2018 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532537186;
        bh=P1MfcSPQA5lUg9TuR9htbviQtFOOPM5fe2N1MFuLGAM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1SOD3qVcbXF2K3J8Nv6O7fMJK73qYrluObxZV47ZqGkRlPkyMJ2svF5V43w0/Ddn4
         4jixU4olmXzEIpdJerKtxvgrC7un0ZEssORfPJbdSPDDxGMJjcfv4BKfl1p8az3TR/
         3MGaLI4lfPtjyqXIQCMtH0uHqg2sLyV+nRpHrgPc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        fabio.estevam@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153253718536.48062.17677554340926815034@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 1/2] clk: imx: add ocram_s clock for i.mx6sx
Date:   Wed, 25 Jul 2018 09:46:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-07-10 17:58:58)
> i.MX6SX has a 16KB always-on ocram bank called
> ocram_s, and its clock gate in CCM CCGR1 CG14
> needs to be enabled before access, add it to
> clock tree.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

