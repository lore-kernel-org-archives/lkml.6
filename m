Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8375520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551115498;
	bh=/K0YkV3xR5Sh+0EG2K107P0RuiEYkAcjAq5dicnOCdQ=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=htX40sZx+j9Ki99s+YxpurKIYyAAq/C0A/Q0PxVfyfjl3IrQeLr5fjQtWG6M6lDKu
	 n1lwKAd3jwKCjexoZOUxPgKusaDCRnkBUVzgdCWb3k2q/7W2PwASiyP8iazq1M5d+s
	 BwSwHHanrsZiHtY7f63u+AfziFqkfksElkmSZXvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfBYRY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfBYRY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:24:56 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3734120684;
        Mon, 25 Feb 2019 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551115496;
        bh=/K0YkV3xR5Sh+0EG2K107P0RuiEYkAcjAq5dicnOCdQ=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=WaxENTW3ApL7DI/2xqvtt9jV+BcCb6liwG90S8J1BtQvqlU4Z13J9DWnrtgND8rnd
         OXZu/XTQo0ND2hKT5sm1GJQt+m+baOa/M8clmUn7OTSAbLRym6YvRTgG0172+9TNGv
         HWiPIC5pp+STQ/W9RmxwDyg6gX5Ni2UzqS2tgZjM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: at91: programmable: remove unneeded register read
Message-ID: <155111549548.77512.14021176056634133347@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190223000858.28094-1-alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190223000858.28094-1-alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Date:   Mon, 25 Feb 2019 09:24:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-02-22 16:08:58)
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> This register read is a leftover of a previous read/modify/write. We now =
use
> regmap_update_bits(), so we don't need it anymore.
>=20
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

