Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC4EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322332175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfBEP7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:59:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbfBEP7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:59:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEE853D09;
        Tue,  5 Feb 2019 15:59:35 +0000 (UTC)
Received: from treble (ovpn-119-156.phx2.redhat.com [10.3.119.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C42CA19743;
        Tue,  5 Feb 2019 15:59:34 +0000 (UTC)
Date:   Tue, 5 Feb 2019 09:59:33 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alice Ferrazzi <alicef@alicef.me>
Cc:     jeyu@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of ENOSYS
Message-ID: <20190205155933.r6ey474lq4m5nlmp@treble>
References: <20190204183324.30775-1-alicef@alicef.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204183324.30775-1-alicef@alicef.me>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 05 Feb 2019 15:59:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> 
> As a result of an unsupported operation is better to use EOPNOTSUPP
> as error code.
> ENOSYS is only used for 'invalid syscall nr' and nothing else.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
