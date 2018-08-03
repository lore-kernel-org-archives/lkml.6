Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68292C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0840A21770
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0840A21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeHCPeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbeHCPeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:34:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2E82175D;
        Fri,  3 Aug 2018 13:37:43 +0000 (UTC)
Date:   Fri, 3 Aug 2018 09:37:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Erica Bugden <erica.bugden@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, anna-maria@linutronix.de, bigeasy@linutronix.de
Subject: Re: [PATCH] ftrace: Add missing check for existing hwlat thread
Message-ID: <20180803093740.27a8b0a5@gandalf.local.home>
In-Reply-To: <1533285974.2179.6.camel@linutronix.de>
References: <1533120354-22923-1-git-send-email-erica.bugden@linutronix.de>
        <20180801154006.580806cc@gandalf.local.home>
        <1533285974.2179.6.camel@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2018 10:46:14 +0200
Erica Bugden <erica.bugden@linutronix.de> wrote:


> > Can you try this patch?  
> 
> I tested the patch below and it also fixes the problem.

Thanks! May I add:

Tested-by: Erica Bugden <erica.bugden@linutronix.de>

?

-- Steve
