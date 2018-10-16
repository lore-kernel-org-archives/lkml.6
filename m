Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB65CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9338C21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kao8AIg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9338C21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJQGM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeJQGM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:12:29 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441FD2145D;
        Tue, 16 Oct 2018 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539728400;
        bh=VFAXTmeitzp/hFzewzmWeXkSvf8gfc6g3xm0hj6MLFA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Kao8AIg6XMk4MMhabk4rO0ioHmqu+kaC1WlLMOVUtXsbc6DogcVch8UXhsLL2Yv1t
         9HBNk1gUcDplec1lcVov/FDkMCk1dFMPumeZRZMzsHBBgGhx5fW/qZ3Pod168G3lAa
         Jcdc5b3SFoqtrQ70M7jvYxUSqABHQaB2cToSlLUw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180823131744.744-1-paul@crapouillou.net>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
References: <20180823131744.744-1-paul@crapouillou.net>
Message-ID: <153972839968.5275.2414421944664071492@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/4] clk: ingenic: Add proper Kconfig entries
Date:   Tue, 16 Oct 2018 15:19:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2018-08-23 06:17:41)
> Previously, the CGU code corresponding to the SoC for which we're
> compiling the kernel was the only one enabled, which made it impossible
> to build one kernel that supports them all.
> =

> Now, it is possible to select more than one SoC to support.
> =

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

