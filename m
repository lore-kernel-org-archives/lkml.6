Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8362084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8362084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeI2NGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:06:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55523 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbeI2NGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:06:20 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g68u0-0001Ok-0h; Sat, 29 Sep 2018 08:38:56 +0200
Date:   Sat, 29 Sep 2018 08:38:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     Julia Cartwright <julia@ni.com>, kbuild-all@01.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd
 wakeup
In-Reply-To: <201809290614.fxFuwGkP%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
References: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com> <201809290614.fxFuwGkP%fengguang.wu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2018, kbuild test robot wrote:
> [also build test ERROR on v4.19-rc5 next-20180928]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 

It's against the RT tree, so it won't work against next or upstream. I
think it would be good to have a machine parseable tag to describe which
tree/branch/commit patches are applicable to. If that tag is missing, the
bot can assume it's against upstream/next.

Thanks,

	tglx
