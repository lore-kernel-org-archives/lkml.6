Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B69C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAA82152B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYS8zYZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAA82152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJTVjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 17:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeJTVjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 17:39:02 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6C721529;
        Sat, 20 Oct 2018 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540042113;
        bh=Lz48YJVgNZT7qr36+IDedRQjvYK9I36GpVGMReJqiwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYS8zYZTJrH/yoSG+t2IYMDGjqJc2NNI1Ir5Kv8zmg0p4F+AJXGuEjjPzsQ+6rN/1
         NHbVTTQDEkH0+dpFa2OKEqE5bApwv1lobzpAE+16GCiGqvNsohbBsI40F1DTxRYzX0
         POqhl5SGIiCMPgqBlRlrV9gny3ruCN8dvkjHqz1o=
Date:   Sat, 20 Oct 2018 15:28:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] perf fixes
Message-ID: <20181020132831.GA31145@kroah.com>
References: <20181020081039.GA92090@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020081039.GA92090@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 10:10:39AM +0200, Ingo Molnar wrote:
> Greg,
> 
> Please pull the latest perf-urgent-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

Now merged, thanks.

greg k-h
