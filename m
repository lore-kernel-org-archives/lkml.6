Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA6320846
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWmadzao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA6320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeGZA4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731410AbeGZA4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:56:10 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3561F20685;
        Wed, 25 Jul 2018 23:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532562130;
        bh=AX3XdZjfzgdnMM6YKOVO86t6cuWx33W550frE1gU7fw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=IWmadzaor3X1kzYXMUq9XFXJz3IyU99nz9BaZK0eXB7jgOJktU1fKLFcUfsXc+z1I
         AYuPIsVXmPSmQ526cxkUZxf++8IdtXViuxborhCSLn6n9XCOxwhRfIbuRALyszb93s
         tu9kQm0S8lIpRxTFIgUDXmigiWWINJfCtMDnEKGQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Saravanan Sekar <sravanhome@gmail.com>, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180719090649.12460-2-sravanhome@gmail.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, linux-clk@vger.kernel.org, jeff.chen@actions-semi.com,
        mp-cs@actions-semi.com
References: <20180719090649.12460-1-sravanhome@gmail.com>
 <20180719090649.12460-2-sravanhome@gmail.com>
Message-ID: <153256212945.48062.14143557798405781571@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 1/5] clk: actions: Add missing REGMAP_MMIO dependency
Date:   Wed, 25 Jul 2018 16:42:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravanan Sekar (2018-07-19 02:06:45)
> Add REGMAP_MMIO as dependency to avoid undefined
> reference to regmap symbols.
> =

> Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next

