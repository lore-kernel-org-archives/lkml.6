Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CCEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C072A22BE9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNi2cP+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C072A22BE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbeGFU6t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933982AbeGFU6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:58:47 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA64C22BE8;
        Fri,  6 Jul 2018 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530910727;
        bh=DHQjELkK5QDSIW+sLQjpv7wZaLwnEbJJgh13WzCHzSU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lNi2cP+iEy0kaMmnG6PgeHhzKtTfHU9bIa7KKbIjPz7ctuRHa/Ha67+BO6c25yk6u
         ULABc93zHOJydVj5qfIkaQLWqGl1xrhVPb5BWEaV45Emhxr/CZG6BfCczq32le6Rkw
         sPpdbvRskgCw7OSW8B2t3Z53pjDPgR6zJGenjE6A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anson Huang <Anson.Huang@nxp.com>, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com, kernel@pengutronix.de, mark.rutland@arm.com,
        mturquette@baylibre.com, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153091072630.143105.2849049240391576710@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
Date:   Fri, 06 Jul 2018 13:58:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-06-21 23:32:33)
> According to Reference Manual Rev.0, 06/2017,
> there are GPIO LPCGs defined in CCM CCGRs,
> add them into clock tree.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

