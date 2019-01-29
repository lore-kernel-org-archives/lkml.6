Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA31C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1DB2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785140;
	bh=aY4qLPsm9WmJCDv1/BCT8Qr0kdxJN9rRtFiw1OCIHcY=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=15uiJSSr3CjDMZr8C5Mwv06GVkGkM5wSljY47RGRYXgqO0Fe8xybD4cBgynF3YIaw
	 knVnACOyXVL8MRz19E+6CFkCb3FLrQa6YSSDiq/pVlrCm0WtW0H8ZrJVkGACAfEPHr
	 9jDBhKY6vc0HQddeFTltcmEOPR2rx3R0Mc/NoXTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfA2SFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfA2SFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:05:37 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB5121848;
        Tue, 29 Jan 2019 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548785137;
        bh=aY4qLPsm9WmJCDv1/BCT8Qr0kdxJN9rRtFiw1OCIHcY=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=Uf/grt9PCNKNgs6MmaPeUdkZCnwB3re2FQX0JfpgEMkcYdiaPeQKZc+eW0KWCuauL
         StkbvWt8SJcW1z4EwKBVs3Nj6xSke6Ks9LXG+Kp/utDZWCQSI+IzT6omhj3QI59g65
         qE+/GJ1xwKnynirraT1soR7C0kw3jOiuePqmIlAg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/14] clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
References: <20190128180430.28689-1-jbrunet@baylibre.com> <20190128180430.28689-3-jbrunet@baylibre.com>
User-Agent: alot/0.8
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-3-jbrunet@baylibre.com>
Message-ID: <154878513659.136743.11122005516300472127@swboyd.mtv.corp.google.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Tue, 29 Jan 2019 10:05:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-28 10:04:18)
> Use CONFIG_ARCH_MESON to let make enter the meson clock directory.
> As part of a rework, CONFIG_COMMON_CLK_AMLOGIC is about to be removed.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

