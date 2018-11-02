Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E7C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDD420833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAOtj04a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDD420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeKCEXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKCEXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:23:52 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 137D120831;
        Fri,  2 Nov 2018 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541186130;
        bh=ceLn2hbH77TzxrpxTuxF34o8zEc0IsWBgeduzB0AAzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAOtj04a5xKshn52Il0YA2cUQZEQDNM5aqm8VS+7m94hVPoTV7kRcAfH2RvMfWiy2
         AOamFjSMx2Eq+kY2QNNz2AMW20bT8DhQmDXjii555cV4fBzRQ4oXtaMTpf3is6b7M+
         plIR9Z+62JKjd9H5+yT3T/SYqRUMmbc7c2kP4WCY=
Date:   Fri, 2 Nov 2018 20:15:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Dave Mielke <Dave@mielke.cc>,
        Adam Borowski <kilobyte@angband.pl>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: fix broken display when running aptitude
Message-ID: <20181102191527.GA30831@kroah.com>
References: <alpine.LRH.2.02.1810231126100.20699@file01.intranet.prod.int.rdu2.redhat.com>
 <nycvar.YSQ.7.76.1810231139460.1498@knanqh.ubzr>
 <nycvar.YSQ.7.76.1811021447200.1498@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1811021447200.1498@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 03:09:14PM -0400, Nicolas Pitre wrote:
> Greg, are you picking up this patch?
> 
> Would be nice to have in v4.19.1.

4.19.1-rc1 is already out.  My queue is _huge_ give me some time to
catch up...

greg k-h
