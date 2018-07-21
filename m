Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB807ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607D12084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607D12084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeGUHgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:36:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60426 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeGUHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:36:51 -0400
Received: from localhost (unknown [172.58.43.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1CF1C11AEC845;
        Fri, 20 Jul 2018 23:45:15 -0700 (PDT)
Date:   Fri, 20 Jul 2018 23:45:13 -0700 (PDT)
Message-Id: <20180720.234513.1918064468930334448.davem@davemloft.net>
To:     tyhicks@canonical.com
Cc:     gregkh@linuxfoundation.org, tj@kernel.org,
        stephen@networkplumber.org, dmitry.torokhov@gmail.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH net-next v3 0/8] Make /sys/class/net per net namespace
 objects belong to container
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 20 Jul 2018 23:45:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 20 Jul 2018 21:56:46 +0000

> This is a revival of an older patch set from Dmitry Torokhov:
> 
>  https://lore.kernel.org/lkml/1471386795-32918-1-git-send-email-dmitry.torokhov@gmail.com/
> 
> My submission of v2 is here:
> 
>  https://lore.kernel.org/lkml/1531497949-1766-1-git-send-email-tyhicks@canonical.com/
> 
> Here's Dmitry's description:
 ...
> * Changes since v2:
 ...

Series applied, let's see how the build goes this time :-)
