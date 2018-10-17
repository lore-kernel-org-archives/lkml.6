Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202E2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FE421502
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgFzejdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FE421502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJQN4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJQN4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:56:30 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B76214FE;
        Wed, 17 Oct 2018 06:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539756150;
        bh=PY7KeGuQxo3qM85ZSgcjrv0Fl+qtNqXVbcVI3a3pCC4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=GgFzejdUMfHzlZAUrzLAljfcMEAN8s4xqQRkShO5I4NpM/TeXLWN5wxLa9W/5mdbq
         JvATC/E+bC16Dxd64vO/Fkj1xMhzYRlHhCXSYlvgIIPJpGRbK3ojZkZrAaC6hXZJjp
         zaHWe8PkAFKu8njFMnDeatp41d3Dvlf1OQ6O0pDk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180810095113.25292-3-manivannan.sadhasivam@linaro.org>
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
 <20180810095113.25292-3-manivannan.sadhasivam@linaro.org>
Message-ID: <153975614966.5275.6221802680742436793@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/9] dt-bindings: clock: Add reset controller bindings for
 Actions Semi Owl SoCs
Date:   Tue, 16 Oct 2018 23:02:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-08-10 02:51:06)
> Add Reset Controller bindings to clock bindings for Actions Semi Owl
> SoCs, S700 and S900.
> =

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

