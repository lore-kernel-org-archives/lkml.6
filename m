Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741CDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE697214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE697214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeHBN4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:56:54 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:18228 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbeHBN4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:56:53 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w72C5pGV026976;
        Thu, 2 Aug 2018 14:05:51 +0200
Date:   Thu, 2 Aug 2018 14:05:51 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     luo <a4651386@163.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: memory leak bug at linux kernel 3.10.108 and Other some versions.
Message-ID: <20180802120551.GD26716@1wt.eu>
References: <2dfb1be5.cad3.164fa76e1c4.Coremail.a4651386@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dfb1be5.cad3.164fa76e1c4.Coremail.a4651386@163.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 02, 2018 at 07:47:32PM +0800, luo wrote:
> In the process of learning Linux source code, I found a bug?In some versions,
> he can cause memory leaks, such as 3.10.108, 4.12.14, 3.19.8. Among them,
> 3.10 is the main line version?The ipc.opt object in the udp_sendmsg function
> may not be released resulting in a memory leak.Although I found that some
> other versions have fixed this problem, I did not pay special attention to
> seeing this vulnerability in the kernel vulnerability list, so I still
> submitted this bug.

Is it on purpose that you've tested this only on dead kernels ? Have you
tried to reproduce this issue with an up-to-date kernel from a branch that
is still maintained ?

Several thousands of bugs have been fixed since 3.10.108 was released 8
months ago and became end of life.

Regards,
Willy
