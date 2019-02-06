Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45E5218AF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfBFXob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:44:31 -0500
Received: from ms.lwn.net ([45.79.88.28]:35356 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfBFXob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:44:31 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AF54D9AE;
        Wed,  6 Feb 2019 23:44:30 +0000 (UTC)
Date:   Wed, 6 Feb 2019 16:44:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_keys.txt: Fix trivial spelling mistake
Message-ID: <20190206164429.14e81f7d@lwn.net>
In-Reply-To: <20190204084657.24347-1-kamalesh@linux.vnet.ibm.com>
References: <20190204084657.24347-1-kamalesh@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 14:16:57 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> Fix the spelling of 'functionnality' -> 'functionality'.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied, thanks.

jon
