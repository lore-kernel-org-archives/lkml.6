Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C81C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E88D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfARKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:41:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44547 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:41:34 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gkRad-00045l-3K; Fri, 18 Jan 2019 11:41:31 +0100
Message-ID: <1547808090.3375.5.camel@pengutronix.de>
Subject: Re: linux-next: build failure after merge of the imx-drm tree
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 18 Jan 2019 11:41:30 +0100
In-Reply-To: <20190118141912.69d2a6e9@canb.auug.org.au>
References: <20190118141912.69d2a6e9@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 14:19 +1100, Stephen Rothwell wrote:
> Hi Lucas,
> 
> After merging the imx-drm tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/gpu/drm/imx/imx-tve.c: At top level:
> drivers/gpu/drm/imx/imx-tve.c:437:29: error: storage size of 'clk_tve_di_ops' isn't known
>  static const struct clk_ops clk_tve_di_ops = {
>                              ^~~~~~~~~~~~~~
> 
> Exposed by commit
> 
>   97144d12df00 ("drm/imx: Allow building under COMPILE_TEST")
> 
> I have reverted that commit for today.

Sorry, I have dropped the commit for now.

regards
Philipp
