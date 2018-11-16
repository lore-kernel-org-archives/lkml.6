Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218D4223CB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLMaOnhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218D4223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbeKPNEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeKPNEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:04:39 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2BB2145D;
        Fri, 16 Nov 2018 02:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542336844;
        bh=miS6LUk5ZDCEg0m9lEwglCsTmxtJEjcNrhKfo+4YSPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLMaOnhuM0gwFNOh3AQMhSbgQN3wzKSpI9zvcu3Ma8A32npv3O8dEXuz2WYrZuKj1
         sWGXep3b02V0P2PQgWSAq1VLUaGVdej6LKhJd8SZTLmlQ65MKcqu9422By09/Wg2/1
         3qxDUSpS4IUm8DGtoYNlsFauXlsQIBpwwOrPvjWo=
Date:   Fri, 16 Nov 2018 10:53:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Fix indentation on iomuxc
 nodes
Message-ID: <20181116025348.GG5829@dragon>
References: <1541414884-19619-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541414884-19619-1-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 11:48:04AM +0100, Alex Gonzalez wrote:
> This patch corrects indentation problems in the gpmigrp and i2c1grp nodes.
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>

Applied, thanks.
