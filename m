Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B64CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311892085A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAHAg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:36:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAHAg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:36:28 -0500
Received: from localhost (50-203-107-150-static.hfc.comcastbusiness.net [50.203.107.150])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8F29514C72D26;
        Mon,  7 Jan 2019 16:36:27 -0800 (PST)
Date:   Mon, 07 Jan 2019 16:36:26 -0800 (PST)
Message-Id: <20190107.163626.191499249014206114.davem@davemloft.net>
To:     sudipm.mukherjee@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH 4.14 002/101] net: core: Fix Spectre v1 vulnerability
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CADVatmOxZngMs8foHj0mOTjC5NhAZvZyxRJXREkEsKvG-6z6Ug@mail.gmail.com>
References: <20190107105330.372621917@linuxfoundation.org>
        <20190107105330.528127680@linuxfoundation.org>
        <CADVatmOxZngMs8foHj0mOTjC5NhAZvZyxRJXREkEsKvG-6z6Ug@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 07 Jan 2019 16:36:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 7 Jan 2019 21:13:06 +0000

> Hi Greg,
> 
> On Mon, Jan 7, 2019 at 1:00 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>>
>> [ Upstream commit 50d5258634aee2e62832aa086d2fb0de00e72b91 ]
> 
> This has been reverted upstream by f2ab95814103 ("net: Revert recent
> Spectre-v1 patches.")

Greg please drop this too.

Thanks Sudip for spotting this.
