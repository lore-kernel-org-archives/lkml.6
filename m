Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04ABC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AD22083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AD22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJZAec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:34:32 -0400
Received: from www381.your-server.de ([78.46.137.84]:50080 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:34:32 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1gFi4D-0000yd-Vu; Thu, 25 Oct 2018 18:01:02 +0200
Received: from [2003:93:4d12:1e00:8200:bff:fe9b:6612]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1gFi4D-000WEv-Oi; Thu, 25 Oct 2018 18:01:01 +0200
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
To:     Himanshu Jha <himanshujha199640@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
 <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
 <20181025142635.3apgyaxzhr73kehc@renatolg>
 <20181025145520.GA16950@himanshu-Vostro-3559>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2007f2b3-5d1a-14c6-4c98-1d9faf6d21bf@metafoo.de>
Date:   Thu, 25 Oct 2018 18:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025145520.GA16950@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25067/Wed Oct 24 23:01:03 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 04:55 PM, Himanshu Jha wrote:
> On Thu, Oct 25, 2018 at 11:26:36AM -0300, Renato Lui Geh wrote:
>> Hi,
>>
>> Thanks for the quick review. :)
>>
>>> But please create one patch per issue and do not put unrelated changes into
>>> the same patch.
>>
>> Should I resend this patch as a patchset containing the two changes?
> 
> Yes! "One patch per change policy"
> 
>>> Also your mail client seems to have replaced tabs in the patch with spaces,
>>> this means the patch will not apply cleanly. Check the
>>> Documentation/email-clients.txt file for some hints how to configure your
>>> mail client so it will not break patches.
>>
>> From my end my original email patch appears to have tabs instead of
>> spaces. I redownloaded my email and vim shows that the indentation has
>> the ^I tab characters. But when downloading your reply it was converted
>> to spaces. Am I missing something?
> 
> Your patch applies fine.
> 
> I think the problem is on Lars end due to Thunderbird.

Yeah, looks like I need to read email-clients.txt...

I think it is mis-rendered on my side due to the "Content-Type: ...
format=flowed" in the header.
