Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA9DC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8BC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8BC20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeLLVP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:15:59 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:50014 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbeLLVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:15:59 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 80F32980086;
        Wed, 12 Dec 2018 21:15:57 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 13:15:53 -0800
Subject: Re: [PATCH 6/7] selftest/bpf: remove redundant parenthesis
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <shuah@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
 <20181211115607.13774-7-alice.ferrazzi@gmail.com>
 <20181212110404.2e211ef1@cakuba.netronome.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <31fc0e28-8f34-1b44-c6b1-9441c6e26c9e@solarflare.com>
Date:   Wed, 12 Dec 2018 21:15:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181212110404.2e211ef1@cakuba.netronome.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24280.005
X-TM-AS-Result: No-1.988800-4.000000-10
X-TMASE-MatchedRID: nVQUmLJJeyYOwH4pD14DsPHkpkyUphL94cLBHAw1BRZcU0dNErOD+oCu
        qghmtWfXrPpDhDMifTN+ZLbS08T2SyWvhQBtQUwTaK+MsTwM+1nJ5SXtoJPLyJps2hiiMFB2I9F
        iPUhLKM6JrlhBTnTbaRlEmsAU8pQ/75CbtOD2MbePnpohp8ng0XUh2OMdFI0JF9VppSt24oejxY
        yRBa/qJUl4W8WVUOR/joczmuoPCq23IwvvYVYDmOYJogH0ttmqAQnjxLRiQgMeNSDUrKCHgWHxf
        s3B4Q8UPoAMv/Nr7+4Me9mApo5t0GRTbjJR+yeLfFyuinCjgI3i+fTMx9KaNitss6PUa4/cD6GA
        t+UbooSj1CO4X0EqeXggXFAhtWiYlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.988800-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24280.005
X-MDID: 1544649358-p8pEFbp4vS3x
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 19:04, Jakub Kicinski wrote:
> On Tue, 11 Dec 2018 20:56:06 +0900, Alice Ferrazzi wrote:
>> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
>> ---
>>  tools/testing/selftests/bpf/test_offload.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
>> index 0f9130ebfd2c..b06cc0eea0eb 100755
>> --- a/tools/testing/selftests/bpf/test_offload.py
>> +++ b/tools/testing/selftests/bpf/test_offload.py
>> @@ -140,7 +140,7 @@ def cmd_result(proc, include_stderr=False, fail=False):
>>  
>>  
>>  def rm(f):
>> -    cmd("rm -f %s" % (f))
>> +    cmd("rm -f %s" % f)
>>      if f in files:
>>          files.remove(f)
>>  
> Is this in PEP8, too?
I don't know, but it shouldn't be.
If f is a sequence type, both the old and new code can break here,
 throwing a TypeError.  It should be cmd("rm -f %s" % (f,)).  The
 presence of the brackets suggests to me that that's what the
 original author intended.
Now, it's unlikely that we'd ever want to pass a list or tuple
 here, since 'rm' wouldn't understand the result, but the proper
 way to deal with that is an assertion with a meaningful message,
 since the TypeError here will have the non-obvious message "not
 all arguments converted during string formatting".

-Ed
