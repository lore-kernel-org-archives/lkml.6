Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9297AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623222173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551202927;
	bh=zQnJWTmBRo3wGhECj7y0nJ1//9D7LYKUO8YvFiAT0i0=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=HRvvhdHSAMwdVP79aAW1qM9ISGDGOh3tJ/SusjIM/2VRdSIchYMFtyCTJViIrY6c9
	 92LBu4VBtbs2M9FtE2OkB/0NiW1wVV4IV2G9Z7ThGqVF9SR1Cu+nZCbDZQgy5pHCNG
	 3bD6puJ+2hQR76XFnGZX/DjnnhNu15lINN+zRoFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfBZRmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:42:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfBZRmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:42:05 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E63217F9;
        Tue, 26 Feb 2019 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551202925;
        bh=zQnJWTmBRo3wGhECj7y0nJ1//9D7LYKUO8YvFiAT0i0=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=fGoaZNoaWRrXu5m3E0srVycv4Xq9DHoWnemoEkcMu9Jke3YqFcfrLATFVR2ZMJ8Aa
         sYHkY86M6R6HMGYDiAWVM+MWg7JmqmnMnUge+anY/OmdTvOVenbLl+xhimmXcHxChW
         gXB8AZeKxAgHYfwguHNt5k/UNGMYHmQNnsXnACkc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <20190226070221.22382-1-bjorn.andersson@linaro.org>
Message-ID: <155120292445.260864.13257629633080421659@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Define parent of PCIe PIPE clocks
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190226070221.22382-1-bjorn.andersson@linaro.org>
Date:   Tue, 26 Feb 2019 09:42:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-02-25 23:02:21)
> The PCIe PIPE clock in the GCC is fed by the PIPE clock coming from the
> PHY, describe this relationship.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

