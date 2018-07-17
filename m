Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E02ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF39820BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqKl0fsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF39820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeGQERz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbeGQERz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:17:55 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40224208C3;
        Tue, 17 Jul 2018 03:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531799247;
        bh=vAUz/MkCcmsMWXAamr0Zqt5OY/3lZwAN6/vgU7LHKD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqKl0fsutWcVg++/L14EsKIxMQEswzcnxq9xCvyxZtOm/1H9L8fXuRmr0AxxxbvNe
         jX41loXfY35uVJ6vR/DYK6oSb6nUgtSm7Anx6tGD+r1UBe8hcgqtggAWnIhk84D7kH
         vqEgX+Hht4r3NP5zRVRFOIdv4y8j/yO5bSJoJDuU=
Date:   Tue, 17 Jul 2018 11:47:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        marek.vasut@gmail.com, fabio.estevam@nxp.com,
        leonard.crestez@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: mxs_defconfig: use MXSFB DRM driver
Message-ID: <20180717034714.GD4576@dragon>
References: <20180712105942.25245-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712105942.25245-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:59:41PM +0200, Stefan Agner wrote:
> Use the the DRM driver for MXSFB LCD controller (used in i.MX23/
> i.MX28/i.MX6SX or i.MX7). Remove CONFIG_FB_MXS which will soon be
> removed.
> 
> Note that this does not remove CONFIG_FB. CONFIG_FB gets selected
> implicity by CONFIG_DRM/CONFIG_DRM_KMS_FB_HELPER.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both, thanks.
