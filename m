Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A561C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E0D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA3TapgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E0D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeK1TnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeK1TnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:43:02 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79C320832;
        Wed, 28 Nov 2018 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543394532;
        bh=Qt5jw7wSn4B8ItHZFh2i1jDsWL9cCwH7QGA1WUTWMtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZA3TapgZQMVeK8pYWfKyb7Otg2+1GUI4ywfQzOql+lBBcTqa4fMvT613FNrcOwwOv
         n0Q/B14dndJOX/D9nv5D4XsmbnvgbE8gYvefmyZoWgN/KEOn0O71feGi9eer3tYuu7
         gFHPFiPgM8seAx+bEcbfyYx3feaCKcrgAwYe8etk=
Date:   Wed, 28 Nov 2018 16:41:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v3 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
Message-ID: <20181128084142.GN20643@dragon>
References: <20181125222027.22071-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125222027.22071-1-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 08:20:25PM -0200, Otavio Salvador wrote:
> CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> selected by ARM EABI (AEBI) support.  This is done in preparation to making
> further changes to this defconfig cleaner.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Applied all, thanks.
