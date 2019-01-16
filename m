Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE018C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870E7206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404207AbfAPL6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:58:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57209 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392751AbfAPL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:58:07 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 0352eca9a8065bb1; Wed, 16 Jan 2019 12:58:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM/runtime: Do not needlessly call ktime_get
Date:   Wed, 16 Jan 2019 12:57:13 +0100
Message-ID: <10417091.Yigb8Rxq05@aspire.rjw.lan>
In-Reply-To: <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
References: <20190110095125.GA4491@lenoch> <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 10, 2019 7:56:19 PM CET Vincent Guittot wrote:
> On Thu, 10 Jan 2019 at 10:51, Ladislav Michl <ladis@linux-mips.org> wrote:
> >
> > pm_runtime_autosuspend_expiration calls ktime_get even when
> > its returned value may be unused. Therefore get current time
> > later and remove gotos while there.
> >
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Patch applied, thanks!

