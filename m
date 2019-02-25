Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D612B2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551115179;
	bh=jbmj3bWtaW9u6ZgJFBBvUGOcRk+8y4YpKLBKvdOcSRU=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=Oy+Non7hD/lR0a1V6hNt3tzajcMCeXhmVc/SjZvMb58EM1m2FGPy6nxDGrCJ6M3V7
	 OttSzokgjfS1ECz9r6SZj2X1w1PLA/if/vCJ/jUrhWf3fxRcSKBUi8WVrz0FIQw15Y
	 atroorOZ4aLAR9WoMn2MnELnAgKeLx2IS+K8S/DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfBYRTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbfBYRTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:19:36 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364D120684;
        Mon, 25 Feb 2019 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551115176;
        bh=jbmj3bWtaW9u6ZgJFBBvUGOcRk+8y4YpKLBKvdOcSRU=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=pNkQOYsf9MwW6b8ZuOYEbwO2Jx0hEZ1tt8+Scj/zvNntTH41HnYuyhx3hkOHJD1GQ
         QBoOrPfApwC140dspFqJfU9MoV2qMGOyfzSzBk/qQNXWa11y/Lr3IYiaQyjEdvyRSq
         pKxAP2aAxFJuhY2UjOIKQdX/wBMuwbv5mlRIsFs4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V6 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Message-ID: <155111517541.77512.6911978302664697917@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190225020912.29120-1-wangyan.wang@mediatek.com> <20190225020912.29120-6-wangyan.wang@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190225020912.29120-6-wangyan.wang@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        wangyan wang <wangyan.wang@mediatek.com>
Cc:     wangyan wang <wangyan.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, srv_heupstream@mediatek.com
Date:   Mon, 25 Feb 2019 09:19:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting wangyan wang (2019-02-24 18:09:09)
> From: chunhui dai <chunhui.dai@mediatek.com>
>=20
> Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.
> Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".
>=20
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---

Applied to clk-next

