Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCE5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107AA2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107AA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeHBKYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:24:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHBKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:24:51 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B033C34;
        Thu,  2 Aug 2018 08:34:44 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:34:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sherry Yang <sherryy@android.com>
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com, maco@google.com,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 2/2] android: binder: Rate-limit debug and userspace
 triggered err msgs
Message-ID: <20180802083442.GA14091@kroah.com>
References: <20180727001718.242587-1-sherryy@android.com>
 <20180727001718.242587-3-sherryy@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727001718.242587-3-sherryy@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 05:17:18PM -0700, Sherry Yang wrote:
> Use rate-limited debug messages where userspace can trigger
> excessive log spams.
> 
> Acked-by: Arve Hjønnevåg <arve@android.com>
> Signed-off-by: Sherry Yang <sherryy@android.com>
> ---
>  drivers/android/binder.c       |  5 +++--
>  drivers/android/binder_alloc.c | 41 +++++++++++++++++++++-------------
>  2 files changed, 29 insertions(+), 17 deletions(-)

This patch does not apply to my tree at all.  Can you please rebase it
and resend?

thanks,

greg k-h
