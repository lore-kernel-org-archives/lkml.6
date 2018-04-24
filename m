Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbeDXBDF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:03:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56362 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932662AbeDXBDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:03:04 -0400
Date: Mon, 23 Apr 2018 21:03:02 -0400 (EDT)
Message-Id: <20180423.210302.2026905592349874072.davem@davemloft.net>
To: colin.king@canonical.com
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dca: make function dca_common_get_tag static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180423124938.26070-1-colin.king@canonical.com>
References: <20180423124938.26070-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 23 Apr 2018 13:49:38 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Function dca_common_get_tag is local to the source and does not need to be
> in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/dca/dca-core.c:273:4: warning: symbol 'dca_common_get_tag' was
> not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thanks.
