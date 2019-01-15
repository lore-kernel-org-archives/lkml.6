Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E497C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0752086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbfAOV3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:29:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57340 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAOV33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:29:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3FD25148F8667;
        Tue, 15 Jan 2019 13:29:29 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:29:28 -0800 (PST)
Message-Id: <20190115.132928.900198180655535613.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     deepa.kernel@gmail.com, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org
Subject: Re: [PATCH] input_event: Provide override for sparc64
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAK8P3a1YG0+iMBiNy-g7KCusX3myV0tsuCEg1YLWW0cXrjk7PA@mail.gmail.com>
References: <20181229183514.24644-1-deepa.kernel@gmail.com>
        <CAK8P3a1YG0+iMBiNy-g7KCusX3myV0tsuCEg1YLWW0cXrjk7PA@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Jan 2019 13:29:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 22:19:27 +0100

> The correct check appears to be
> 
> #if defined(__sparc__) && defined(__arch64__)

That is correct.
