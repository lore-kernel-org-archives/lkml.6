Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70966C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363C520652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363C520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeFTIds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:33:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754265AbeFTIdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D72BAC95;
        Wed, 20 Jun 2018 07:21:03 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:21:38 +0200
From:   Michael Moese <mmoese@suse.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     ltp@lists.linux.it, open list <linux-kernel@vger.kernel.org>,
        Rafael Tinoco <rafael.tinoco@linaro.org>,
        Jan Stancek <jstancek@redhat.com>, ebiggers@google.com,
        dave.hansen@linux.intel.com
Subject: Re: LTP CVE cve-2017-17053 test failed on x86_64 device
Message-ID: <20180620072138.yrz76kmms3oviv7i@linux-d8ym>
Mail-Followup-To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        ltp@lists.linux.it, open list <linux-kernel@vger.kernel.org>,
        Rafael Tinoco <rafael.tinoco@linaro.org>,
        Jan Stancek <jstancek@redhat.com>, ebiggers@google.com,
        dave.hansen@linux.intel.com
References: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 20, 2018 at 12:14:22PM +0530, Naresh Kamboju wrote:
> Test FAIL case output,
> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
> tst_taint.c:88: BROK: Kernel is already tainted: 512
The kernel is already tainted. In this case, the test refuses to run,
because it could not tell if the test is pass or fail.

Could you please check if you could run the test directly after a
reboot?

Regards,
Michael
-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
