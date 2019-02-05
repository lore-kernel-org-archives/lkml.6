Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED703217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfBEUNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:13:06 -0500
Received: from namei.org ([65.99.196.166]:50332 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfBEUNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:13:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x15KCvsx006253;
        Tue, 5 Feb 2019 20:12:57 GMT
Date:   Wed, 6 Feb 2019 07:12:57 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH v3] selftests: add TPM 2.0 tests
In-Reply-To: <20190204232910.GC14992@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1902060712500.3449@namei.org>
References: <20190204131640.11429-1-jarkko.sakkinen@linux.intel.com> <20190204232910.GC14992@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019, Jarkko Sakkinen wrote:

> On Mon, Feb 04, 2019 at 03:16:40PM +0200, Jarkko Sakkinen wrote:
> > Added the tests that I've been using for testing TPM 2.0 functionality
> > for a long time but have been out-of-tree so far, residing in
> > 
> > https://github.com/jsakkine-intel/tpm2-scripts
> > 
> > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>
> > Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> 
> Wondering if I can put this to my 5.1 PR?

Yep, should be fine.

-- 
James Morris
<jmorris@namei.org>

