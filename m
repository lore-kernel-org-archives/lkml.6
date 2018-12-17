Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D6D214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545088724;
	bh=p7GueG7YcInPFS9F2IRy2AbY47F0jfd4T5IVA7Cq9Mo=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=lOWgZhSeEjyuNRI+WTewkx4FO0TJBFjqgnJFcAYjE35q3FwYKbCOdXNpK00Oa5mYc
	 ZZ3K4FfFARAyQq/LK9KFfayLVqW/pEjPxQ7LK5awfgP91EpeG5uRXzmZux6F2zN8CO
	 /JAgZHwrAJsqJ7/2qOmNxEf8AkxvYVR6TGuoz0gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeLQXSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbeLQXSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:18:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E0B21783;
        Mon, 17 Dec 2018 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545088719;
        bh=p7GueG7YcInPFS9F2IRy2AbY47F0jfd4T5IVA7Cq9Mo=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=0kLLmlJIynTy4HN/SyWpxwTBD7WAOiI8ZKrkpA2BNtkksLNxBX9Gsi3BH8LGM5ee0
         IMzt39rc0w18Xllh5azMnpVVZ13POsB5/k3H2TfFdsk1uu+NmLgN8TGuc8AIOgmbm+
         9Uu7zvPrPiYnJZNITG/x0JnDOQgzEHh+Oq4jMeoY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181212220922.18759-2-paul@crapouillou.net>
Subject: Re: [PATCH v8 01/26] dt-bindings: ingenic: Add DT bindings for TCU clocks
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-2-paul@crapouillou.net>
Message-ID: <154508871842.19322.11473376752929195621@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Date:   Mon, 17 Dec 2018 15:18:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2018-12-12 14:08:56)
> This header provides clock numbers for the ingenic,tcu
> DT binding.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

