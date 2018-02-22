Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeBVQk3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:40:29 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43313 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933164AbeBVQk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:40:27 -0500
X-Google-Smtp-Source: AH8x227cztnmiee3N6waGy56Z2nxfRGmQbmpsdcJ2HqZ16Yfq9fLHS1BZcfP2ZxvI1/2nVk5IXYq4g==
Message-ID: <1519317625.55655.58.camel@gmail.com>
Subject: Re: [PATCH] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2018 08:40:25 -0800
In-Reply-To: <20180222155546.1747665-1-arnd@arndb.de>
References: <20180222155546.1747665-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-22 at 16:55 +0100, Arnd Bergmann wrote:

... 
> 
> This code is old, so Cc stable to make sure that we don't get the warning
> for older kernels built with new gcc.
> 
> Cc: stable@vger.kernel.org


This part makes little sense to me for two reasons.

1) David Miller handles stable submission himself
 ( Documentation/networking/netdev-FAQ.txt )

2) We are not supposed to make sure old kernels will compile with
future compilers.

That would need a lot of work and potential new bugs, not worth the
time.

Otherwise your patch looks fine really ;)
