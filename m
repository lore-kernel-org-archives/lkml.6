Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D209222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550276601;
	bh=RDep05NNM48QYOuQkir2sacr0fY8B+cKvWlXp4ZcV7M=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=rmbzkMypSJJjV8EyCh1uhd4geUnU6veToFi/6nWu8PPmRysMd8AZytWfPOjlQEdJC
	 +uY6Hl4oNWGRtT0fVD8qB86QKMMNO/pvLIsRJLsfY+/CvdIzGyBuopJO7xBwUl6i1b
	 7zhCbtzS4cFV9AS58/1aw6VGwKuN1tyrTtIpS2T8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfBPAXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfBPAXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:23:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0440222DD;
        Sat, 16 Feb 2019 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550276598;
        bh=RDep05NNM48QYOuQkir2sacr0fY8B+cKvWlXp4ZcV7M=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=fxRrEZ0tHGIOmo9pA33oJnrolP37Z0hrbqZoGapJfdUlZUVhc6KbUsYhrVodz+rMd
         8JvV8PntbJqpFTDtcsQgvNwFqKP6ZS5Oe2hY9sf1LSXt+Sp9t5Y0XIxNzJoLn0yh1W
         Q6X9bJ9SDxUD+dZZFiv0jfo1A6jX6StkN7XZNV50=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <1550159642-26878-7-git-send-email-claudiu.beznea@microchip.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 6/8] ARM: at91: pm: add ULP1 support for SAM9X60
Message-ID: <155027659793.115909.12085192701261043595@swboyd.mtv.corp.google.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com> <1550159642-26878-7-git-send-email-claudiu.beznea@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu.Beznea@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 16:23:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2019-02-14 07:54:57)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add ULP1 support for SAM9X60. In pm_suspend.S enable RC oscillator in
> PMC if it is not enabled. At resume the state before suspend is
> restored.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/linux/clk/at91_pmc.h    |  1 +

Acked-by: Stephen Boyd <sboyd@kernel.org>

