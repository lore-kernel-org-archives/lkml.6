Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D8DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E855120840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547665849;
	bh=Ly8oTXf+wW25XTLQh/4VVi0iiDCrw9QU0sqGmXLQHck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dy+Bep1jhJ925sc6sPk16XOPalSnwFB9XPgnhNC2bvcWnbPVmbNgoRwD/ciujXXnu
	 ngKiSjH/Q/kANpIm8lM/RwaPQknh4jIWquwYcAbod0ANd5wd3i0QADgm3j1XQvHYiG
	 SBKCMuuq/sR6wkxxRvKZSV8qxAmHfkmKjMdrtMMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfAPTKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbfAPTKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:10:46 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E95B20840;
        Wed, 16 Jan 2019 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547665845;
        bh=Ly8oTXf+wW25XTLQh/4VVi0iiDCrw9QU0sqGmXLQHck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TD9aAYc6ndoChArx2GQZ1BfbOk7c9nRrThJ4AM3D27XL/MQyHI9D/5mOmQqT15ql+
         cIuVG1M9GbsRrrwHssI/bpIVkYnUrdIVN95Z6hdtkcCysl5mD+tqLPSVtLtX0agYfX
         4qdCNlLcHww/8NveIyhmp+9rVeGqyQmSJzcTNYRw=
Received: by mail-qk1-f181.google.com with SMTP id 68so4454707qke.9;
        Wed, 16 Jan 2019 11:10:45 -0800 (PST)
X-Gm-Message-State: AJcUukcB5Y+Kkh4fvMSkJaEr3x4CGBCxVAhVIt/OjfEL7pCkvpxhB3Xm
        l32f4g+1+ErP0Qriwk8YTuDnokotNrAljlyNBQ==
X-Google-Smtp-Source: ALg8bN4tamKw2hTyuVvxfODr8h3Fkesx6ZuaHOjSxfO2ri6dQ2EN6wh7YDA+jwFGDI4SWaopa4/Plj2nkrHn0C01W30=
X-Received: by 2002:a37:5686:: with SMTP id k128mr7465693qkb.29.1547665844734;
 Wed, 16 Jan 2019 11:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20190116103632.17754-1-jbrunet@baylibre.com>
In-Reply-To: <20190116103632.17754-1-jbrunet@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Jan 2019 13:10:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJx5_K=HtfE6pjirffFJ8kU8aEq+Etjxip2gFUpFSpCBw@mail.gmail.com>
Message-ID: <CAL_JsqJx5_K=HtfE6pjirffFJ8kU8aEq+Etjxip2gFUpFSpCBw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: reset: meson-axg: fix SPDX license id
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carlo Caione <carlo@caione.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 4:36 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> As reported, the SPDX license id is not placed correctly and the variant
> of the BSD License used should be specified.
>
> Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
>  Sorry for the delay Thomas.
>
>  Regards
>  Jerome
>
>  include/dt-bindings/reset/amlogic,meson-axg-reset.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Rob
