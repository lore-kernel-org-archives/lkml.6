Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E12C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D19E2177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfBCW07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 17:26:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:35946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfBCW06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 17:26:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AC4FAC6F;
        Sun,  3 Feb 2019 22:26:57 +0000 (UTC)
Date:   Sun, 3 Feb 2019 23:26:55 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] selftests: add TPM 2.0 tests
Message-ID: <20190203222654.GA28988@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190201175054.26105-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201175054.26105-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

> Added the tests that I've been using for testing TPM 2.0 functionality
> for long time but have out-of-tree so far residing in

> https://github.com/jsakkine-intel/tpm2-scripts

> Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

> +++ b/tools/testing/selftests/tpm2/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +
> +TEST_PROGS := test_smoke.sh test_space.sh
Maybe include lib.mk, to avoid make No targets error? (well, it's reported for
more tests)

include ../lib.mk

make[1]: Entering directory '/home/pevik/install/src/linux.git/tools/testing/selftests/tpm2'
make[1]: *** No targets.  Stop.


Kind regards,
Petr
