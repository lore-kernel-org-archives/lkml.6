Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453BB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550822596;
	bh=zsdoPUNU2yfLU76WhB7EY4WAcfCXllD/puGhaAGwnB4=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=jhAnP4iPgjMgLjwHhV39bZCErygKc41/rV9E4c+s6081hX3NZO17NWYjIAH18qlls
	 Had7t8vFrDFVtqIo8Yd8bj3/TcKZpJMc0zmRq5DTguE+2MBE99gtC/JLoV5Hc50yj7
	 mbMM5evfqscbnSMTnXuJ8myISroSPJYjR6Mx01E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBVIDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVIDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:03:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B7220818;
        Fri, 22 Feb 2019 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550822593;
        bh=zsdoPUNU2yfLU76WhB7EY4WAcfCXllD/puGhaAGwnB4=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=XZeSjqgVhziM2d1TFm2VVqxi0DiUxbgHO7mYSF9rX3k6HY9mzJ7qD66c+XEg6A5aZ
         4FRAt1HNRPDuzsm/tTS6sd6pP/1AvU1Nyz9T5uwn9JYRgdPY/v7JbOf8m8S93mcpj7
         dDeE8yhD5oEypxGhCK5MnPrpeeN2yf2OFZ4vgGTw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/6] clk: actions: Add clock driver for S500 SoC
Message-ID: <155082259229.77512.12339399521506773511@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org> <20190115033340.25016-6-manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190115033340.25016-6-manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Fri, 22 Feb 2019 00:03:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-01-14 19:33:39)
> Add common clock driver for Actions Semi S500 SoC.
>=20
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> [Mani: cleaned up the driver]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next

