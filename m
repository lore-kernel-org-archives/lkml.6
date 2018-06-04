Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbeFDOPX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:15:23 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeFDOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:15:21 -0400
Date: Mon, 04 Jun 2018 10:15:19 -0400 (EDT)
Message-Id: <20180604.101519.1313033740038335042.davem@davemloft.net>
To: rvarsha016@gmail.com
Cc: tariqt@mellanox.com, der.herr@hofr.at, lukas.bulwahn@gmail.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: mlx4: Remove unnecessary parentheses
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180601020049.3704-1-rvarsha016@gmail.com>
References: <20180601020049.3704-1-rvarsha016@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varsha Rao <rvarsha016@gmail.com>
Date: Fri,  1 Jun 2018 07:30:49 +0530

> This patch fixes the clang warning of extraneous parentheses, with the
> following coccinelle script.
 ...
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>

Applied to net-next, thanks.
