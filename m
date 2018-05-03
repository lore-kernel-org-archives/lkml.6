Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeECQsz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:48:55 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49276 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeECQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:48:52 -0400
Date: Thu, 03 May 2018 12:48:47 -0400 (EDT)
Message-Id: <20180503.124847.1815876480542537219.davem@davemloft.net>
To: mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, dan.carpenter@oracle.com,
        daniel@iogearbox.net, peterz@infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bpf: fix possible spectre-v1 in find_and_alloc_map()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180503160459.4111-1-mark.rutland@arm.com>
References: <20180503160459.4111-1-mark.rutland@arm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>
Date: Thu,  3 May 2018 17:04:59 +0100

> It's possible for userspace to control attr->map_type. Sanitize it when
> using it as an array index to prevent an out-of-bounds value being used
> under speculation.
> 
> Found by smatch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
