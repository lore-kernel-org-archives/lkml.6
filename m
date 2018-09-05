Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755BA20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755BA20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIEXnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:43:04 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:60814 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:43:04 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fxdD8-0004yp-Qb; Wed, 05 Sep 2018 20:11:31 +0100
Message-ID: <1536174689.3024.59.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 054/124] scsi: ufs: fix exception event handling
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Subhash Jadavani <subhashj@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Cc:     stable@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Sep 2018 20:11:29 +0100
In-Reply-To: <20180804082704.532864830@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
         <20180804082704.532864830@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 11:00 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> > From: Maya Erez <merez@codeaurora.org>
> 
> [ Upstream commit 2e3611e9546c2ed4def152a51dfd34e8dddae7a5 ]
[...]

Does this need to be accompanied by:

commit 38135535dcc25af856336fda31aeef79d8ad9dab
Author: Subhash Jadavani <subhashj@codeaurora.org>
Date:   Thu May 3 16:37:18 2018 +0530

    scsi: ufs: add reference counting for scsi block requests

?

If so, can you provide backports of that for 3.18, 4.4 and 4.9?

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
