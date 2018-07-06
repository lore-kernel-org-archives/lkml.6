Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E01CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3798622BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO0SC5kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3798622BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934509AbeGFUwJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933833AbeGFUwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:52:07 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE0722BD2;
        Fri,  6 Jul 2018 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530910327;
        bh=e/Pv1cmbMgjou79arzwmxunL0HyRUxemCZRSCstqlgE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=mO0SC5kczPMvBojaTL1LYD/QxRNa492WQW0wA8Wv9ubgiHrIy1nux2XZV0IyECMTy
         giBPZ3di2ckizlWD/gWAh32Lj4DsaWBiUV0vnLw5q4pAMma6rqIKb8Pd+tPC/vxqjf
         3kdte5FDWxdLZHMDNGUTroCeN6rTGoftGBOjIz9U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87d0w2gsa5.fsf@belgarion.home>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
 <87d0w2gsa5.fsf@belgarion.home>
Message-ID: <153091032623.143105.13689700534218065371@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/2] clk: pxa: export 32kHz PLL
Date:   Fri, 06 Jul 2018 13:52:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Jarzmik (2018-07-04 22:34:10)
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> =

> > This clock is especially used by the RTC driver, so export it so that
> > devicetree users can use it.
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > ---
> > Since v2: fix missing parenthesis in clk-pxa25x.c and clk-pxa3xx.c
> =

> Hi Michael and Stephen,
> =

> Could you have a look please ?
> =


I'll apply patch 1, and leave patch 2 to someone else?

