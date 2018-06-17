Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19F4C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDD82086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QInow0qO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDD82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbeFQHWD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeFQHWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:22:01 -0400
Received: from dragon (unknown [45.56.152.75])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9952086A;
        Sun, 17 Jun 2018 07:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529220121;
        bh=2W/kyQTDp17HM1MTdc+kaSKQkC4+GwzFHaKvLzEEvCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QInow0qO5AQ00BkUosKA/KkQUYny/6UNEsgmmOrHqU3jzKzOmqtyMPQK5ldI9XBdZ
         ACSGPzNxMhX52dUoy4uUv/o+65nCBP61aWY3l4Er9V/C+I6WRknAqyzGodDIOfyi8q
         2GzNb4nPgHG+ArQX28uT4+UJ078TKEzgF0vwEogc=
Date:   Sun, 17 Jun 2018 15:21:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Colin Didier <colin.dider@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH 1/5] ARM: imx: remove inexistant EPIT timer init
Message-ID: <20180617072109.GO16091@dragon>
References: <20180528173412.10000-1-peron.clem@gmail.com>
 <20180528173412.10000-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180528173412.10000-2-peron.clem@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 07:34:08PM +0200, Clément Péron wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> i.MX EPIT timer has been removed but not the init function declaration.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>

Applied, thanks.
