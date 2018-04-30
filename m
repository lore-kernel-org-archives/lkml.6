Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbeD3UKF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:10:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36220 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754555AbeD3UKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:10:01 -0400
Date: Mon, 30 Apr 2018 16:10:00 -0400 (EDT)
Message-Id: <20180430.161000.699679324055043425.davem@davemloft.net>
To: arvind.yadav.cs@gmail.com
Cc: shannon.nelson@oracle.com, jag.raman@oracle.com,
        liam.merwick@oracle.com, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: vio: use put_device() instead of kfree()
From: David Miller <davem@davemloft.net>
In-Reply-To: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
References: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 25 Apr 2018 20:26:14 +0530

> Never directly free @dev after calling device_register(), even
> if it returned an error. Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied and queued up for -stable, thanks.
