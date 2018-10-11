Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FF9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65E72085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJrZgCgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65E72085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJLBNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbeJLBNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:13:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED932085B;
        Thu, 11 Oct 2018 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539279919;
        bh=b4bRaE0nEOA/HbENSIBsv5YSgWfK7SuicaEikoKECPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJrZgCgxTsJG/9x3qqJ7ezcPworCxpvnWKLklXFfO4a8BrBdNuXv3n4urzgIRtgB+
         BdA8oIUN4QRP08+szvuz0Up8pFuNFpe04ocCSzjNW4kAMV5ptKNV38WVNQkJJoN0C5
         Ic4/XJ7wdzubcn7jS2rlCYQpSKSfWMLK87JqZJQ0=
Date:   Thu, 11 Oct 2018 19:45:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Subject: Re: [GIT PULL] Kbuild fixes for v4.19-rc8
Message-ID: <20181011174516.GC23310@kroah.com>
References: <CAK7LNAQHYH-SM+fZ0PkLYYCpeHZ-yYDKQpFeJKb7BCR7LtCr0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQHYH-SM+fZ0PkLYYCpeHZ-yYDKQpFeJKb7BCR7LtCr0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:32:55AM +0900, Masahiro Yamada wrote:
> Hi Greg,
> 
> Please pull a couple of Kbuild fixes.
> 
> Thanks.
> 
> 
> 
> The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:
> 
>   Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> tags/kbuild-fixes-v4.19-2

Now merged, thanks.

greg k-h
