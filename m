Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B3DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE7720833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE7720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeIJNF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:05:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:05:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6A92CD4;
        Mon, 10 Sep 2018 08:13:06 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:13:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, weidu.du@huawei.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/2 dhowells/mount-api] staging: erofs: rename superblock
 flags (MS_xyz -> SB_xyz)
Message-ID: <20180910081304.GA19096@kroah.com>
References: <1536224508-66168-1-git-send-email-gaoxiang25@huawei.com>
 <17402.1536228489@warthog.procyon.org.uk>
 <1643231b-7538-0f43-1670-7fddadd7ca87@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643231b-7538-0f43-1670-7fddadd7ca87@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:37:37PM +0800, Gao Xiang wrote:
> 
> 
> On 2018/9/6 18:08, David Howells wrote:
> > Gao Xiang <gaoxiang25@huawei.com> wrote:
> > 
> >> This patch follows commit 1751e8a6cb93 ("Rename superblock
> >> flags (MS_xyz -> SB_xyz)") and after commit ("vfs: Suppress
> >> MS_* flag defs within the kernel unless explicitly enabled"),
> >> there is no MS_RDONLY and MS_NOATIME at all.
> >>
> >> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > I recommend pushing this one to Linus now.  It's trivial enough.
> 
> Hi David,
> I personally think that is fine, but I'd like to get Greg's idea and agreement, too...
> 
> > 
> > Reviewed-by: David Howells <dhowells@redhat.com>
> 
> Hi Greg,
> 
> As David suggested above, could you please help merge this patch to Linus?
> It's trivial enough (since the commit 1751e8a6cb93) and MS_xyz will be removed
> in the new mount apis patchset...

Now applied to my local tree, thanks.

greg k-h
