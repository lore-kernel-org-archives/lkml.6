Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCTPOv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:14:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55614 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:14:48 -0400
Date: Tue, 20 Mar 2018 11:14:46 -0400 (EDT)
Message-Id: <20180320.111446.111954216494768560.davem@davemloft.net>
To: khalid.aziz@oracle.com
Cc: shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com,
        nick.alcock@oracle.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, khalid@gonehiking.org
Subject: Re: [PATCH sparc-next] sparc: Make auxiliary vectors for ADI
 available on 32-bit as well
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180320144602.16535-1-khalid.aziz@oracle.com>
References: <20180320144602.16535-1-khalid.aziz@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 20 Mar 2018 08:46:02 -0600

> Commit c6202ca764ac ("sparc64: Add auxiliary vectors to report
> platform ADI properties") adds auxiliary vectors to report ADI
> capabilities on sparc64 platform only. This needs to be uniform
> across 64-bit and 32-bit. This patch makes the same vectors
> available on 32-bit as well.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>

Applied, thank you.
