Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbeEHDab (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:30:31 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbeEHDaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:30:30 -0400
Date: Mon, 07 May 2018 23:30:28 -0400 (EDT)
Message-Id: <20180507.233028.1636992030271398967.davem@davemloft.net>
To: mdf@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alex.williams@ni.com
Subject: Re: [PATCH 1/2] net: nixge: Fix error path for obtaining mac
 address
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504171834.9365-1-mdf@kernel.org>
References: <20180504171834.9365-1-mdf@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>
Date: Fri,  4 May 2018 10:18:33 -0700

> Fix issue where nixge_get_nvmem_address() returns a non-NULL
> return value on a failed nvmem_cell_get() that causes an invalid
> access when error value encoded in pointer is dereferenced.
> 
> Furthermore ensure that buffer allocated by nvmem_cell_read()
> actually gets kfreed() if the function succeeds.
> 
> Fixes commit 492caffa8a1a ("net: ethernet: nixge: Add support for
> National Instruments XGE netdev")
> Reported-by: Alex Williams <alex.williams@ni.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Applied.
