Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DCFC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4038D217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549402193;
	bh=bbKcB1JsG/ITujaZdHQEdr6LNN7KR3W9+mdQly0/BDs=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=JyDC4u/Ogzp0/Ue/O6wcHn184LI5fpO0FYrGlaKNIvJWXM8uch5HMdyprKbM2K+0a
	 aEd3kSNVso1NWHjSMmQjv0ExIlxp2iv72pkg2tH/lSOjgrA0VHt3ApWWKhb495umll
	 3YwIxlbquU1uSKRCl5xwlVC8ul7iAZfFNGe1UBRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfBEV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBEV3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:29:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28C5217F9;
        Tue,  5 Feb 2019 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549402189;
        bh=bbKcB1JsG/ITujaZdHQEdr6LNN7KR3W9+mdQly0/BDs=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=Y/cmGSFme0zeMMIuxVkxe33OuPGQq7d5T6OSxFXVZ4j64w5nQ2qzitEwGVJF8rLpR
         +sDQ1beqjecE28lgSoSxKaU5xuCBWNaIFvxFt6/qwcNg08i7RYL0adLyvJ6ToYrjhN
         K/HZgNKjag5gljKgY2D/Iy3vJ6boFroW+gYXdFo4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [resend PATCH v1 2/2] clk: mediatek: update clock driver of MT2712
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940218901.169292.2323058934299497356@swboyd.mtv.corp.google.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com> <20181214020417.2871-4-weiyi.lu@mediatek.com>
User-Agent: alot/0.8
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
In-Reply-To: <20181214020417.2871-4-weiyi.lu@mediatek.com>
Date:   Tue, 05 Feb 2019 13:29:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-12-13 18:04:17)
> According to 3rd ECO design change,
> 1. Add new fixed factor clock of audio.
> 2. Add the parent clocks for audio clock mux.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next

