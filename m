Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeCWRSR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:18:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:18:15 -0400
Date: Fri, 23 Mar 2018 13:18:13 -0400 (EDT)
Message-Id: <20180323.131813.62705698826430087.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: Use true and false for boolean values
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180322200849.GA28033@embeddedgus>
References: <20180322200849.GA28033@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 22 Mar 2018 15:08:49 -0500

> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
