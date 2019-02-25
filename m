Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EEF213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551115188;
	bh=0Z2Kt6pc2YzN2cXPwg40k4HA+RyQIKvmOcHJecxo5ME=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=hfsgfrzTofB6koopx8iH1moO1Lvy+bL7pBZvkjpJGhZs2HTkFVu3LVr1rtZ3Sj0vm
	 AFkZxrW2m0MKYQrEBY5aTpXEv9mdmjRK/+aaF99J6L4w3IsZCnUpHSrfjIBBcpdVmq
	 SddkVQhtNPcg3YcAOqzP6EnUEDmjbI7Bg5U8oa8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfBYRTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:19:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbfBYRTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:19:46 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B0520C01;
        Mon, 25 Feb 2019 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551115185;
        bh=0Z2Kt6pc2YzN2cXPwg40k4HA+RyQIKvmOcHJecxo5ME=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=fJjGa24WdOQ3bGsf0hpMcEHFLQCBSs5VBNVuj4/XeSHP8S92Nwrs40EFUh21RF2VZ
         R3Pt6dJPm9JSt1lnQDyrwxR8eP7cTomGd6bpVCu70aD2KzFl2XKCCh7IxyHbaDI+Vp
         99cRWEE63Gcr4o315HzRjRay7hR/HMwN4xvHrxxY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V6 6/8] clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the clock of dpi1_sel
Message-ID: <155111518481.77512.14619508720748400478@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190225020912.29120-1-wangyan.wang@mediatek.com> <20190225020912.29120-7-wangyan.wang@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190225020912.29120-7-wangyan.wang@mediatek.com>
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
Date:   Mon, 25 Feb 2019 09:19:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting wangyan wang (2019-02-24 18:09:10)
> From: chunhui dai <chunhui.dai@mediatek.com>
>=20
> The MUX clock of dpi1_sel should select the closet clock for itself.
> We could add this flag to enable this function of MUX in CCF.
>=20
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---

Applied to clk-next

