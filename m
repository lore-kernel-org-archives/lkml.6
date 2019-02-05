Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BC2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D94217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dBvkp0eJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfBEODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:03:36 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41382 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBEODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:03:36 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B738A10C1DAC;
        Tue,  5 Feb 2019 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549375415; bh=UZO0qJqhxyeeyNf0R+mRIcOi14q4Elqtg9CwlygoxCI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=dBvkp0eJ7RLYHbNHRQwld1TdGwfjwbD9MfbkeM07/zFWTlUDs0qdKx4dlPanEMJLj
         0zwdEAKD3zwjGIWTuaWcJ3fJUULpSBX3UDcosDL/keyAl077FZeS3IM6A9bDFjMWOA
         /RFKnXxVzyw+7/H1W15RPq3UDHDWOZ4tBEFwJebfTjtwOWmiSGju2NhAHQRWcvRn5q
         +FDr2jxkk1u+vPJoEBRhyxBjFTUOSjKv1wcGl8cRiATdYw5AXHATYFccgcXjFZuRh3
         FJ+VPdsR5H22jGm8PSN1B2CkvRk4dgdOzWkRUE4rRZgz80aREY1/WF37IdCLCKGixW
         Fdn7FPpiyPzqA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 922F0A00AA;
        Tue,  5 Feb 2019 14:03:35 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Feb 2019 06:02:32 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Feb 2019 15:02:30 +0100
Received: from [10.107.25.113] (10.107.25.113) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Feb 2019 15:02:30 +0100
Subject: Re: [PATCH for-next] scsi: ufs: Update dwc driver maintainer to Pedro
 Sousa
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Joao Pinto <joao.pinto@synopsys.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pedrom.sousa@synopsys.com>, <marc.w.gonzalez@free.fr>,
        <Alex.Lemberg@wdc.com>
References: <812e9e1426555808ad1bd5fbfda320c6684abc81.1548869844.git.jpinto@synopsys.com>
 <yq1a7ja3nxp.fsf@oracle.com>
From:   Joao Pinto <joao.pinto@synopsys.com>
Message-ID: <2d6b34bc-370f-8dbd-a301-f292591c87f1@synopsys.com>
Date:   Tue, 5 Feb 2019 14:02:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <yq1a7ja3nxp.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.113]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Martin.

On 2/5/2019 3:37 AM, Martin K. Petersen wrote:
> Joao,
>
>> Currently I am managing the Synopsys drivers & tools team (full-time) and
>> so I am passing the DWC UFS driver maintenance to Pedro Sousa.
> Applied to 5.1/scsi-queue, thanks.
>
