Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF68EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BD521928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394686AbfBNR1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:27:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391592AbfBNR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:27:47 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 09A1814D5ECF1;
        Thu, 14 Feb 2019 09:27:46 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:27:45 -0800 (PST)
Message-Id: <20190214.092745.1269597872257289142.davem@davemloft.net>
To:     huang.zijiang@zte.com.cn
Cc:     quentin.monnet@netronome.com, jakub.kicinski@netronome.com,
        henrik@austad.us, dsahern@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn
Subject: Re: [PATCH] net:dl2k: Modify the code style escaping the warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1550126431-28152-1-git-send-email-huang.zijiang@zte.com.cn>
References: <1550126431-28152-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 09:27:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>
Date: Thu, 14 Feb 2019 14:40:31 +0800

> modify the code style in order to removing the following warning
> when excute the script checkpatch.pl
> WARNING: space prohibited between function name and open parenthesis '('
> 
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>

Applied.
