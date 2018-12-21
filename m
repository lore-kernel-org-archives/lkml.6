Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46789C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ADA218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeLUFH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 00:07:58 -0500
Received: from ozlabs.org ([203.11.71.1]:56131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbeLUFH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 00:07:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Lc8C5vtYz9s9G;
        Fri, 21 Dec 2018 16:07:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 04/11] powerpc/mm: Add a framework for Kernel Userspace Access Protection
In-Reply-To: <df38a42e7c3cce892d7f6bbd88b5388774c8bef0.1543356926.git.christophe.leroy@c-s.fr>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr> <df38a42e7c3cce892d7f6bbd88b5388774c8bef0.1543356926.git.christophe.leroy@c-s.fr>
Date:   Fri, 21 Dec 2018 16:07:53 +1100
Message-ID: <87sgyrpivq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch implements a framework for Kernel Userspace Access
> Protection.
>
> Then subarches will have to possibility to provide their own
> implementation by providing setup_kuap() and lock/unlock_user_access()
>
> Some platform will need to know the area accessed and whether it is
> accessed from read, write or both. Therefore source, destination and
> size and handed over to the two functions.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I think some of this code came from Russell's original patch?

In which case we should have his signed-off-by here.

cheers
