Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3443C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD95217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfBENFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:05:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:35830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfBENFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:05:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43861AFCA;
        Tue,  5 Feb 2019 13:05:42 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:05:41 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Alice Ferrazzi <alicef@alicef.me>
cc:     jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
        pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of
 ENOSYS
In-Reply-To: <20190204183324.30775-1-alicef@alicef.me>
Message-ID: <alpine.LSU.2.21.1902051405160.21608@pobox.suse.cz>
References: <20190204183324.30775-1-alicef@alicef.me>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019, Alice Ferrazzi wrote:

> From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> 
> As a result of an unsupported operation is better to use EOPNOTSUPP
> as error code.
> ENOSYS is only used for 'invalid syscall nr' and nothing else.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
