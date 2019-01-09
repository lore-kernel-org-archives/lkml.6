Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6822BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BE2214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062961;
	bh=ikcDu2SaSUZMPMQZ71Sxt/H4KpcKcg3ccQFlMhVZMv0=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=lQjaLDfPcAJjUEtW8L8HqH+Mi4wxkS/rtiMNrIqaM/pfvyzFFX5nJ1TWSR4ZYHFtg
	 2zr3d0u+RugHBsYp5Rsjf/9+bxzBj6vXlNddFzwhZltaa8cjs3uAdaDbkigCqdHqH5
	 r4h+AncZJHyf9+J/mUSDtTAXNT3oNuy3ADoWD//0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfAITmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfAITmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:42:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7014020859;
        Wed,  9 Jan 2019 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547062959;
        bh=ikcDu2SaSUZMPMQZ71Sxt/H4KpcKcg3ccQFlMhVZMv0=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=EvX2UYn379u2C8Y33nLZqTzVF0Wgj8bFzgIvaLTnifQ5HyYFTo/bkxmsCYQ2jXAVd
         ddTCYd4TiaoavYDylZG795NC+SPIkdKlqqTTaYiF8cjbnzmiyIKLYxx6qSbama+/sK
         yZjlHjsOBGdH7v6HPz1XTehlZF28Bt20re8I2LZQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] dt-bindings: clk: Add bindings for Fixed MMIO clock
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kotas <jank@cadence.com>
To:     Jan Kotas <jank@cadence.com>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <20181213124929.32736-2-jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181213124929.32736-1-jank@cadence.com> <20181213124929.32736-2-jank@cadence.com>
Message-ID: <154706295874.15366.533170065938308433@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 11:42:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jan Kotas (2018-12-13 04:49:28)
> This patch adds a DT binding documentation for Fixed
> Memory Mapped IO clocks.
>=20
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---

Applied to clk-next

