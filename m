Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6092C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94881208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbfACQWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:22:10 -0500
Received: from ms.lwn.net ([45.79.88.28]:57114 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfACQWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:22:10 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B16647DC;
        Thu,  3 Jan 2019 16:22:09 +0000 (UTC)
Date:   Thu, 3 Jan 2019 09:22:08 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     <akpm@linux-foundation.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: rename addr_in_gen_pool to
 gen_pool_has_addr
Message-ID: <20190103092208.6c502bf8@lwn.net>
In-Reply-To: <20181229015914.5573-1-sjhuang@iluvatar.ai>
References: <20181229015914.5573-1-sjhuang@iluvatar.ai>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018 09:59:14 +0800
Huang Shijie <sjhuang@iluvatar.ai> wrote:

> Update the document, since we have renamed addr_in_gen_pool to
> gen_pool_has_addr.
> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>

So I was looking to apply this, but I don't see anywhere in mainline or
-next where this change has been made...?

Thanks,

jon
