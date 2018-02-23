Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeBWQAg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:00:36 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:34120 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeBWQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:00:34 -0500
Date: Fri, 23 Feb 2018 11:00:33 -0500 (EST)
Message-Id: <20180223.110033.2285906542877177119.davem@davemloft.net>
To: arnd@arndb.de
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAK8P3a19TUvOuN_E=3s7SuLd240FYQyYqppAWJeH3ySf=JytiA@mail.gmail.com>
References: <20180222155546.1747665-1-arnd@arndb.de>
        <1519317625.55655.58.camel@gmail.com>
        <CAK8P3a19TUvOuN_E=3s7SuLd240FYQyYqppAWJeH3ySf=JytiA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:56:12 +0100

> I expect to do the same for gcc-8. Most of the fixes are trivial
> anyway, and some of them fix actual bugs that would otherwise get
> missed.

It does make the code easier to understand and you can more directly
see what it's trying to check.

Applied and queued up for -stable, thanks.
