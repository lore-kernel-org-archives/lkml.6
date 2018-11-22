Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54191C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2091D20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2091D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394110AbeKVUzI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:55:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47190 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390727AbeKVUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:55:07 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gPm1s-0002aZ-8K; Thu, 22 Nov 2018 11:16:12 +0100
Date:   Thu, 22 Nov 2018 11:16:12 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zhe.he@windriver.com
Cc:     catalin.marinas@arm.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181122101611.tmbmylbshd4mrnxi@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-22 17:04:19 [+0800], zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> kmemleak_lock, as a rwlock on RT, can possibly be held in atomic context and
> causes the follow BUG.

please use
 [PATCH RT … ]

in future while posting for RT. And this was (and is) on my TODO list.

Sebastian
