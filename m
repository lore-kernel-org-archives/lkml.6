Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeFDOKl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:10:41 -0400
Received: from ozlabs.org ([203.11.71.1]:59593 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753554AbeFDOKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:39 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d04f11d2713e736a3740361f8b5bb42c7147c5a2
In-Reply-To: <20180417124735.8991D6C0AC@po15720vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vitaly Bordug <vitb@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: Remove RTC clock on 88x
Message-Id: <40zxfj041Gz9ryk@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 12:47:35 UTC, Christophe Leroy wrote:
> The 885 familly processors don't have the Real Time Clock
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d04f11d2713e736a3740361f8b5bb4

cheers
