Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044BC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7014E2173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058570;
	bh=0bvZHHzm6tJifhBDNpq6TsE2lJQr6cEOH8A1+w7maow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nLmUl6vX5FPNKKJl13jcYA4ovr6NWBWu9bgFRfjwBTnCUm19RLKl67aKtyUBtagUm
	 IStpflUoQyaur4McMr+wl3tcECDOsTo31Zt2J+CacY6StEYfcR644ulCpxDHVX6Zxw
	 cp4M/xkzpPkEgJ2MJ/lcd8XD2zVLgwd0MiZYk7Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfAIS3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfAIS33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:29:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B5C20665;
        Wed,  9 Jan 2019 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547058568;
        bh=0bvZHHzm6tJifhBDNpq6TsE2lJQr6cEOH8A1+w7maow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPhnsfLnO5/Z1Ty3gvmAAZsMXeCM4O3Dk69lYs95xy9+kvbW2buaZ1fexhEfOHtGW
         XneWM3vfpkIhUJ3vURPIDs3dRQoGFLvCSMFZz9ea8ZQeLzXpUhnXr2ZKWUWWPYCYzc
         RcswD2kbu2m+y3VM/9ij8ZgMuzNlBs8Qar88751w=
Date:   Wed, 9 Jan 2019 19:29:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.19.14
Message-ID: <20190109182926.GB17500@kroah.com>
References: <20190109182918.GA17500@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109182918.GA17500@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c04c050f5bf98845bfe22164b8a1503d696a6e26
diff --git a/Makefile b/Makefile
index 9770f29a690a..892ff14cbc9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 12
+SUBLEVEL = 13
 EXTRAVERSION =
 NAME = "People's Front"
 
