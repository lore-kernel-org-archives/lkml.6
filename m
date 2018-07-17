Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F06EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E8B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E8B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeGQHwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:52:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbeGQHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:52:09 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2D6ABE6;
        Tue, 17 Jul 2018 07:20:57 +0000 (UTC)
Date:   Tue, 17 Jul 2018 09:20:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH 4.9 03/32] MIPS: Use async
 IPIsforarch_trigger_cpumask_backtrace()
Message-ID: <20180717072055.GB12255@kroah.com>
References: <20180716073504.433996952@linuxfoundation.org>
 <20180716073504.871411055@linuxfoundation.org>
 <tencent_63FC64B11AAB89F2466748AE@qq.com>
 <20180716094023.GA20647@kroah.com>
 <tencent_47C96C376F2E810C2237848B@qq.com>
 <20180716104621.GB11023@kroah.com>
 <20180716183402.GC13309@kroah.com>
 <tencent_06288B95133EFFAE55198FCC@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_06288B95133EFFAE55198FCC@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:53:38PM +0800, 陈华才 wrote:
> Hi, Greg,
> 
> I have backported and tested it to 4.9 and 4.4:
> https://patchwork.linux-mips.org/patch/19862/
> https://patchwork.linux-mips.org/patch/19863/

I can't do anything with random web links.  Please properly cc: the
stable list with the backports and I can take them from there.

And are you sure they are needed for 4.4.y?

thanks,

greg k-h
