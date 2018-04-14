Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeDNPNE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 11:13:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:54560 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbeDNPND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 11:13:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,449,1517904000";
   d="scan'208";a="34255776"
Subject: Re: [PATCH v2] IB: make INFINIBAND_ADDR_TRANS configurable
To: Greg Thelen <gthelen@google.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tarick Bedeir <tarick@google.com>
References: <9ad4563e701a38915d58552f9eee5b3602833ddf.camel@wdc.com>
 <20180413172708.30286-1-gthelen@google.com>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <b1f20a68-2ed4-935f-4a9c-8a28c142ceee@intel.com>
Date: Sat, 14 Apr 2018 11:13:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413172708.30286-1-gthelen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/2018 1:27 PM, Greg Thelen wrote:
> Allow INFINIBAND without INFINIBAND_ADDR_TRANS.
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Cc: Tarick Bedeir <tarick@google.com>
> Change-Id: I6fbbf8a432e467710fa65e4904b7d61880b914e5

Forgot to remove the Gerrit thing.

-Denny
