Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCVQeT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:34:19 -0400
Received: from opengridcomputing.com ([70.118.0.34]:51339 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751632AbeCVQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:34:16 -0400
Subject: Re: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>,
        "'kbuild test robot'" <lkp@intel.com>
Cc: kbuild-all@01.org, linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "'Steve Wise'" <swise@chelsio.com>,
        "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        "'Casey Leedom'" <leedom@chelsio.com>,
        "'Michael Werner'" <werner@chelsio.com>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
From: Steve Wise <swise@opengridcomputing.com>
Message-ID: <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
Date: Thu, 22 Mar 2018 11:28:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2018 9:52 AM, Sinan Kaya wrote:
> On 3/22/2018 9:40 AM, Steve Wise wrote:
>> I think all these iw_cxgb4 changes should be reverted until we really have a
>> plan for multi-platform that works.  
> I know you are looking to have support for PowerPC. 
>
> Isn't this a PowerPC problem? Why penalize other architectures?
>
> Do you see anything wrong with the code itself?

I worry it breaks PPC.

> I started this thread with the PowerPC develoeprs on your request.
> "RFC on writel and writel_relaxed"
>
> They are looking into adding the relaxed API support. Support can come
> in later. Why block this change now?
>
> benh@kernel.crashing.org:
> "I've been wanting to implement the relaxed accessors for a while but
> was battling with this to try to also better support WC, and due to
> other commitments, this somewhat fell down the cracks."
>
> I have seen four different responses on this thread. Since this is an
> architecture change it will take a while to get the semantics right.
> It won't happen in the new few days.

I appreciate you doing this.
