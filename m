Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbeFDOKq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:10:46 -0400
Received: from ozlabs.org ([203.11.71.1]:37345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753554AbeFDOKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:42 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 56b04d568f880a48d892e840cfaf4efc0f0ce39b
In-Reply-To: <20180424160425.DB9946C5A7@po15720vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/signal32: Use fault_in_pages_readable() to prefault user context
Message-Id: <40zxfn11K0z9s2t@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 16:04:25 UTC, Christophe Leroy wrote:
> Use fault_in_pages_readable() to prefault user context
> instead of open coding
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/56b04d568f880a48d892e840cfaf4e

cheers
