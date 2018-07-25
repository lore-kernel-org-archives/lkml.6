Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBEC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F45E20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyhwtKJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F45E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeGZA4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731410AbeGZA4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:56:13 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041D920846;
        Wed, 25 Jul 2018 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532562133;
        bh=prttucTK3HCQQNyIqOX0z3W0nP4zzSGm0+AyRErm1tQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pyhwtKJtHzeBnxsmIFVKAq6JX+jUJxNc0PBOBvBVstWLYON5EElDZLIzphYzlJQr5
         o5HMIYjsPRFJ6ZdkS4KlUFprufbjT2ElzF8XtH6inFwSZq/4SXIXGTmtBPbKwj0qDP
         YeH1+nOcpVp1otjv7Al4v3W92M6+0L8A3K/2oK+A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Saravanan Sekar <sravanhome@gmail.com>, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180719090649.12460-3-sravanhome@gmail.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, linux-clk@vger.kernel.org, jeff.chen@actions-semi.com,
        mp-cs@actions-semi.com
References: <20180719090649.12460-1-sravanhome@gmail.com>
 <20180719090649.12460-3-sravanhome@gmail.com>
Message-ID: <153256213239.48062.2379132769313194226@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/5] dt-bindings: clock: Add S700 support for Actions Semi
 Soc's
Date:   Wed, 25 Jul 2018 16:42:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravanan Sekar (2018-07-19 02:06:46)
> Add clock bindings constants for action S700
> Maintain common clock dt-bindings for Actions Semi SoC's
> S700 and S900.
> =

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

