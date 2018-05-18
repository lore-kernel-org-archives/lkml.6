Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeERR3G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:29:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47866 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:29:02 -0400
Date: Fri, 18 May 2018 13:28:59 -0400 (EDT)
Message-Id: <20180518.132859.878679075850615015.davem@davemloft.net>
To: fengguang.wu@intel.com
Cc: ycheng@google.com, kbuild-all@01.org, netdev@vger.kernel.org,
        ncardwell@google.com, edumazet@google.com, soheil@google.com,
        priyarjha@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] tcp: tcp_rack_reo_wnd() can be static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180518051423.GA41595@lkp-ivb-ep02>
References: <201805181300.JN7KwXNm%fengguang.wu@intel.com>
        <20180518051423.GA41595@lkp-ivb-ep02>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 18 May 2018 13:14:23 +0800

> Fixes: 20b654dfe1be ("tcp: support DUPACK threshold in RACK")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Looks good, applied, thanks!
