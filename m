Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2E92173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203642;
	bh=L6sNzpRdCs77FMR+H0CNf38dl/Ds4JhU+XhECeoRiHM=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=JDeIM0IxImgwlOeQrC9mzUrmLjAPIvuMEIsh2HN/K+It/rRiOG7WZKH3dklmGnscA
	 K9EJ0Zc+rqI7g0AVh+Y9eaOquizfTZMd2EK85G/VKkBwcXmuoEpYEwgtjMD8gVPvFV
	 IPAbofwlnEYUshjHU6noy15ORvB68M9jN6JvNE+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfBZRyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:54:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfBZRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:54:00 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0B32173C;
        Tue, 26 Feb 2019 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203640;
        bh=L6sNzpRdCs77FMR+H0CNf38dl/Ds4JhU+XhECeoRiHM=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=nmaWbTEnHU72tvS/4TnuU5sS0trLOEON3gJJBzJW0Ivu6WW8u+GmqXk8wNNDcMeyw
         Pm4rng5sejODg0JjDiFHYr1NDmLxUKUNr/RUnUVOdMD/8MtS2ddCy8PZRbMrvrBmDp
         lZxE/FjRqk7q1p79qhvHi+xdEmGB3Q/u28Xf4K0U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com,
        matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163218.26148-1-matthias.bgg@kernel.org>
Message-ID: <155120363907.260864.15274639985767740118@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 1/3] clk: mediatek: Add MUX_FLAGS macro
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214163218.26148-1-matthias.bgg@kernel.org>
Date:   Tue, 26 Feb 2019 09:53:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2019-02-14 08:32:18)
> From: Jasper Mattsson <jasu@njomotys.info>
>=20
> This is required to mark outputs of certain MUXes as CLK_IS_CRITICAL.
>=20
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Acked-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next

