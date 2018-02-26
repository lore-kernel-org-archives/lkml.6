Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeBZUJd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:09:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750762AbeBZUJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:09:32 -0500
Date: Mon, 26 Feb 2018 15:09:31 -0500 (EST)
Message-Id: <20180226.150931.1510520972063842669.davem@redhat.com>
To: rfried@codeaurora.org
Cc: kvalo@codeaurora.org, marcel@holtmann.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] qrtr: add MODULE_ALIAS macro to smd
From: David Miller <davem@redhat.com>
In-Reply-To: <20180225074937.1131-1-rfried@codeaurora.org>
References: <20180225074937.1131-1-rfried@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramon Fried <rfried@codeaurora.org>
Date: Sun, 25 Feb 2018 09:49:37 +0200

> Added MODULE_ALIAS("rpmsg:IPCRTR") to ensure qrtr-smd and qrtr will load
> when IPCRTR channel is detected.
> 
> Signed-off-by: Ramon Fried <rfried@codeaurora.org>

Applied, thanks.
