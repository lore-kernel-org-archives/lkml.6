Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeFDORq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:17:46 -0400
Received: from ozlabs.org ([203.11.71.1]:39217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753210AbeFDOKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:37 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 169f438a7e369226a452e0ac4a54dbdf85e31943
In-Reply-To: <20180417123646.066056C09D@po15720vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/boot: remove unused variable in mpc8xx
Message-Id: <40zxff260Sz9s1w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 12:36:45 UTC, Christophe Leroy wrote:
> Variable div is set but never used. Remove it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/169f438a7e369226a452e0ac4a54db

cheers
