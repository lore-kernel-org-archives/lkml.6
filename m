Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40091C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9C12186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeLTPfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:35:47 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.209]:30193 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730667AbeLTPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:35:47 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 84E4254D6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:35:46 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id a0MUgxaSs90ona0MUgVVnI; Thu, 20 Dec 2018 09:35:46 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=55734 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ga0MU-003TrQ-1N; Thu, 20 Dec 2018 09:35:46 -0600
Subject: Re: [PATCH 31/41] scsi: mpt3sas: mpt3sas_scsih: Mark expected switch
 fall-through
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <892c3e5e27213c1c2f3da128afe958429bbef672.1543374820.git.gustavo@embeddedor.com>
 <4bce4543-ae65-8dfa-cbe6-405d78003129@embeddedor.com>
 <CA+RiK64O=zLKdbF4KRXYGD23qi3Ajv5S2oPoKuSbksbMwOHu_A@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <49711a00-c9f5-9da7-3c05-816bb6901378@embeddedor.com>
Date:   Thu, 20 Dec 2018 09:35:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+RiK64O=zLKdbF4KRXYGD23qi3Ajv5S2oPoKuSbksbMwOHu_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1ga0MU-003TrQ-1N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:55734
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suganath,

On 12/19/18 10:19 PM, Suganath Prabu Subramani wrote:
> Hi Gustavo,
> 
> This patch may not apply smoothly over 4.21/scsi-queue.
> Our previous patch for Aero had some changes in this switch case.
> Can you resend this patch with latest code base ?
> 

Okay. I'll send a separate patch.

Thanks for the feedback.
--
Gustavo
