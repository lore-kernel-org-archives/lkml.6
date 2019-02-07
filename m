Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DE7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67966207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBGAZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:25:57 -0500
Received: from ms.lwn.net ([45.79.88.28]:35606 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfBGAZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:25:56 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D5C419AE;
        Thu,  7 Feb 2019 00:25:55 +0000 (UTC)
Date:   Wed, 6 Feb 2019 17:25:54 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, marc.zyngier@arm.com, suzuki.poulose@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, steven.price@arm.com,
        stefan.wahren@i2se.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/12] Documentation: Document arm64 kpti control
Message-ID: <20190206172554.45a8950d@lwn.net>
In-Reply-To: <20190125180711.1970973-2-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
        <20190125180711.1970973-2-jeremy.linton@arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:07:00 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

> For a while Arm64 has been capable of force enabling
> or disabling the kpti mitigations. Lets make sure the
> documentation reflects that.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

I've applied this, thanks.

jon
