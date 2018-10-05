Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42007C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40062084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40062084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJEXhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:37:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJEXhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:37:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g8T6x-0004it-Bn; Fri, 05 Oct 2018 18:37:55 +0200
Date:   Fri, 5 Oct 2018 18:37:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Clark Williams <williams@redhat.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] rt: convert mm/kasan/quarantine_lock to raw_spinlock
Message-ID: <20181005163754.2eexrmhzvdltswdr@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com>
 <201809190442.itGUBZK3%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201809190442.itGUBZK3%fengguang.wu@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-19 04:34:50 [+0800], kbuild test robot wrote:
> Hi Clark,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linux-rt-devel/for-kbuild-bot/current-stable]
> 
> url:    https://github.com/0day-ci/linux/commits/Clark-Williams/rt-convert-mm-kasan-quarantine_lock-to-raw_spinlock/20180919-021343
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git for-kbuild-bot/current-stable
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):

how is this related? Could someone please explain this.

Sebastian
