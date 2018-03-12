Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbeCLOn1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:43:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59864 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeCLOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:43:25 -0400
Date: Mon, 12 Mar 2018 10:43:23 -0400 (EDT)
Message-Id: <20180312.104323.14368638452528082.davem@davemloft.net>
To: arvind.yadav.cs@gmail.com
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        linyunsheng@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: hns: use put_device() if device_register fail
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa970be78de11dee1a217c9a75ab0850f1780e0c.1520591977.git.arvind.yadav.cs@gmail.com>
References: <fa970be78de11dee1a217c9a75ab0850f1780e0c.1520591977.git.arvind.yadav.cs@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Fri,  9 Mar 2018 16:11:17 +0530

> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

I do not see anything giving cls_dev an initial non-zero reference
count before this device_register() call.

And I have no idea why you use a "!" when saying 'error' you this
commit log message.
