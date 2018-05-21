Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeEUKEA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:04:00 -0400
Received: from ozlabs.org ([203.11.71.1]:37609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbeEUKB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:01:27 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 24c78586cc6798028205e12c34febf0337bcbded
In-Reply-To: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2,1/2] powerpc: avoid an unnecessary test and branch in longjmp()
Message-Id: <40qDnb1lR5z9s3T@ozlabs.org>
Date: Mon, 21 May 2018 20:01:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 17:08:16 UTC, Christophe Leroy wrote:
> Doing the test at exit of the function avoids an unnecessary
> test and branch inside longjmp()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/24c78586cc6798028205e12c34febf

cheers
