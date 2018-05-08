Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932803AbeEHOwk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:52:40 -0400
Received: from ozlabs.org ([203.11.71.1]:35193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932375AbeEHOwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:52:39 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 45201c8794693d16e8e634188a92e9c0b075fd91
In-Reply-To: <02633d43f29e1ba01865cd334216dc8efb8b4b11.1524587425.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/3] powerpc/nohash: remove hash related code from nohash headers.
Message-Id: <40gMsd6C19z9s4n@ozlabs.org>
Date: Wed,  9 May 2018 00:52:37 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 16:31:28 UTC, Christophe Leroy wrote:
> When nohash and book3s header were split, some hash related stuff
> remained in the nohash header. This patch removes them.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45201c8794693d16e8e634188a92e9

cheers
