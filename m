Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeCZQNf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:13:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeCZQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:13:34 -0400
Date: Mon, 26 Mar 2018 12:13:32 -0400 (EDT)
Message-Id: <20180326.121332.1704886482841235175.davem@davemloft.net>
To: lipeng321@huawei.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, salil.mehta@huawei.com
Subject: Re: [PATCH net-next 0/5] fix some bugs for HNS3
From: David Miller <davem@davemloft.net>
In-Reply-To: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
References: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>
Date: Sat, 24 Mar 2018 11:32:42 +0800

> This patchset fixes some bugs for HNS3 driver:
> [Patch 1/5 - 2/5] fix 2 return vlaue issues.
> [Patch 3/5 - 4/5] fix 2 comments reported by code review.
> [Ptach 5/5] avoid sending message to IMP because IMP will not
> handle any message when it is resetting.

Series applied, thank you.
