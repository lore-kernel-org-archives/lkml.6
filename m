Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DBC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106F2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7106F2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeI3EnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:43:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55933 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeI3EnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:43:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g6NTy-0000CD-L7; Sun, 30 Sep 2018 00:13:02 +0200
Date:   Sun, 30 Sep 2018 00:13:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild test robot <lkp@intel.com>, Julia Cartwright <julia@ni.com>,
        kbuild-all@01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd wakeup
Message-ID: <20180929221301.z7dytm4whpcbip6a@linutronix.de>
References: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
 <201809290614.fxFuwGkP%fengguang.wu@intel.com>
 <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-29 08:38:55 [+0200], Thomas Gleixner wrote:
> On Sat, 29 Sep 2018, kbuild test robot wrote:
> > [also build test ERROR on v4.19-rc5 next-20180928]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> 
> It's against the RT tree, so it won't work against next or upstream. I
> think it would be good to have a machine parseable tag to describe which
> tree/branch/commit patches are applicable to. If that tag is missing, the
> bot can assume it's against upstream/next.

I asked the testing team to ignore patches or test against the RT tree
if the patch is tagged [PATCH RT]. I think it worked since I haven't
seen those mails.

> Thanks,
> 
> 	tglx

Sebastian
