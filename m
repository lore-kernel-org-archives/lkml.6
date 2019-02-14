Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8554121928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394226AbfBNQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:52:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56298 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfBNQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:52:08 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8FCD714D5DF04;
        Thu, 14 Feb 2019 08:52:07 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:52:06 -0800 (PST)
Message-Id: <20190214.085206.584880889681100869.davem@davemloft.net>
To:     deepa.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        willemb@google.com, tglx@linutronix.de, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: Re: [PATCH net-next 0/2] uapi: Add a new header for time types
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190213032604.2655-1-deepa.kernel@gmail.com>
References: <20190213032604.2655-1-deepa.kernel@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 08:52:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 12 Feb 2019 19:26:02 -0800

> The series aims at adding a new time header: time_types.h.  This header
> is what will eventually hold all the uapi time types that we plan to
> leave across the interfaces after the y2038 cleanup.
> 
> The series was discussed with Arnd Bergmann.
> 
> The second patch fixes the errqueue.h header, which has a dependency on
> these types.
> 
> Note that there may be a trivial merge conflict with linux-next
> c70a772fda11 ("y2038: remove struct definition redirects").

Series applied, thank you.
