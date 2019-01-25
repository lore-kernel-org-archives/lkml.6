Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AE1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36699218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548442512;
	bh=roa/ept3xiEyAO/l3+6fTii3RIuB8gb3C+3ochEtgxo=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=1p47p13uakkzn4Y6M9UqaMqWKbySmpZJuVd+87J42un9GaVIbl1vIOzFHNVevhqT2
	 ePYvbSI21CXrVpUT5RXGv5TcPcggZkEqcbesSVXpaik/pDd7K6TTKgLl5Jbkci2Hgv
	 RcVRGlZw6yr9fegBu/eBTyAlBXzw9nS+AhwZ2x7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfAYSzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfAYSzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:55:09 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7EB217D4;
        Fri, 25 Jan 2019 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548442508;
        bh=roa/ept3xiEyAO/l3+6fTii3RIuB8gb3C+3ochEtgxo=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=XddNRmIcznhEdQiRNa2RLD6EnfLvTf9SZJLxwkOy3l1gtKhJafrFLa52KRUkD2Il3
         ZOBaVkI8OTWVTMfqqnUb43LR9vUEULQ9HGvvyo8FIK+YBD8X5WVBcAtt7LxBG2ddui
         4jVPUIzQhKTXJSbZ+6J+J2VEFV9Jjg9bsEkktNjI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: ingenic: jz4740: Fix gating of UDC clock
References: <20190125153436.13517-1-paul@crapouillou.net>
User-Agent: alot/0.8
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190125153436.13517-1-paul@crapouillou.net>
Message-ID: <154844250661.136743.15303302299846585853@swboyd.mtv.corp.google.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Fri, 25 Jan 2019 10:55:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-01-25 07:34:36)
> The UDC clock is gated when the bit is cleared, not when it is set.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---

Any Fixes tag for this?

