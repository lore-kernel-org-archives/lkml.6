Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356EBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F155021721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548136946;
	bh=TunUp5w39QcHe/ox8e2z+750VQ/9DLwuXP3dMRE/GGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jO/V6ohnIetea/lZtFYgwQdw5t/JpmOu2i+z4GltVdpMw0NF51126lbtJGM3pSAmg
	 CZHx6YT4lsS+IOCQr1jytcfBhRIKxYCFuuXS2BebZ20AFkmAnEE5CAwAnxX8pPc3Az
	 ZHIDhxeHpI4LPEXuwtFIbX/TpUVeK3lPdv0W/Ols=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfAVGCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVGCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:02:24 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DDE20870;
        Tue, 22 Jan 2019 06:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548136943;
        bh=TunUp5w39QcHe/ox8e2z+750VQ/9DLwuXP3dMRE/GGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=flmIip5t8vo7NtF0fl1B562/f9T6SA51J6DbshaavseJV7c81Tqx8bc0j1OZvP4s7
         E9MNjMLyuAtpPa2dwPyzkqLQQ2cKW1OnwVRJpemrHCmUYvj/JujFZ3fK4hrrdfPCy4
         OhobEu/Rv3qZvWfBG2Mbnv3IkU7h18/mT1zgdrHc=
Date:   Tue, 22 Jan 2019 14:01:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, max.krummenacher@toradex.com,
        marcel.ziswiler@toradex.com, dev@pschenker.ch,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: colibri: use valid range configuration for weim
Message-ID: <20190122060141.GB19929@dragon>
References: <20190121155327.12554-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121155327.12554-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:53:27PM +0100, Stefan Agner wrote:
> A valid WEIM range configuration must specify range entries for
> all four chip selects. This fixes an error on boot:
>   imx-weim: probe of 21b8000.weim failed with error -22
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
