Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeEPTaq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:30:46 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:44872 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEPTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:30:45 -0400
X-Google-Smtp-Source: AB8JxZpTKC3dsGHfTtNy5aX7LGMKj7If1jv/mqN1H5I43vkBhtXzFhkfBFw8Y/xrQI0j9Ui8I+TiYw==
Subject: Re: [PATCH IB/core 2/2] IB/cm: Send authentic pkey in REQ msg and
 check eligibility of the pkeys
To: =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180514210200.GN21531@ziepe.ca>
 <ab0e1318-8e1a-5822-5484-33e460095830@dev.mellanox.co.il>
 <E41BCEAA-0204-448D-8188-ACA03932B3AC@oracle.com>
 <20180515190424.GL5615@ziepe.ca>
 <3E15B62F-E705-43BD-8A72-9E74F784D40E@oracle.com>
 <20180516151201.GA25661@ziepe.ca>
 <695ae613-931a-50ba-2b83-9d172e0ac2bc@dev.mellanox.co.il>
 <151B2A36-28F0-4A88-8633-31AE7E55F848@oracle.com>
 <20180516180115.GF25661@ziepe.ca>
 <FDEBA43A-C98F-4E2B-A8F3-CA809FBAD479@oracle.com>
 <20180516181655.GH25661@ziepe.ca>
 <A087A721-E596-428E-8554-FAEB4BE9B306@oracle.com>
From: Hal Rosenstock <hal@dev.mellanox.co.il>
Message-ID: <476dbacf-d02e-1bfa-35c7-aa5c743901ad@dev.mellanox.co.il>
Date: Wed, 16 May 2018 15:30:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <A087A721-E596-428E-8554-FAEB4BE9B306@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2018 3:22 PM, Håkon Bugge wrote:
> But, do we need an update to IBTA (that the BTH.PKey shall be that of the VM's Port)?

Nothing in spec mentions shared (port) virtualization so that is an
exercise completely left to the reader...

Annex A19 is silent on this specific point but the virtual port model
has virtual port partition table so there's no ambiguity there.
