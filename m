Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38635C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E350F2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcji4lTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E350F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeHaFe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeHaFe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:34:56 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FDDA20837;
        Fri, 31 Aug 2018 01:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535678999;
        bh=0Axb8PfO7LHL2XU4HdA71DfHzEUsXh/GHBcsm3kpbFM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jcji4lTn1KXzrsYQHdDRo/iR0HkGImGc231qbwtRaW27K9IezKYxMQ7FNIPmOFf5l
         XCv3VbGOOL1pCl4ZGzqCG+kvEd/resDv7kAfrt1tAsaKMv3uC8z8gk7x2v30+YQg2g
         s2Gqmm4CX27cUpvRjMotktQc/V9oTlw18MSmI6bo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Colin King <colin.king@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180806134402.1055-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180806134402.1055-1-colin.king@canonical.com>
Message-ID: <153567899849.93865.4205043107104480951@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mediatek: remove unused array audio_parents
Date:   Thu, 30 Aug 2018 18:29:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2018-08-06 06:44:02)
> From: Colin Ian King <colin.king@canonical.com>
> =

> Array audio_parents is declared but never used, hence it is redundant
> and can be removed.
> =

> Cleans up clang warning:
> warning: 'audio_parents' defined but not used [-Wunused-const-variable=3D]
> =

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next

