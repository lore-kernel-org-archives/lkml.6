Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D51C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6566A20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547059479;
	bh=hk4rAvhHNlewP9qKO0WdhaNVghN3Bcke1CCc+nNrVio=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=TABa+pakre3m+dyqZQGe3SjWkOD2gBufG+LBBS2a77jFwtV8qThVwuIzmWiO6VnY9
	 QD1Eo0RpyhfQhpTWpJh3ffJAuFOTKS13x5xB9fxfE/LNFF5iOMsFq0cUjPcdSkc1j1
	 2DBWBF9a+6jyPyO/qO8rR62GySfvPN5J3BK0SFD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfAISoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfAISoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:44:38 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927C120661;
        Wed,  9 Jan 2019 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547059477;
        bh=hk4rAvhHNlewP9qKO0WdhaNVghN3Bcke1CCc+nNrVio=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=Ms7a96gjMSim89DGyQTIC1EKWagqMQsRo1dhZIfMO0LwBxnHUo9UD/3xRcBV5wCFj
         fGRRycg/19B5jnfdvAoiMZcwgKYqcZRtnaAtdufbQ8ETF/JkmCbg0VrohnErppcrND
         tvxD+axiFUPnFOiG8XniHED6a8GkfnIC1Qb/F8DY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: imx: Remove Kconfig duplicate include
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
In-Reply-To: <1546534688-17842-1-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1546534688-17842-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <154705947688.15366.2049527826426414260@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 10:44:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-01-03 08:58:20)
> Commit d360b130e210f2 ("clk: imx: Make the i.MX8MQ CCM clock driver CLK_I=
MX8MQ dependant")
> introduced this dupplicate (and wrongfuly ordered).
>=20
> Fixes: d360b130e210f2 ("clk: imx: Make the i.MX8MQ CCM clock driver CLK_I=
MX8MQ dependant")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-fixes

