Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0D120852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxrtMj8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0D120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937132AbeFSAjY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 20:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937043AbeFSAjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 20:39:23 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C182083A;
        Tue, 19 Jun 2018 00:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529368763;
        bh=cT1RF8n+exMzqbObGa/oczqSpISJXvVY6P6oUuLG80I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxrtMj8SxwGaCxHnUmg36BAgPv3WwxRWFlVb68JXj/cVATBlbsr8cY2h0mPLJUm3I
         0fMZPHetq+B278GIKfLeU7pU+jeGzLdIRvxi9ckuirN/HnRltQ47eFKGq+ljki+JNZ
         y2tb0TC6J81lfrwPTcXnpBX1zSSswLIgb4SDFzgk=
Date:   Tue, 19 Jun 2018 08:38:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: imx: add standby mode suspend for i.MX6SLL
Message-ID: <20180619003826.GS16091@dragon>
References: <1527732369-19740-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527732369-19740-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:06:08AM +0800, Anson Huang wrote:
> Add standby mode suspend for i.MX6SLL, when
> linux kernel suspend, SoC will enter STOP mode
> with ARM core power on.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
