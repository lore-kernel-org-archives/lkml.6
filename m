Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeDMBre (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:47:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60370 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeDMBrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:47:33 -0400
Date: Thu, 12 Apr 2018 21:47:30 -0400 (EDT)
Message-Id: <20180412.214730.1475763618210761319.davem@davemloft.net>
To: keescook@chromium.org
Cc: davejwatson@fb.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ilyal@mellanox.com, aviadye@mellanox.com
Subject: Re: [PATCH] net/tls: Remove VLA usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180411005234.GA39848@beast>
References: <20180411005234.GA39848@beast>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Tue, 10 Apr 2018 17:52:34 -0700

> In the quest to remove VLAs from the kernel[1], this replaces the VLA
> size with the only possible size used in the code, and adds a mechanism
> to double-check future IV sizes.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
