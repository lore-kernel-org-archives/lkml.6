Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCLPMz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:12:55 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60186 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeCLPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:12:53 -0400
Date: Mon, 12 Mar 2018 11:12:51 -0400 (EDT)
Message-Id: <20180312.111251.956883878311919021.davem@davemloft.net>
To: colin.king@canonical.com
Cc: santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][rds-next] rds: remove redundant variable 'sg_off'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180311162756.26950-1-colin.king@canonical.com>
References: <20180311162756.26950-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun, 11 Mar 2018 17:27:56 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable sg_off is assigned a value but it is never read, hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> net/rds/message.c:373:2: warning: Value stored to 'sg_off' is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
