Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3BCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5622146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xDNL//A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5622146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeLCSR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbeLCSR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:17:26 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46EE2145D;
        Mon,  3 Dec 2018 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543861042;
        bh=Gz0q+3HLJGmzZXUZsmSrTR5rxjQKIBk1iD5tMCpMBXE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=xDNL//A4uKCN0iJEXNQ5BjFYamH+N1L/AA9VTF2xk0UFumlQH/8p2y+lDn57JUEGy
         2bq8I2PCTgkkOeWQcKqnylg0pjDWFmtE9+AFKIvxsalyhv5YS5/uH093fth//XGxEP
         oUVEk+bN14UtuKCsC8dFzZwQ+94wwXldzSdpQB+g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543661502-18573-4-git-send-email-abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
 <1543661502-18573-4-git-send-email-abel.vesa@nxp.com>
Message-ID: <154386104135.88331.11110647498955664003@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v15 3/5] clk: imx: Add SCCG PLL type
Date:   Mon, 03 Dec 2018 10:17:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-12-01 02:52:13)
> From: Lucas Stach <l.stach@pengutronix.de>
> =

> The SCCG is a new PLL type introduced on i.MX8.
> =

> The description of this SCCG clock can be found here:
> =

> https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D834
> =

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied to clk-next

