Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8590E2174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="czebVZYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8590E2174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeH0FKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeH0FKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:10:06 -0400
Received: from dragon (unknown [104.237.86.214])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155DF2174A;
        Mon, 27 Aug 2018 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535333144;
        bh=/5vt9iQE2BmIVOQL2XPsAB7ZIcKsBtgYJ7RL6UGNEEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czebVZYs1OG43/sg78xFuDv6ZSPdFBm/wlpeN74XeilkSZO+hOaMDuOfi+AVtETsC
         4VUBPKzDuztAhe59+TN/XcOIoA5RpkkwSTwbLtTnTze3LTHX20T5bEDfOxKX+ZF0Nc
         jzCcsuTV7ce6SCeDDeZhR7fPg0C2Y9aM9zZoIiQs=
Date:   Mon, 27 Aug 2018 09:24:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7ulp: update pinfunc header file
Message-ID: <20180827012454.GC29208@dragon>
References: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:10:35AM +0800, Anson Huang wrote:
> The i.MX7ULP B0 chip has some pin changes for USB and VIU
> module, update pinfunc header file accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
