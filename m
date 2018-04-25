Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbeDYSNP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:15 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53286 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbeDYSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:44 -0400
Date: Wed, 25 Apr 2018 14:12:42 -0400 (EDT)
Message-Id: <20180425.141242.356107204003495124.davem@davemloft.net>
To: colin.king@canonical.com
Cc: johannes.berg@intel.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mkiss: remove redundant check for len > 0
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180425104307.8310-1-colin.king@canonical.com>
References: <20180425104307.8310-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 25 Apr 2018 11:43:07 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for len > 0 is always true and hence is redundant as
> this check is already being made to execute the code inside the
> while-loop. Hence it is redundant and can be removed.
> 
> Cleans up cppcheck warning:
> drivers/net/hamradio/mkiss.c:220: (warning) Identical inner 'if'
> condition is always true.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
