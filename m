Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8783F20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1sSYLokp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8783F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937198AbeFSBJV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937125AbeFSBJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:09:20 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4D42075E;
        Tue, 19 Jun 2018 01:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529370560;
        bh=vNXRFmt3Fn+5CPoPNXqgi2SmraPMU+q5UorERn80dIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1sSYLokpgzVRwLP+5EkvAsgwghJ2/wfBGp05nFhAcdnG1InPuLPVeu2S0GuxoC/9t
         7yHgeSg+W/NEMRVzcg7MKAY1FC9iYNMbmrXSzxsh/OAZL0/nvuzTi9tLODIszxsVtK
         85i5sSqL/qwfxwH16uadriY05KKPY/EF+N/W67L8=
Date:   Tue, 19 Jun 2018 09:08:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] ARM: imx: add L2 page power control for GPC
Message-ID: <20180619010824.GT16091@dragon>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 10:33:44AM +0800, Anson Huang wrote:
> Some platforms like i.MX6UL/i.MX6SLL have L2
> page power control in GPC, it needs to be
> disabled if ARM is power gated and L2 is NOT
> flushed, add GPC interface to control it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
