Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeCQEIX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 00:08:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeCQEIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 00:08:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2647360312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
To: Steve Wise <swise@opengridcomputing.com>,
        "'Jason Gunthorpe'" <jgg@ziepe.ca>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "'Sinan Kaya'" <okaya@codeaurora.org>, netdev@vger.kernel.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "'Steve Wise'" <swise@chelsio.com>,
        "'Doug Ledford'" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, "'Michael Werner'" <werner@chelsio.com>,
        "'Casey Leedom'" <leedom@chelsio.com>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-19-git-send-email-okaya@codeaurora.org>
 <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
 <20180316221347.GA958@ziepe.ca>
 <004401d3bd7b$2a2e70b0$7e8b5210$@opengridcomputing.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <b327cb67-562c-8b95-b31b-96594d6a41ae@codeaurora.org>
Date: Fri, 16 Mar 2018 23:08:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <004401d3bd7b$2a2e70b0$7e8b5210$@opengridcomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/18 6:04 PM, Steve Wise wrote:
> Anybody understand why the PPC implementation of writeX_relaxed() isn't
> relaxed?

You probably should ask that on the linuxppc-dev@lists.ozlabs.org 
mailing list.

I've always wondered why PowerPC has non-standard I/O accessors.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
