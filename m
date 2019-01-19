Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EDBC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BCC2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfASKlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:41:11 -0500
Received: from ozlabs.org ([203.11.71.1]:38335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfASKlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:41:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43hZ9J2Cwdz9s3l;
        Sat, 19 Jan 2019 21:41:08 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc: chrp: Use of_node_is_type to access device_type
In-Reply-To: <20190118143529.13347-1-robh@kernel.org>
References: <20190118143529.13347-1-robh@kernel.org>
Date:   Sat, 19 Jan 2019 21:41:09 +1100
Message-ID: <87tvi52am2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> Commit 8ce5f8415753 ("of: Remove struct device_node.type pointer")
> removed struct device_node.type pointer, but the conversion to use
> of_node_is_type() accessor was missed in chrp_init_IRQ().
>
> Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Michael, I see you just sent a PR of fixes. I can send this to Linus if 
> you prefer.

Yeah if you're happy to, thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
