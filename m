Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CEEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6B32148D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6B32148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJBHxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:53:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:53:24 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E8999D;
        Tue,  2 Oct 2018 01:12:50 +0000 (UTC)
Date:   Mon, 1 Oct 2018 17:53:12 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        nixiaoming <nixiaoming@huawei.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [GIT PULL] pstore fix for v4.19-rc7
Message-ID: <20181002005312.GA29284@kroah.com>
References: <20180930172907.GA3543@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930172907.GA3543@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 10:29:07AM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Please pull this pstore fix for v4.19-rc7.
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit 831b624df1b420c8f9281ed1307a8db23afb72df:
> 
>   pstore: Fix incorrect persistent ram buffer mapping (2018-09-13 09:14:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.19-rc7

Now pulled, thanks.

greg k-h
