Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E594ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E2C208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E2C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeGPTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:02:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:02:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AACE3D75;
        Mon, 16 Jul 2018 18:34:04 +0000 (UTC)
Date:   Mon, 16 Jul 2018 20:34:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH 4.9 03/32] MIPS: Use async IPIs
 forarch_trigger_cpumask_backtrace()
Message-ID: <20180716183402.GC13309@kroah.com>
References: <20180716073504.433996952@linuxfoundation.org>
 <20180716073504.871411055@linuxfoundation.org>
 <tencent_63FC64B11AAB89F2466748AE@qq.com>
 <20180716094023.GA20647@kroah.com>
 <tencent_47C96C376F2E810C2237848B@qq.com>
 <20180716104621.GB11023@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716104621.GB11023@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:46:21PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 16, 2018 at 05:46:12PM +0800, 陈华才 wrote:
> > Just change "call_single_data_t" to "struct call_single_data" and everything is OK.
> 
> Ok, I've done that now, thanks.

And I messed it up.  So I've just dropped it entirely.  Can someone send
me a properly backported patch please?

thanks,

greg k-h
