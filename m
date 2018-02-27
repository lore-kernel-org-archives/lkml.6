Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeB0FPX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:15:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:32900 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeB0FPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:15:22 -0500
Subject: Re: [PATCH] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
References: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
 <1519700898.3120.3.camel@wdc.com>
 <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
 <1519702875.3120.7.camel@wdc.com>
 <db9c47e6-d8ea-1e9e-609a-ff1b1db3769c@oracle.com>
 <1519708355.3120.9.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <478f40f1-d86c-ee5f-daaf-6332b67fe721@oracle.com>
Date: Tue, 27 Feb 2018 13:15:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519708355.3120.9.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802270057
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

Thanks for your kindly response.

On 02/27/2018 01:12 PM, Bart Van Assche wrote:
> On Tue, 2018-02-27 at 12:00 +0800, jianchao.wang wrote:
>> On the other hand, this patch is to align the actions between blk-mq and block
>> legacy code in __scsi_queue_insert.
> 
> Hello Jianchao,
> 
> Since the legacy SCSI core unpreps an reprepares a request when requeuing it I
> think your patch does not align the blk-mq and legacy block layer actions but
> instead makes the behavior of the two code paths different.
> 

Can you share more details about this ? 

Thanks 
Jianchao 
