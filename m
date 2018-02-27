Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeB0QlC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:41:02 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:58202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeB0QlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:41:00 -0500
Date: Tue, 27 Feb 2018 11:40:59 -0500 (EST)
Message-Id: <20180227.114059.925506085123375763.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v2 0/4] DPAA Ethernet fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180226172404.25584-1-madalin.bucur@nxp.com>
References: <20180226172404.25584-1-madalin.bucur@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Mon, 26 Feb 2018 11:24:00 -0600

> Fixed an issue on the Tx path that was visible in netperf
> TCP_SENDFILE tests. Addressed another issue with Rx errors
> not being always counted. Adding control for allmulti.
> 
> v2: rephrased commit message, reduced changes in the SG mapping fix

Series applied, thank you.
