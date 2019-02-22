Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBED92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBVPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:51:04 -0500
Received: from ms.lwn.net ([45.79.88.28]:52596 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfBVPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:51:03 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 21FF335A;
        Fri, 22 Feb 2019 15:51:03 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:51:02 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     George Sofianos <gsf.greece@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] Docs: Correct /proc/stat path
Message-ID: <20190222085102.4397c660@lwn.net>
In-Reply-To: <20190220012245.16858-1-gsf.greece@gmail.com>
References: <20190220012245.16858-1-gsf.greece@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 03:22:45 +0200
George Sofianos <gsf.greece@gmail.com> wrote:

> The documentation for dynamic ticks in high resolution timers uses an
> old path for the stat process.
> 
> Signed-off-by: George Sofianos <gsf.greece@gmail.com>

Applied, though I tweaked the changelog (there is no "stat process"
involved here).

Thanks,

jon
