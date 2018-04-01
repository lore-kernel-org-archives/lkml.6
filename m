Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeDAC2m (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 22:28:42 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49800 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbeDAC2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 22:28:39 -0400
Date: Sat, 31 Mar 2018 22:28:38 -0400 (EDT)
Message-Id: <20180331.222838.1838996238973593949.davem@davemloft.net>
To: haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc: netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hv_netvsc: Clean up extra parameter from
 rndis_filter_receive_data()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180330205759.31055-1-haiyangz@linuxonhyperv.com>
References: <20180330205759.31055-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Fri, 30 Mar 2018 13:57:59 -0700

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The variables, msg and data, have the same value. This patch removes
> the extra one.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied.
