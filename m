Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDDAC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDEB208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDEB208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGHVu7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:50:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38178 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932545AbeGHVu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:50:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CD4F7203B4; Sun,  8 Jul 2018 23:50:55 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 61AF8203B4;
        Sun,  8 Jul 2018 23:50:55 +0200 (CEST)
Date:   Sun, 8 Jul 2018 23:50:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Peter Pan <peterpandong@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Use 2-factor allocator calls
Message-ID: <20180708235055.7fbc7191@xps13>
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

Hi Kees,

Kees Cook <keescook@chromium.org> wrote on Wed, 4 Jul 2018 10:27:59
-0700:

> As already done treewide, switch from open-coded multiplication to using
> 2-factor allocator helpers.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Merged with the original commit.

Thanks,
Miquèl
