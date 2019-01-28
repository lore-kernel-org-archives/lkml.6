Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C9AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6D620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfA1HCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfA1HCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:02:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3670750DA;
        Mon, 28 Jan 2019 07:02:33 +0000 (UTC)
Received: from localhost (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 911802C7C7;
        Mon, 28 Jan 2019 07:02:31 +0000 (UTC)
Date:   Sun, 27 Jan 2019 23:02:30 -0800 (PST)
Message-Id: <20190127.230230.1714077181886353522.davem@redhat.com>
To:     lipeng321@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com
Subject: Re: [PATCH net 0/3] net: hns: code optimizations & bugfixes for
 HNS driver
From:   David Miller <davem@redhat.com>
In-Reply-To: <1548494307-63594-1-git-send-email-lipeng321@huawei.com>
References: <1548494307-63594-1-git-send-email-lipeng321@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 28 Jan 2019 07:02:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>
Date: Sat, 26 Jan 2019 17:18:24 +0800

> This patchset includes bugfixes and code optimizations for the HNS
> ethernet controller driver

Series applied, thank you.

There are only bug fixes in here, so please do not use the word
"optimizations" in such situations.

Thanks.
