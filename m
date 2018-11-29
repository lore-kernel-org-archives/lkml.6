Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F24EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F85A20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujgDzGAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F85A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeK2LvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeK2LvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:51:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646962081C;
        Thu, 29 Nov 2018 00:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543452454;
        bh=lAgU7MYjvOByAzOhN+W2fwbbF8Ar0s4uVP3R243QB/c=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ujgDzGAdPaQsC/ZuPUhWB79O7IpnxRWbCWZQIHFMjL9gliwah0SNpx4293p6g8Fuz
         Ubr/KzGL7A95aoRgCX1/HcwEOLIMLedBw4h61P1BBzuQGjH6QNRftXPpMW9XUnzlpL
         ssZceq6y9/Z5uRWW6d+wfesvtb2OgzU2yQmnbi2M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mesih Kilinc <mesihkilinc@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <47d0f466155e3d678d3383655856c1e15e975870.1543443475.git.mesihkilinc@gmail.com>
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <47d0f466155e3d678d3383655856c1e15e975870.1543443475.git.mesihkilinc@gmail.com>
Message-ID: <154345245385.88331.8344308999294645427@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 12/17] dt-bindings: clock: Add Allwinner suniv F1C100s CCU
Date:   Wed, 28 Nov 2018 16:47:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mesih Kilinc (2018-11-28 14:33:22)
> Add compatiple string for Allwinner suniv F1C100s CCU.
> Add clock and reset definitions.
> =

> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

