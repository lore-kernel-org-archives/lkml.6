Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E62C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA09B20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA09B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIDVJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDVJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:09:53 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E676C2082B;
        Tue,  4 Sep 2018 16:43:57 +0000 (UTC)
Date:   Tue, 4 Sep 2018 12:43:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Erica Bugden <erica.bugden@linutronix.de>
Subject: Re: [PATCH AUTOSEL 4.18 037/131] ftrace: Add missing check for
 existing hwlat thread
Message-ID: <20180904124356.4a2f3dbc@gandalf.local.home>
In-Reply-To: <20180902064601.183036-37-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
        <20180902064601.183036-37-alexander.levin@microsoft.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Sep 2018 13:03:43 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> [
>  Note, this only fixes the symptom. The real fix was not to call
>  this function when tracing_on was already one. But this still makes
>  the code more robust, so we'll add it.
> ]

This patch really didn't need to be backported (which is why I didn't
mark it for stable), because the real fix was backported.

-- Steve
