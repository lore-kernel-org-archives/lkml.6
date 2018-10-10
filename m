Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F7DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B06521479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucznPo2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B06521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJJOGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbeJJOGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:06:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9AB21479;
        Wed, 10 Oct 2018 06:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539153933;
        bh=qCK7Zfn5/uDeF+X7FSxgjqF0jiJDN3WTpEipb++3yGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucznPo2uucdR7T3qT525CiMs7cYrNI1Sq6DyRSHf2efUpGxJ/gSbPEUoXfEFe/xRi
         sZY+kYxMOE0uNze6VvO/Xv4XKK/Y9W6RfAO+rzfAsq9TI9sKQ/Tgh3ufbyOBKpYnL0
         GeXrtMN6GMLg6vm26lcuy9uNyCNOaE72KNB/bEyA=
Date:   Wed, 10 Oct 2018 08:45:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for 4.19 #4
Message-ID: <20181010064531.GB13182@kroah.com>
References: <20181010072001.425618eb@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010072001.425618eb@mschwideX1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 07:20:01AM +0200, Martin Schwidefsky wrote:
> Hi Greg,
> 
> please pull s390 fixes for 4.19:
> 
> The following changes since commit 4b92e7fd76e94624e3d5ff56b3d6a5788c4a7ac8:
> 
>   Merge tag 'mtd/fixes-for-4.19-rc5' of git://git.infradead.org/linux-mtd (2018-09-20 11:25:20 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.19-4

Now merged, thanks.

greg k-h
