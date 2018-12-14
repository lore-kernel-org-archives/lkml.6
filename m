Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B097B2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544824683;
	bh=1yovWMreuXoUM+2b/iAO/D3FxA/cPQppWWV2o3g4cbs=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=cyCIbC5PuUjPTz/iByz2grzLDMCJmNPqBQJIxqgYOQhNyv72t4a7/VHRxRv3RPjI6
	 XLj1oyu3hI1ZDrJgcMPxOafNV14/1EwDqTYrZ9pyAUR/fLzYysPDbBq//oRGsOXScb
	 /ifRhTmdqeqqZ/L0iNzjuvNcWxvTpv46UMDL61ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbeLNV6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbeLNV6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:58:00 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21183208C1;
        Fri, 14 Dec 2018 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544824680;
        bh=1yovWMreuXoUM+2b/iAO/D3FxA/cPQppWWV2o3g4cbs=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=XKORvEI5AlOTfIBKXUfAZGXBHqLuWcH0T1pp4UQGBTfNkSKgoqsWhLIvSIUGpO8Bc
         mRCYqs5iFHW62LigjHuz79e2AdVS7y2G2UjvhE+sWN5XX+xAweZnhOK9jAUVlLt8Hf
         UZuksrExUu3qAkRZaqrOzuPLXlMyWth4l5YUmXQ8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181210073240.32278-7-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3 05/12] dt-bindings: ARM: Mediatek: Document bindings for MT8183
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com> <20181210073240.32278-7-weiyi.lu@mediatek.com>
Message-ID: <154482467901.19322.4603837071733892594@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Fri, 14 Dec 2018 13:57:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-12-09 23:32:33)
> This patch adds the binding documentation for apmixedsys, audiosys,
> camsys, imgsys, infracfg, mcucfg, mfgcfg, mmsys, topckgen, vdecsys,
> vencsys and ipu for Mediatek MT8183.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

