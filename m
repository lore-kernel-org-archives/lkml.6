Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeCICyS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:54:18 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:46462 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCICyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:54:17 -0500
Date: Thu, 08 Mar 2018 21:54:15 -0500 (EST)
Message-Id: <20180308.215415.619421604203164749.davem@davemloft.net>
To: fengguang.wu@intel.com
Cc: sowmini.varadhan@oracle.com, kbuild-all@01.org,
        santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH linux-next] rds: rds_info_from_znotifier() can be
 static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180308113729.GA89557@cairo>
References: <201803081946.adQaZcK5%fengguang.wu@intel.com>
        <20180308113729.GA89557@cairo>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 8 Mar 2018 19:37:30 +0800

> Fixes: 9426bbc6de99 ("rds: use list structure to track information for zerocopy completion notification")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Applied.
