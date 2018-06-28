Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D61624A03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPbiMrL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D61624A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeF1D0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeF1D03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:26:29 -0400
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF2D120685;
        Thu, 28 Jun 2018 03:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530156389;
        bh=PtlB2UyG+KTSSz3ZcdPnWdOz9Ol0nuibyhcjZsOG4M0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPbiMrL91Y4YnLLod57rsvMQkMrTjZl4AxLA0u3bj9V8HgQkosygWG5LMeua49vCq
         1C7CmnOVKMnRD2+syVpVWTbFwJGh1S9dhvUZgMkZrFcoEQyOZOVNaDmhki9qLFHSeP
         S0VHGlVraaSSkHhJgPXBAPJ2kp7njuSLhI34w/p8=
Date:   Thu, 28 Jun 2018 11:25:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sll: declare src module to be compatible
 to imx51's src
Message-ID: <20180628032510.GH22683@dragon>
References: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:38:37PM +0800, Anson Huang wrote:
> i.MX6SLL uses same SRC module as i.MX51, add "fsl,imx51-src"
> compatible string to enable SRC driver to support setting
> CPU resume address for cpu-idle and suspend/resume.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
