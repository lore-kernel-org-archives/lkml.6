Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57942C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1268D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2JdEUP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1268D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeK3DNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:13:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbeK3DNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:13:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4D521019;
        Thu, 29 Nov 2018 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543507645;
        bh=jbjQKyJFpluvQ4e9ejq2Z2Id2I7VfeaRc3CMKImKzbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2JdEUP/ED1GFAjhu65dYbVBfwHtbTRhYw/cgjCLXVCua6WE9bh2/aKWMXViL8tJ+
         jEDcoRZH15RK+JfpUsVehDAW2tgxbmK+TdqUJgYHdPNrrGwBVF9eVMy2lbRKmEvofO
         Nluwxa5Ti5aghRUyZByWF7S3BLfwy+/cvH78Q0Tw=
Date:   Thu, 29 Nov 2018 17:07:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 4.19 033/110] bfs: add sanity check at bfs_fill_super()
Message-ID: <20181129160722.GA31919@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:23:00PM +0000, Tigran Aivazian wrote:
> Hello,
> 
> Yes, of course I object to it. I ignored this version of the patch
> being applied to the older Linux versions, but for the latest versions
> surely the version that I have authored should be applied instead. I
> have sent to Andrew Morton both the 4.20-rc1 and 4.19.2 versions of
> the patch. The 4.20 was applied (as "linux-next", I don't know why it
> is not in 4.20-rc4 yet), but 4.19.2 version was not applied yet, so
> here it is attached again (with the proper changelog etc). It applies
> to 4.19.5 cleanly as well, so please use this version (attached).

I can not apply a patch to the stable trees that are not in Linus's tree
first.  So there's nothing I can do here with this.

Until then, I'll take the patch that is already in Linus's tree, which
is what I did here, thanks.

greg k-h
