Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeENA2K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:28:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51554 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeENA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:28:09 -0400
Date: Sun, 13 May 2018 20:28:07 -0400 (EDT)
Message-Id: <20180513.202807.2121809995463690066.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: ipconfig: fix unused variable
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180513194830.29946-1-anders.roxell@linaro.org>
References: <20180513194830.29946-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E0SGs3031866

From: Anders Roxell <anders.roxell@linaro.org>
Date: Sun, 13 May 2018 21:48:30 +0200

> When CONFIG_PROC_FS isn't set, variable ipconfig_dir isn't used.
> net/ipv4/ipconfig.c:167:31: warning: ¡ipconfig_dir¢ defined but not used [-Wunused-variable]
>  static struct proc_dir_entry *ipconfig_dir;
>                                ^~~~~~~~~~~~
> Move the declaration of ipconfig_dir inside the CONFIG_PROC_FS ifdef to
> fix the warning.
> 
> Fixes: c04d2cb2009f ("ipconfig: Write NTP server IPs to /proc/net/ipconfig/ntp_servers")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied.
