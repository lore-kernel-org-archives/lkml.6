Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98419C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C77E2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C77E2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeHTXjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:39:45 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41518 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeHTXjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:39:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 89A8160A0E1A;
        Mon, 20 Aug 2018 22:22:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SBx1xeJYdJ04; Mon, 20 Aug 2018 22:22:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0BE34603B555;
        Mon, 20 Aug 2018 22:22:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3JIXWCXLKT0E; Mon, 20 Aug 2018 22:22:40 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id AE985606B6DE;
        Mon, 20 Aug 2018 22:22:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Liu Song <liu.song11@zte.com.cn>
Cc:     dedekind1@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] mtd/ubi: Make sure to read volume record from LEB 0 or LEB 1
Date:   Mon, 20 Aug 2018 22:21:46 +0200
Message-ID: <1543610.baP53LZD3X@blindfold>
In-Reply-To: <1534745345-175434-1-git-send-email-liu.song11@zte.com.cn>
References: <1534745345-175434-1-git-send-email-liu.song11@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lui Song,

Am Montag, 20. August 2018, 08:09:05 CEST schrieb Liu Song:
> From: fishland <liu.song11@zte.com.cn>

Please use your real name. 1st Signed-off-by and patch author should match.
 
> Even though we protect on-flash data by CRC checksums,
> we still don't trust the media. If lnum is not 0 or 1,
> access exceed array boundary can lead to bad situation.

Good find! I'll queue this for the next fixes-pull-request.

Thanks,
//richard


