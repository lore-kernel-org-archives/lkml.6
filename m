Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2AFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBDF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n52nmPod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBDF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJQAqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbeJQAqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:46:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A3C205C9;
        Tue, 16 Oct 2018 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539708916;
        bh=S2756JFKWiXyrAjyYPfa1ZJCvqaUlUt9eBaUmSmAIAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n52nmPod4Cfbc008Hj3NtJWc9BmD8i6D2ELmQsL/zyMLdYLL4e4MAfbO6luezZuS7
         ooAlsR2NxYBK2xvuIQ07cKdUyQg8hLhxo0MANjVdcXE5k+SwT+mbveaUguvu3/96Gq
         LtKE9x03Ki2Eu1+WsAquma1+THp59YMywT5NEYLs=
Date:   Tue, 16 Oct 2018 18:55:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Sparc
Message-ID: <20181016165514.GE9547@kroah.com>
References: <20181015.193945.304905055642913000.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015.193945.304905055642913000.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:39:45PM -0700, David Miller wrote:
> 
> 1) Revert the %pOF change, it causes regressions.
> 
> 2) Wire up io_pgetevents().
> 
> 3) Fix perf events on single-PCR sparc64 cpus.
> 
> 4) Do proper perf event throttling like arm and x86.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit 0854ba5ff5c938307cd783e996b62c83f1ce923b:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2018-10-08 16:25:01 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

Now merged, thanks.

greg k-h
