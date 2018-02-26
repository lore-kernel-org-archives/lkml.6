Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeBZTin (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:38:43 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:46158 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeBZTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:38:41 -0500
Date: Mon, 26 Feb 2018 14:38:40 -0500 (EST)
Message-Id: <20180226.143840.1668837839805898633.davem@davemloft.net>
To: dudenis2000@yahoo.ca
Cc: khc@pm.waw.pl, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: carrier detect ok, don't turn off negotiation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519509102-5629-1-git-send-email-dudenis2000@yahoo.ca>
References: <1519509102-5629-1-git-send-email-dudenis2000@yahoo.ca>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Du <dudenis2000@yahoo.ca>
Date: Sat, 24 Feb 2018 16:51:42 -0500

> Sometimes when physical lines have a just good noise to make the protocol
> handshaking fail, but the carrier detect still good. Then after remove of
> the noise, nobody will trigger this protocol to be start again to cause
> the link to never come back. The fix is when the carrier is still on, not
> terminate the protocol handshaking.
> 
> Signed-off-by: Denis Du <dudenis2000@yahoo.ca>

Applied and queued up for -stable, thanks.
