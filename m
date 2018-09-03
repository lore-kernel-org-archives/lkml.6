Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87054C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365FF20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbxHK3/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365FF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeICFge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICFgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:36:33 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 719BD20841;
        Mon,  3 Sep 2018 01:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535937528;
        bh=GFfG+QyXKuWXT9UVAcvyzlk2PTLaeg3WCwmdw+2R0eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbxHK3/5Q7TbLYuvvsbRDO5daV/JLh0e1ajzGYqVcNQoGQMGkXBjEsNERHZmb4lq0
         5IV/isiZ1996iOof2Gj7VyA3/we6t+MNT4prwHiXCK73udPfxPJTjKdAq2Z6dL3nq1
         JJn8+cGTtJQYQ/4qPzDM8R9I4sEJLXAMqmy/RVcI=
Date:   Mon, 3 Sep 2018 09:17:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] ARM: imx_v6_v7_defconfig: select CONFIG_ARM_CPUIDLE
 by default
Message-ID: <20180903011737.GA3850@dragon>
References: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
 <1535518847-24417-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535518847-24417-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:00:47PM +0800, Anson Huang wrote:
> Some i.MX platforms like i.MX7S/D uses generic ARM cpuidle
> driver and psci method to support cpuidle feature, select
> CONFIG_ARM_CPUIDLE by default for such platforms.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
