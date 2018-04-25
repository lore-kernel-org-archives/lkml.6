Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756079AbeDYSef (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:34:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53600 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeDYSec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:34:32 -0400
Date: Wed, 25 Apr 2018 14:34:30 -0400 (EDT)
Message-Id: <20180425.143430.191813743469618503.davem@davemloft.net>
To: dag.moxnes@oracle.com
Cc: santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rds: ib: Fix missing call to rds_ib_dev_put in
 rds_ib_setup_qp
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524655321-8379-1-git-send-email-dag.moxnes@oracle.com>
References: <1524655321-8379-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dag Moxnes <dag.moxnes@oracle.com>
Date: Wed, 25 Apr 2018 13:22:01 +0200

> The function rds_ib_setup_qp is calling rds_ib_get_client_data and
> should correspondingly call rds_ib_dev_put. This call was lost in
> the non-error path with the introduction of error handling done in
> commit 3b12f73a5c29 ("rds: ib: add error handle")
> 
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>

Applied, thanks.
