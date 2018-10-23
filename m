Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A0C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D320665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9D320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJWMAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:00:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34312 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:00:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEnWu-0002hY-DO; Tue, 23 Oct 2018 03:38:52 +0000
Date:   Tue, 23 Oct 2018 04:38:52 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Metztli Information Technology <jose.r.r@metztli.com>
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Linux 4.17.19-1 hangs in Google cloud VM, too.
Message-ID: <20181023033852.GR32577@ZenIV.linux.org.uk>
References: <20181022101912.3CE2E292B005@huitzilopochtli.metztli-it.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022101912.3CE2E292B005@huitzilopochtli.metztli-it.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 03:19:12AM -0700, Metztli Information Technology wrote:
> I installed reiser4 -enhanced Linux kernel 4.17.19-1 --thus replacing the prior hung reiser4 -patched kernel 4.18.15-1 in the Google Compute Engine (GCE) cloud instance. After less than 24 hours the 4.17.19-1 hung in similar way to the 4.18.15-1.
> 
> Please note that I had been running my custom Metztli Reiser4 Debian Stretch image with reiser4 linux 4.14.20-1 without issues for several months
> < https://github.com/Metztli/reiser4-debian-kernel-packaging-4.14.20 >  --until I decided to upgrade to newer kernel(s).

Er...  Does anybody maintain reiser4 these days?  I can't recall a single mail
along the lines of "such-and-such VFS/VM/scheduler/etc. change would break reiser4"
in quite a few years (more than a decade, most likely)...
