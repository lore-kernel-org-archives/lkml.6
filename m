Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54435C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2193120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547564353;
	bh=Q31nVDVyiX5bsmJ0oAh2+b6DwuBOxKnmlpZnhKhxx34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kSOmNgbcj9hggGV+Fs+XdpDcaQiKplAuCPHTqt3H0WuOhx3XZi76E8XcF1+CPlkRb
	 u1N2Jg9Ooo7oCMCX4hm9n3E1mqnmhKpcOFDImXmy7HNiZjx1/QFCaeSIJfbQUhXkGE
	 EouyWZgJJ8PB/nvFSQJImNBVVm2rfJzUgpfwh1tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfAOO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfAOO7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:59:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CE420656;
        Tue, 15 Jan 2019 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547564350;
        bh=Q31nVDVyiX5bsmJ0oAh2+b6DwuBOxKnmlpZnhKhxx34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaQf5zazOzz5vcplxUIRsrOuC4XMozMXfHJzIngysb+ntru53bwpMRXHqgERVxIeu
         15Xwogd1IhDayk+FfZlyR0LZ5mhFUztAs7Yc+qH7gtWj/k88R8L1MuZ6lJ9rehGZkJ
         ep9ch+DvbDZQhdLlXsiQBWs2XOljzkiqrbkjntBw=
Date:   Tue, 15 Jan 2019 15:59:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, devel@driverdev.osuosl.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/android/vsoc: Remove duplicate header
Message-ID: <20190115145907.GA3280@kroah.com>
References: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 08:55:59PM +0530, Brajeswar Ghosh wrote:
> Remove linux/mutex.h.h which is included more than once

I think you have one too many ".h" in that line :)

I'll go fix it up...

