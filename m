Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DD1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2972F21736
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2972F21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeHCQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:54:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40242 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeHCQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:54:26 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=grouplt.guests.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <erica.bugden@linutronix.de>)
        id 1flbWP-0002Qt-W0; Fri, 03 Aug 2018 16:57:42 +0200
Message-ID: <1533308256.4587.1.camel@linutronix.de>
Subject: Re: [PATCH] ftrace: Add missing check for existing hwlat thread
From:   Erica Bugden <erica.bugden@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, anna-maria@linutronix.de, bigeasy@linutronix.de
Date:   Fri, 03 Aug 2018 16:57:36 +0200
In-Reply-To: <20180803093740.27a8b0a5@gandalf.local.home>
References: <1533120354-22923-1-git-send-email-erica.bugden@linutronix.de>
         <20180801154006.580806cc@gandalf.local.home>
         <1533285974.2179.6.camel@linutronix.de>
         <20180803093740.27a8b0a5@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 09:37 -0400, Steven Rostedt wrote:
> On Fri, 03 Aug 2018 10:46:14 +0200
> Erica Bugden <erica.bugden@linutronix.de> wrote:
> 
> 
> > > Can you try this patch?  
> > 
> > I tested the patch below and it also fixes the problem.
> 
> Thanks! May I add:
> 
> Tested-by: Erica Bugden <erica.bugden@linutronix.de>
> 
> ?

Certainly! One must be held responsible when one makes a claim :)

  Erica

> 
> -- Steve
