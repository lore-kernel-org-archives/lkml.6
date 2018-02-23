Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeBWRpH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:45:07 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:35536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeBWRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:45:04 -0500
Date: Fri, 23 Feb 2018 12:45:03 -0500 (EST)
Message-Id: <20180223.124503.1376757527638095759.davem@davemloft.net>
To: colin.king@canonical.com
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: idt77252: remove redundant bit-wise or'ing of zero
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180223122252.23942-1-colin.king@canonical.com>
References: <20180223122252.23942-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 23 Feb 2018 12:22:52 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Zero is being bit-wise or'd in a calculation twice; these are redundant
> and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
