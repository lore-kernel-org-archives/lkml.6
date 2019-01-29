Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46276C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5AC218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfA2TwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:52:16 -0500
Received: from namei.org ([65.99.196.166]:48996 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfA2TwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:52:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0TJq1R7030793;
        Tue, 29 Jan 2019 19:52:02 GMT
Date:   Wed, 30 Jan 2019 06:52:01 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     rdunlap@infradead.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: SafeSetID: 'depend' on CONFIG_SECURITY
In-Reply-To: <20190129185424.251139-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1901300651530.30410@namei.org>
References: <CAJ-EccMgDvx81g-XgWymdYn_G5Ou8mgbef3GUbx-C_Ai5qF-pQ@mail.gmail.com> <20190129185424.251139-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, mortonm@chromium.org wrote:

> From: Micah Morton <mortonm@chromium.org>
> 
> This patch changes the Kconfig file for the SafeSetID LSM to depend on
> CONFIG_SECURITY as well as select CONFIG_SECURITYFS, since the policies
> for the LSM are configured through writing to securityfs.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

