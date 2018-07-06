Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F861C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1522BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQUF/xuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF1522BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934344AbeGFUx4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933856AbeGFUxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:53:54 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA0B22AE3;
        Fri,  6 Jul 2018 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530910434;
        bh=yZPRRx969UVXcdyL/q0W/N2PKtCC2pZhge8aLcI2zUA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TQUF/xuwJrEtNgC5XbgfCwOCzjRlzSciESKURCM5elp/CCN/ymiN73UvkOq2O4lOd
         qadGwsoaJIZmxTzwEnkJ/n9DqD63kqPn1nvr4/0Y+iKgBzLRF0rsNIoXAsG1N0UJWI
         yLyviHTkCG2wLF3s3tVSDchJBwZ8//tnfNqduhlI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180627194124.26366-1-robert.jarzmik@free.fr>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
Message-ID: <153091043355.143105.4051882411997045585@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/2] clk: pxa: export 32kHz PLL
Date:   Fri, 06 Jul 2018 13:53:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Jarzmik (2018-06-27 12:41:23)
> This clock is especially used by the RTC driver, so export it so that
> devicetree users can use it.
> =

> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Applied to clk-next

