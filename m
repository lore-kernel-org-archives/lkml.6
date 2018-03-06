Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeCFNbT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:31:19 -0500
Received: from ozlabs.org ([103.22.144.67]:58245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753530AbeCFNbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:31:18 -0500
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 326691ad4f179e6edc7eb1271e618dd673e4736d
In-Reply-To: <455276187b369bf019e91715b7488e86cd932d49.1519305410.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
        aneesh.kumar@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v5,1/6] powerpc/mm/slice: Remove intermediate bitmap copy
Message-Id: <3zwd2r4F6mz9sgl@ozlabs.org>
Date: Wed,  7 Mar 2018 00:31:16 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-22 at 14:27:20 UTC, Christophe Leroy wrote:
> bitmap_or() and bitmap_andnot() can work properly with dst identical
> to src1 or src2. There is no need of an intermediate result bitmap
> that is copied back to dst in a second step.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/326691ad4f179e6edc7eb1271e618d

cheers
