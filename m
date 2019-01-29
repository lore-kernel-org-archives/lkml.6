Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2368C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF6F21874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785187;
	bh=2yqifEVp8p/wtqQsMimWWQxMoGswE/SnJ85PKW8+Qg8=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=e0TJdSWANsi0GwHMr+0XI4v/dhlgZjQ6PPx+cEOuMGi9VbY0pb54FdS1BIm4pXKl7
	 62Mb7oErinSfAh40Qcen3++QDRPLpWyURvGHQ2lHZU7PnOi1y5uoFfW1A1/F/G9v1T
	 JCQBxyEf2wma/UOnyzSLSlmWxkiZuj1KcgBNM+Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfA2SG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbfA2SGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:06:25 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0C321848;
        Tue, 29 Jan 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548785184;
        bh=2yqifEVp8p/wtqQsMimWWQxMoGswE/SnJ85PKW8+Qg8=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=Wv+77EZBWgnRs+dCp+kFzQltA76x7F57C0Fe3eAAeCT+Ewiua1B82FToFR5gYzVzC
         8tOc6dHSDj/eC6uvAmeh4+49k+i6iePBUEhPhkcjsIEgUkL+maXYWbITtV4nZwx//G
         +rHa1BDwzsf7Jj37/non2zRAV130q0QD+HHDxC6w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/14] clk: meson: move parm out of clkc
References: <20190128180430.28689-1-jbrunet@baylibre.com> <20190128180430.28689-6-jbrunet@baylibre.com>
User-Agent: alot/0.8
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-6-jbrunet@baylibre.com>
Message-ID: <154878518398.136743.15771636170808285043@swboyd.mtv.corp.google.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Tue, 29 Jan 2019 10:06:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-28 10:04:21)
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Why?

