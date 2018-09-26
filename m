Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F25FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B06D20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B06D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeIZSkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:40:14 -0400
Received: from belmont94srvr.owm.bell.net ([184.150.200.94]:32916 "EHLO
        mtlfep07.bell.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZSkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:40:14 -0400
X-Greylist: delayed 1083 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Sep 2018 14:40:13 EDT
Received: from bell.net mtlfep02 184.150.200.30 by mtlfep02.bell.net
          with ESMTP
          id <20180926120928.MUVD11841.mtlfep02.bell.net@mtlspm02.bell.net>;
          Wed, 26 Sep 2018 08:09:28 -0400
Received: from [192.168.2.49] (really [70.53.62.196]) by mtlspm02.bell.net
          with ESMTP
          id <20180926120928.NLCF26679.mtlspm02.bell.net@[192.168.2.49]>;
          Wed, 26 Sep 2018 08:09:28 -0400
Subject: Re: [PATCH] parisc: Remove PTE load and fault check from L2_ptep
 macro
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jejb@parisc-linux.org, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180926032101.GA2458@roeck-us.net>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <dcb9250d-f811-90be-2c5a-4d15cb29b474@bell.net>
Date:   Wed, 26 Sep 2018 08:09:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926032101.GA2458@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=L+Xye6b8 c=1 sm=0 tr=0 a=Zvhif4XNTjWcJyJCfFIh1A==:17 a=IkcTkHD0fZMA:10 a=JBFolyDoGHsA:10 a=FBHGMhGWAAAA:8 a=WIMuH9iB4f1ny0LeIgcA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-09-25 11:21 PM, Guenter Roeck wrote:
> This patch causes my parisc qemu tests to fail.
> Unfortunately I don't have any useful log output; the failure
> is silent. Reverting the patch fixes the problem.
Can you be more specific on how to run these tests?

Dave

-- 
John David Anglin  dave.anglin@bell.net

