Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD242C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE7F240E3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE7F240E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbeGEHD2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:03:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40256 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeGEHD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:03:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C64F9207D4; Thu,  5 Jul 2018 09:03:24 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8952E207AB;
        Thu,  5 Jul 2018 09:03:14 +0200 (CEST)
Date:   Thu, 5 Jul 2018 09:03:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Peter Pan <peterpandong@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Use 2-factor allocator calls
Message-ID: <20180705090312.1ca9ed5a@xps13>
In-Reply-To: <20180704172759.GA33591@beast>
References: <20180704172759.GA33591@beast>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Kees Cook <keescook@chromium.org> wrote on Wed, 4 Jul 2018 10:27:59
-0700:

> As already done treewide, switch from open-coded multiplication to using
> 2-factor allocator helpers.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Indeed, we'll be more careful about this in the future.

As this code has not been merged upstream yet, do you mind if I
squash this with the initial patch?

Thanks,
Miquèl
