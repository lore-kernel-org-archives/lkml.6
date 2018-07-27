Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBFB20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBFB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeG0FsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:48:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52180 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeG0FsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:48:19 -0400
Received: from localhost (unknown [172.58.35.173])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A49A0108C58BE;
        Thu, 26 Jul 2018 21:28:20 -0700 (PDT)
Date:   Thu, 26 Jul 2018 21:28:19 -0700 (PDT)
Message-Id: <20180726.212819.1429702751152237424.davem@davemloft.net>
To:     me@tobin.cc
Cc:     corbet@lwn.net, ecree@solarflare.com, ast@kernel.org,
        daniel@iogearbox.net, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] docs: net: Convert netdev-FAQ to RST
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180726050031.1697-1-me@tobin.cc>
References: <20180726050031.1697-1-me@tobin.cc>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 21:28:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <me@tobin.cc>
Date: Thu, 26 Jul 2018 15:00:28 +1000

> Jon answered all the tree questions on v1 so if you will please take
> this through your tree that would be awesome.
> 
> v2:
>  - Fix typo 'canonical_path_format' (thanks Edward) 
>  - Add patch fixing references netdev-FAQ

Series applied.

