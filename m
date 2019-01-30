Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D972087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OJbapiJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfA3TQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:16:04 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:36810 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfA3TQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:16:01 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id E2D8D10C06F2;
        Wed, 30 Jan 2019 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548875760; bh=/pvBDtZDxRQN8DTgfIUdAXTARX82NKrDdRwAqBfyUOU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=OJbapiJnOW+tbhJ+x1uuFunq4mSoQhf8xtZVRTeRjXlqIl2GWlR8nIP00tpi+k+VL
         BGyQfwEsbKTecSlYcyGWl9HET/A/ygkDX9oCwz5e5iAFi4nEamN3rI1YzK9GdBDoQb
         ePRJzrqqT0uKcO0mNVlWUT3adEs1C2VZe50E5fjy92R9o4GC8gcmoYUpmQ2bbZ+H2L
         PXw0qzvkERboe9PkwyFBiPj/XdB9Oc0TdLieBjByYfFOeEnLYM9a0NliuYkCYLN0kz
         mWpx97a4XcJrCN5TwoNIWQv3LeBX+Skgr8zXjMIGktlzLivxyagv9nbVcdNTJUwFzU
         lKgcWfmByKHsw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A5A54A00E4;
        Wed, 30 Jan 2019 19:16:00 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 30 Jan 2019 11:16:00 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 30 Jan 2019 20:15:58 +0100
Received: from [10.107.25.113] (10.107.25.113) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 30 Jan 2019 20:15:58 +0100
Subject: Re: [PATCH for-next] scsi: ufs: Update dwc driver maintainer to Pedro
 Sousa
To:     Bart Van Assche <bvanassche@acm.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pedrom.sousa@synopsys.com>, <marc.w.gonzalez@free.fr>,
        <Alex.Lemberg@wdc.com>
References: <812e9e1426555808ad1bd5fbfda320c6684abc81.1548869844.git.jpinto@synopsys.com>
 <1548870848.213038.3.camel@acm.org>
From:   Joao Pinto <joao.pinto@synopsys.com>
Message-ID: <f0ff398e-cc13-d70d-0488-d35faa126a5a@synopsys.com>
Date:   Wed, 30 Jan 2019 19:15:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548870848.213038.3.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.113]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bart,

First of all thanks for the feedback.

On 1/30/2019 5:54 PM, Bart Van Assche wrote:
> On Wed, 2019-01-30 at 18:48 +0100, Joao Pinto wrote:
>> Currently I am managing the Synopsys drivers & tools team (full-time) and
>> so I am passing the DWC UFS driver maintenance to Pedro Sousa.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
>> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> Cc: Alex Lemberg <Alex.Lemberg@wdc.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 70c93b1..458a2a2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15673,7 +15673,7 @@ F:	Documentation/scsi/ufs.txt
>>  F:	drivers/scsi/ufs/
>>  
>>  UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER DWC HOOKS
>> -M:	Joao Pinto <jpinto@synopsys.com>
>> +M:	Pedro Sousa <pedrom.sousa@synopsys.com>
>>  L:	linux-scsi@vger.kernel.org
>>  S:	Supported
>>  F:	drivers/scsi/ufs/*dwc*
> Shouldn't people have proven to be willing to stick around before being
> added as a kernel maintainer? Additionally, what is the experience level of
> Pedro with kernel development? All I know is the following:

Pedro Sousa is my team member and has been working in Unipro/UFS Synopsys
drivers for almost 2 years.

His work has been mainly internal, and now our goal is to start using the
mainline DWC UFS driver I submitted 2 years ago in our regular activities,
update and maintain it effectively as we are doing in other titles.

Currently I am Pedro' manager, and in my opinion he has the right experience for
this step and that is why I am suggesting to transfer Synopsys driver
maintenance from me to him.

>
> $ git log --author "Pedro Sousa" | wc -l
> 0
> $ git log | grep -c "Pedro Sousa"
> 0
>
> Are you aware that people who are not mentioned in the MAINTAINERS file are
> allowed to review kernel patches?

Yes, I am aware and Pedro is perfectly capable of doing that, and for that
reason I am suggesting him as the right person to maintain Synopsys UFS driver.

>
> Thanks,
>
> Bart.
>
Thanks,

Joao


