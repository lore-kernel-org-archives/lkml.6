Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A60E606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933818AbeFFSDM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:03:12 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45490 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeFFSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:03:10 -0400
Date: Wed, 06 Jun 2018 14:03:08 -0400 (EDT)
Message-Id: <20180606.140308.1991453992437348427.davem@davemloft.net>
To: salil.mehta@huawei.com
Cc: yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V2 net-next 0/3] Bug fixes & optimization for HNS3
 Driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180606130753.54428-1-salil.mehta@huawei.com>
References: <20180606130753.54428-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Wed, 6 Jun 2018 14:07:50 +0100

> This patch-set presents miscellaneous bug fixes and an optimization
> for HNS3 driver
> 
> V1->V2:
> 	* Fixes the compilation break reported by David Miller & Kbuild

Series applied, hope this one builds better :)
