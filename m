Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D91EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E4220700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfBVIhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:37:15 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51919 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfBVIhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:37:14 -0500
X-Originating-IP: 90.88.23.190
Received: from windsurf (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 567341BF203;
        Fri, 22 Feb 2019 08:37:12 +0000 (UTC)
Date:   Fri, 22 Feb 2019 09:37:11 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: clk-gpio: add support for sleeping GPIOs in
 gpio-gate-clk
Message-ID: <20190222093711.3dca5f3b@windsurf>
In-Reply-To: <155078670927.77512.17882802117777143214@swboyd.mtv.corp.google.com>
References: <20190211135818.10518-1-thomas.petazzoni@bootlin.com>
        <155007806256.115909.10137511038361789251@swboyd.mtv.corp.google.com>
        <155078670927.77512.17882802117777143214@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 21 Feb 2019 14:05:09 -0800
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Stephen Boyd (2019-02-13 09:14:22)
> > 
> > static?
> 
> Ok I marked it static and applied to clk-next.

Thanks, and sorry for not getting back with a v2 in a timely fashion. I
had several patch series in-flight for this project, and for several of
them, additional iterations were needed, so I kind of lost track of
this one. Sorry about that.

Thanks again,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
