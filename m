Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA29C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5714D2064D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5714D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeIJBiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 21:38:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:38288 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbeIJBiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 21:38:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6101D6D9;
        Sun,  9 Sep 2018 20:47:13 +0000 (UTC)
Date:   Sun, 9 Sep 2018 14:47:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Grant Likely <grant.likely@arm.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, olof@lixom.net,
        scott.branden@broadcom.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, leif.lindholm@linaro.org,
        agraf@suse.de, nd@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH RESEND] efi_stub: update documentation on dtb= parameter
Message-ID: <20180909144711.12261570@lwn.net>
In-Reply-To: <20180906182927.22318-1-grant.likely@arm.com>
References: <20180906182927.22318-1-grant.likely@arm.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Sep 2018 19:29:27 +0100
Grant Likely <grant.likely@arm.com> wrote:

> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.
> 
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Reviewed-by: Alexander Graf <agraf@suse.de>
> Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied, thanks.

jon
