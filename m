Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A3BC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AD82070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBVPz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:55:29 -0500
Received: from ms.lwn.net ([45.79.88.28]:52630 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfBVPz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:55:28 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2E49635A;
        Fri, 22 Feb 2019 15:55:28 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:55:27 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     efremov <efremov@ispras.ru>, James Morris <jmorris@namei.org>,
        linux-doc@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc: security: Add kern-doc for lsm_hooks.h
Message-ID: <20190222085527.17eabf78@lwn.net>
In-Reply-To: <20190217221901.GA41920@beast>
References: <20190217221901.GA41920@beast>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 14:19:01 -0800
Kees Cook <keescook@chromium.org> wrote:

> There is a lot of kern-doc for the LSM internals, but it wasn't visible
> in the HTML output. This exposes some formatting flaws in lsm_hooks.h
> that will be fixed in a later series of patches.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks.  That does add to our already overwhelming pile of
warnings, hopefully that later series is showing up soon :)

jon
