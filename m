Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC51C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618CD21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203652;
	bh=/R5Fu2/YoM7REAShIgvE7HVSFRmaqktZDamyA54Uxl4=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=Ebkx5qZa9j4oMDDJ9TLqEJPjU5IokBRRQuxmDrfvuKkU0KykruUEfg/v0amhFr4Ju
	 klFq9eoGnfiJQEsT/pp5uAKMAEwH/kmZzUCSqTdp1k2vgB14hpqMHQmMQdJbo+X8sQ
	 ZFnmcgBcX4ppPgft5w4i9ERgrWWjNOZ5Jeaea1Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfBZRyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfBZRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:54:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50252173C;
        Tue, 26 Feb 2019 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203650;
        bh=/R5Fu2/YoM7REAShIgvE7HVSFRmaqktZDamyA54Uxl4=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=x+539CME9SSyC4R7AGrAgaCW/TfNkW6PKuNH4dypt7xi8T3NrnrIdlkQ3chwZRrck
         fw6HutoY1iVmzWSuPWaO3SDGJZqQ59VzHzqoSXQo/uUjYrNQl7IeU7CUKLAin+lZ7q
         4uzd4+whGuOfil82CAhcJXzCWvVVF0dxYCimgctI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com,
        matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163230.26203-1-matthias.bgg@kernel.org>
Message-ID: <155120364911.260864.2648269996556782294@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 2/3] clk: mediatek: Add flags to mtk_gate
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214163230.26203-1-matthias.bgg@kernel.org>
Date:   Tue, 26 Feb 2019 09:54:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2019-02-14 08:32:30)
> From: Jasper Mattsson <jasu@njomotys.info>
>=20
> This is required to mark gates as CLK_IS_CRITICAL.
>=20
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Acked-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next

