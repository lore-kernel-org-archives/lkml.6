Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D9524E4F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnuC9Uv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D9524E4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeGAJqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeGAJqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:46:31 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB0924371;
        Sun,  1 Jul 2018 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530438391;
        bh=ZrMN75KFAphwtwPcYluAN6FoInOtRb+qB6c9f5w/diM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnuC9Uv8ktIAJH+wjUyHaY5TV/ihnTOcV/tHrRnVCDsRWUSx5sh+Sf/Llo6uukNSj
         AofNHdjHCdYYuGdQTOlMLHt9qriyDgl/3f3iq13Nz1wJP/wepJMXnIxc1Stog578gS
         V1a9z9Kl943gG3csvuR1p3HBtlfThNYEtSa9z3RE=
Date:   Sun, 1 Jul 2018 17:46:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: Add missing chosen/stdout-path
Message-ID: <20180701094618.GO4348@dragon>
References: <75f7fb96d53404152e742d405e2a14c5aa0f4438.1529957171.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f7fb96d53404152e742d405e2a14c5aa0f4438.1529957171.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:09:32PM +0300, Leonard Crestez wrote:
> This makes it possible to enable earlycon for debugging by just passing
> an empty "earlycon" argument on the kernel command-line.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
