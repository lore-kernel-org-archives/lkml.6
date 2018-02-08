Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBHWS1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:18:27 -0500
Received: from ozlabs.org ([103.22.144.67]:43231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:18:25 -0500
Date: Fri, 9 Feb 2018 09:18:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hoang Le <hoang.h.le@dektek.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20180209091822.22a81728@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commit

  55b3280d1e47 ("tipc: fix skb truesize/datasize ratio control")

is missing a Signed-off-by from its author.

-- 
Cheers,
Stephen Rothwell
