Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AC42083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY+OexdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AC42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeHaFYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeHaFYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:24:03 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F1E620839;
        Fri, 31 Aug 2018 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535678347;
        bh=lfflvIoZcZo3WcyqoVebqobijD4pOgJsdAIFECcY9V8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iY+OexdSqL6Knjhj3ySAPzP3CUYizTfxLH4vEfjl/sqEaG6QMyR5V4eXol0ToQzj4
         uGpMtvi790/OiqzcxUFy7mf3XI8ozJ3cgjAbvgcJ8PuGGlpZ7IZBdVQMNNoxNKQ9Ft
         3mJib86VO3O0j1QTCj8f6CxAM6jj7a5+6tV9z11o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180821220233.9202-2-wsa+renesas@sang-engineering.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-2-wsa+renesas@sang-engineering.com>
Message-ID: <153567834691.93865.8395414825026656324@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 01/11] clk: renesas: use SPDX identifier for Renesas drivers
Date:   Thu, 30 Aug 2018 18:19:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2018-08-21 15:02:14)
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied to clk-next

