Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42EFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64032086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64032086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbeKTAej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:34:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45283 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbeKTAej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:34:39 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gOkGM-00039G-6J; Mon, 19 Nov 2018 15:10:54 +0100
Message-ID: <1542636653.2508.8.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] GPCv2 support for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 19 Nov 2018 15:10:53 +0100
In-Reply-To: <20181117181206.10267-1-andrew.smirnov@gmail.com>
References: <20181117181206.10267-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Am Samstag, den 17.11.2018, 10:12 -0800 schrieb Andrey Smirnov:
> Everyone:
> 
> This series contains changes I made to add support for i.MX8MQ to
> GPCv2 driver in order to enable support of PCIE IP block on i.MX8MQ
> SoCs (full tree can be found at [github-v0]). This series is _very_
> preliminary and by no means is ready for inclusion (it also has some
> unmet dependencies).  However is should be in OK enough shape to get
> some early feedback on, which is the intent of this submission.
> 
> All other feedback is appreciated as well!

I've already sent out my version of the GPCv2 i.MX8M support on Friday,
but for whatever reason missed to CC you. It's unfortunate that we now
have 2 slightly different versions of this on the list.

Regards,
Lucas
