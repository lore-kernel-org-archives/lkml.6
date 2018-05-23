Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbeEWSuf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:50:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33288 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:50:30 -0400
Date: Wed, 23 May 2018 14:50:29 -0400 (EDT)
Message-Id: <20180523.145029.1858332695324159064.davem@davemloft.net>
To: colin.king@canonical.com
Cc: jdmason@kudzu.us, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] net: vxge: fix spelling mistake in macro
 VXGE_HW_ERR_PRIVILAGED_OPEARATION
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522161809.30299-1-colin.king@canonical.com>
References: <20180522161809.30299-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 22 May 2018 17:18:09 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Rename VXGE_HW_ERR_PRIVILAGED_OPEARATION to VXGE_HW_ERR_PRIVILEGED_OPERATION
> to fix spelling mistake.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> V2: PRIVILAGED -> PRIVILEGED, thanks to Edward Cree for spotting that mistake

Applied to net-next, thanks Colin.
