Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D90C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E232063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218066;
	bh=y7IJsGFBHSlochemvbOG0/WN9PTQpMs5W2tXeui6gk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xsolYw13bT6a7YpjUI8tefSxtCjetHJuACPjdpI7HEMLfjcFpL9UTVC4a+mYuI9AT
	 p39dyyQA7fEqHVBJbG1B6dGdT07B20veSNruaU8RhWXzxQwal+ON23Tdc/JBHLSqMl
	 NdHKCFi5HoNg0fWKVaQyS1yb7Qw0l1SEdXJLd1to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391516AbfAKOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391494AbfAKOrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:47:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14401206B6;
        Fri, 11 Jan 2019 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547218061;
        bh=y7IJsGFBHSlochemvbOG0/WN9PTQpMs5W2tXeui6gk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkLt4CCQL2II8Q1ypJZQHMjxTY3FdpPC/4fz+9zMduoAj7KOx9tYYvQ4rM97RSWTC
         yP5PrtSFwQ/hSxntsinmNup+T/fgT20gVNfJhmAbafO0x6fgZLzuugfbmb7wL3kpGa
         kOuqZSeabnRZF1l2Wl/jHUn7h1yoXBnTBOE2xKq8=
Date:   Fri, 11 Jan 2019 15:33:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>
Subject: Re: [PATCH 4.4 88/88] vhost/vsock: fix uninitialized
 vhost_vsock->guest_cid
Message-ID: <20190111143328.GA8325@kroah.com>
References: <20190111131045.137499039@linuxfoundation.org>
 <20190111131100.174148460@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111131100.174148460@linuxfoundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:08:57PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> commit a72b69dc083a931422cc8a5e33841aff7d5312f2 upstream.

Sorry, this patch got stuck at the bottom of the stack as it didn't
apply and i forgot to delete it.  It's not going to be part of the 4.4
tree.

thanks,

greg k-h
