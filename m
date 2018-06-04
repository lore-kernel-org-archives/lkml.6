Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeFDOPn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:15:43 -0400
Received: from ozlabs.org ([203.11.71.1]:43855 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753443AbeFDOKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:40 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6e8cef384a41882b2d4ec6992dd0d74246b3f353
In-Reply-To: <20180423083642.2608886-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: arnd@arndb.de, y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/5] powerpc: always enable RTC_LIB
Message-Id: <40zxfk06KTz9s1B@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:37 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-23 at 08:36:38 UTC, Arnd Bergmann wrote:
> In order to use the rtc_tm_to_time64() and rtc_time64_to_tm()
> helper functions in later patches, we have to ensure that
> CONFIG_RTC_LIB is always built-in.
> 
> Note that this symbol only controls a couple of helper functions,
> not the actual RTC subsystem, which remains optional and is
> enabled with CONFIG_RTC_CLASS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6e8cef384a41882b2d4ec6992dd0d7

cheers
