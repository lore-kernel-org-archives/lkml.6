Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeCVSxK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:53:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59470 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCVSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:53:08 -0400
Date: Thu, 22 Mar 2018 14:53:06 -0400 (EDT)
Message-Id: <20180322.145306.435067580111338677.davem@davemloft.net>
To: colin.king@canonical.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] gre: fix TUNNEL_SEQ bit check on sequence
 numbering
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180321193458.4451-1-colin.king@canonical.com>
References: <20180321193458.4451-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 21 Mar 2018 19:34:58 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The current logic of flags | TUNNEL_SEQ is always non-zero and hence
> sequence numbers are always incremented no matter the setting of the
> TUNNEL_SEQ bit.  Fix this by using & instead of |.
> 
> Detected by CoverityScan, CID#1466039 ("Operands don't affect result")
> 
> Fixes: 77a5196a804e ("gre: add sequence number for collect md mode.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks Colin.
