Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6352C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CB72184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785103;
	bh=/0MckasgqQJ/KD2MVKBvKpBYnZf749g0hqFHF7Q6ugE=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=QaMZQIir7slkgvR2Yjf03qIreQpmMLtUn5qRyUej2uDevP1nwTVpFCKJuiQ8cOiQY
	 /bA0thZI/4+g/ff/PDI88Td2kFvu73BiT0yowZD4bAk156JfGFyDWRNSGfBcChd2DE
	 +SCMgXOORXRzcgUI2BGH+eYTg955sKBEsEoWdqhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfA2SFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfA2SFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:05:01 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F6621848;
        Tue, 29 Jan 2019 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548785100;
        bh=/0MckasgqQJ/KD2MVKBvKpBYnZf749g0hqFHF7Q6ugE=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=EtuQZhH5S7Jt5X39Vn6nIl1wQjXoLV/fGCwx7xD0XHJYSMdwkFvI6tQAP2NpV3pK1
         kOK4BiUJlUVCPm0tGNQaBjgx98RLyIj6gCpz4nqObNLewNEoB+w3NWwRThLA/Qud1S
         wplb8AI53+IMvC7vEFcf1P+Ko92BM/X5xXAP+mHE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/14] clk: meson: move MESON_GATE to clk-regmap.h
References: <20190128180430.28689-1-jbrunet@baylibre.com> <20190128180430.28689-5-jbrunet@baylibre.com>
User-Agent: alot/0.8
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-5-jbrunet@baylibre.com>
Message-ID: <154878509992.136743.15892625146758066106@swboyd.mtv.corp.google.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Tue, 29 Jan 2019 10:04:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-28 10:04:20)
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

And also make clk-regmap.c a module? Having any commit text would be
good.

