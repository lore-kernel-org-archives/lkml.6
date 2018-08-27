Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EA82174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgNMZ76x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EA82174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeH0GGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeH0GGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:06:05 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087F7216FA;
        Mon, 27 Aug 2018 02:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535336494;
        bh=9gNL5vAu1PoqwG5hdfkHqBTnb63D1FVbo+S3RpInRRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgNMZ76xHbXtB3LzUiOhIQhOv/lIDn4LlIRSwBxs9x2RMbc3PPRwe3F/25lmWk3Tf
         S+dLhSai9J07R2EiO+ojaS9KhjTXJ2STzLnJ57PhLUvbgTFxKkqJtGgwVE31SSz7Ui
         9mk1WlD6s3pFvJiymFWLa6lLUWVtXEKfhSI+yUUU=
Date:   Mon, 27 Aug 2018 10:20:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: arm: configs: imx_v6_v7: add
 CONFIG_FW_LOADER_USER_HELPER
Message-ID: <20180827022031.GB3850@dragon>
References: <1533579655-5498-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533579655-5498-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 02:20:55AM +0800, Robin Gong wrote:
> To support loading sdma firmware automatically from rootfs, enable
> CONFIG_FW_LOADER_USER_HELPER/CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
> Please get sdma firmware from below link and put it into
> rootfs entry -- /lib/firmware/imx/sdma/:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Changed subject prefix like 'ARM: imx_v6_v7_defconfig: ...', and applied
the patch.

Shawn
