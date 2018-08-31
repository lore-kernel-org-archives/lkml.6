Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35477C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23FC2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23FC2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeIACrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:47:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:33962 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbeIACrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:47:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 941CE2B0;
        Fri, 31 Aug 2018 22:37:30 +0000 (UTC)
Date:   Fri, 31 Aug 2018 16:37:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, linux-doc@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] Documentation/l1tf: Fix small spelling typo
Message-ID: <20180831163717.3729f5d2@lwn.net>
In-Reply-To: <20180815054604.27895-1-carnil@debian.org>
References: <20180815054604.27895-1-carnil@debian.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 07:46:04 +0200
Salvatore Bonaccorso <carnil@debian.org> wrote:

> Fix small typo (wiil -> will) in the "3.4. Nested virtual machines"
> section.
> 
> Fixes: 5b76a3cff011 ("KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry")
> Cc: linux-kernel@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-doc@vger.kernel.org
> Cc: trivial@kernel.org
> 
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Applied, thanks.

jon
