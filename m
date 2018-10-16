Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B0521476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdHWtpHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B0521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJQGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeJQGMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:12:39 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB06521480;
        Tue, 16 Oct 2018 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539728410;
        bh=5atw84uB7TLQtTxCHuUPaWBI6KqAFzckjsQN4WMs7xE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tdHWtpHXkjlsAW1Zuy+5Qhx08wa8SeXIsc/5Z7/aedXISjeSSVhzjZ0zHvyfpKK6g
         mLGzqWoshGIghNVRb2tsDkwiDqKGOyf0IN+6ho4KwW+wsvhr8av/EKNANQaOF/5unb
         WkGzr5mfmohw9XmKcuQCCS2hMgMpZdesIsdB3ee8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180823131744.744-3-paul@crapouillou.net>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
References: <20180823131744.744-1-paul@crapouillou.net>
 <20180823131744.744-3-paul@crapouillou.net>
Message-ID: <153972841018.5275.11868347286993038896@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add jz4725b-cgu.h header
Date:   Tue, 16 Oct 2018 15:20:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2018-08-23 06:17:43)
> This will be used from the devicetree bindings to specify the clocks
> that should be obtained from the jz4725b-cgu driver.
> =

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

