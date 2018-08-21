Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEF3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831E12174D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x6qmAw6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831E12174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeHULvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeHULvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:51:04 -0400
Received: from dragon (unknown [45.56.155.40])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B8C216C4;
        Tue, 21 Aug 2018 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534840312;
        bh=urz44bPCElC5t4vhQ0C2S8Hlo3F8CvioFweFIvLwIzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x6qmAw6DdeEdq19UYwdBRXo+sfvnA8ZKApIJ5SdXkXkjCeDP3kI2FsGFXD8G6muPD
         ewrLrXUmdCXc+l+StpmpA1zuxKcHUJ0WYmvw+QI30NRBDNUevbx6A4tYavHYLv5D9+
         GUHps4oFl6IuxRvYEveQCQhmwwoOLG3OQHRWQrJE=
Date:   Tue, 21 Aug 2018 16:31:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6sll: add gpio-ranges property
Message-ID: <20180821083115.GA31070@dragon>
References: <1532081217-17538-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532081217-17538-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 06:06:57PM +0800, Anson Huang wrote:
> Add "gpio-ranges" property to establish connections between GPIOs
> and PINs on i.MX6SLL pinctrl driver, for details, please refer to
> Documentation/devicetree/bindings/gpio/gpio.txt of "gpio-ranges"
> property.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
