Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeEaT7g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:59:36 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34052 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753983AbeEaT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:59:31 -0400
Date: Thu, 31 May 2018 15:59:30 -0400 (EDT)
Message-Id: <20180531.155930.1197591227145779002.davem@davemloft.net>
To: sam@mendozajonas.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH net] net/ncsi: Fix array size in dumpit handler
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180531041004.20172-1-sam@mendozajonas.com>
References: <20180531041004.20172-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Thu, 31 May 2018 14:10:04 +1000

> With CONFIG_CC_STACKPROTECTOR enabled the kernel panics as below when
> parsing a NCSI_CMD_PKG_INFO command:
 ...
> This turns out to be because the attrs array in ncsi_pkg_info_all_nl()
> is initialised to a length of NCSI_ATTR_MAX which is the maximum
> attribute number, not the number of attributes.
> 
> Fixes: 955dc68cb9b2 ("net/ncsi: Add generic netlink family")
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Applied, thanks.
