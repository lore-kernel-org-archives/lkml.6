Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935838AbeCHLoN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:44:13 -0500
Received: from ozlabs.org ([103.22.144.67]:41963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934653AbeCHLoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:44:12 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 21/21] powerpc: Add missing prototypes in setup_32.c
In-Reply-To: <20180225172236.29650-22-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-22-malat@debian.org>
Date: Thu, 08 Mar 2018 22:44:06 +1100
Message-ID: <876066eqrd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:

> This commit add the prototypes for the following function:
>
> - early_init
> - machine_init

I'd rather these were in asm-prototypes.h, it's the header for functions
called from asm. I made that change.

> - ppc_setup_l2cr
> - ppc_setup_l3cr
> - ppc_init

These three can just be static. So I did that.

cheers
