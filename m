Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D5FC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305BD213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305BD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeK3GXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:23:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60662 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeK3GXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:23:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A259B14F0D007;
        Thu, 29 Nov 2018 11:16:51 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:16:50 -0800 (PST)
Message-Id: <20181129.111650.1439505511260881528.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, khilman@kernel.org,
        nicolas.ferre@microchip.com, grygorii.strashko@ti.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, bgolaszewski@baylibre.com,
        nsekhar@ti.com
Subject: Re: [PATCH v2 10/25] net: ethernet: provide nvmem_get_mac_address()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAMRc=MdLSVw11hzzqPLfSyz38uA46+LvobGk3vSNcTvtqnD5XQ@mail.gmail.com>
References: <20181113140133.17385-1-brgl@bgdev.pl>
        <20181113140133.17385-11-brgl@bgdev.pl>
        <CAMRc=MdLSVw11hzzqPLfSyz38uA46+LvobGk3vSNcTvtqnD5XQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Nov 2018 11:16:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 29 Nov 2018 17:45:51 +0100

> If there are no objections - can patches 10-13 go into the networking
> tree already so that they spend some time in next before the merge
> window?

Please submit them as a separate series, clearly targetted at the
net-next tree.
