Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC83ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E0420C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE2stmmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E0420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeGQG7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbeGQG7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:59:19 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16B7208C3;
        Tue, 17 Jul 2018 06:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531808900;
        bh=H68xqFYssrcRNCQsXh3oSaUz2f01ZrV+4SZf3qeQ+YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DE2stmmpFKSYZmYUeO9oBC8+7AbegHvCWM8nUXUCxncNgGXMWPYvgvDpxV3PiUEL7
         5C4Hs+F5jzMoWb34qJM1uToa1GrFPZVuKCk4/f87/2+ARrcCZzCzJRrKsVpnAmhuk5
         tJU9q5KsTKl+Y5wE8c91Rdt+92LQYeeAJrk6uBaA=
Date:   Tue, 17 Jul 2018 14:28:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, s.hauer@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        dmaengine@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: configs: imx_v6_v7_defconfig: add DMATEST
 support
Message-ID: <20180717062809.GI4576@dragon>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
 <1531487327-21879-4-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531487327-21879-4-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:08:47PM +0800, Robin Gong wrote:
> Add DMATEST support and remove invalid options, such as
> CONFIG_BT_HCIUART_H4 is default enabled and CONFIG_SND_SOC_IMX_WM8962
> is out of date and not appear in any config file. Please refer to
> Documentation/driver-api/dmaengine/dmatest.rst to test MEMCPY feature
> of imx-sdma.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied this one, thanks.
