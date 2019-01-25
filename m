Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F76218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfAYGp5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:45:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38364 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfAYGp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:45:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EEF7C1457E2E0;
        Thu, 24 Jan 2019 22:45:55 -0800 (PST)
Date:   Thu, 24 Jan 2019 22:45:55 -0800 (PST)
Message-Id: <20190124.224555.2284689796797377764.davem@davemloft.net>
To:     zenczykowski@gmail.com
Cc:     maze@google.com, ast@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190124110702.140834-1-zenczykowski@gmail.com>
References: <20190124110702.140834-1-zenczykowski@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Jan 2019 22:45:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej ¯enczykowski <zenczykowski@gmail.com>
Date: Thu, 24 Jan 2019 03:07:02 -0800

> From: Maciej ¯enczykowski <maze@google.com>
> 
> __bpf_redirect() and act_mirred checks this boolean
> to determine whether to prefix an ethernet header.
> 
> Signed-off-by: Maciej ¯enczykowski <maze@google.com>

Applied.
