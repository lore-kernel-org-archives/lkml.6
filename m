Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEJTOU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:14:20 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeEJTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:14:19 -0400
Date: Thu, 10 May 2018 15:14:17 -0400 (EDT)
Message-Id: <20180510.151417.577068262684642622.davem@davemloft.net>
To: dave@stgolabs.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/6] net: Update static keys to modern api
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180508160703.8125-1-dave@stgolabs.net>
References: <20180508160703.8125-1-dave@stgolabs.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>
Date: Tue,  8 May 2018 09:06:57 -0700

> The following patches update pretty much all core net static key users
> to the modern api. Changes are mostly trivial conversion without affecting
> any semantics. The motivation is a resend of patches 1 and 2 from a while[1]
> back, and the rest are added patches, specific for -net.
> 
> Applies against today's linux-next. Compile tested only.
> 
> [1] lkml.kernel.org/r/20180326210929.5244-1-dave@stgolabs.net

Series applied, thank you.
