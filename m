Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE90BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855E021735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwVl8OVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855E021735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeH0LMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeH0LMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:12:45 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37A6208B2;
        Mon, 27 Aug 2018 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535354840;
        bh=FK16ckoJ4xuoMx3aF7L7RcFxWPZtuC9/QmsnH8Vq6rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwVl8OVBBQ392ZUGgVcLv0uJBAb7oyGWTzTOMhEa/rpqOhnQlw3mE+3JNHaJVHveJ
         jXlPb2U3VDq5wqkw2fTsKmH7qE3rcJdGC9kCVKbmaTEMnxO3j54o7djNGXkqQnlk6N
         zGYBT+36gffvmeZTyBKM19apQYrO8fSsw5Bd+ghU=
Date:   Mon, 27 Aug 2018 15:26:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pierre-Jean Texier <texier.pj2@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx7s-warp: enable i2c3 device support
Message-ID: <20180827072625.GI3850@dragon>
References: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:23:17PM +0200, Pierre-Jean Texier wrote:
> The WaRP7 has one mikroBUS socket on the back to plug click boards.
> This patch allows to interact with some of these
> i2c modules (EEPROM, RTC and so on).
> 
> Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>

Applied, thanks.
