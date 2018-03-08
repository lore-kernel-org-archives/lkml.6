Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934346AbeCHOdY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:33:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59904 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCHOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:33:23 -0500
Subject: Re: [PATCH V4 1/5] nvme: do atomically bit operations on
 nvme_request.flags
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180308075736.GB16084@lst.de>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d9d37fd4-2632-c46b-2ec1-291c4dc1d26d@oracle.com>
Date: Thu, 8 Mar 2018 22:32:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308075736.GB16084@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=846
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

Thanks for your precious time for reviewing this.

On 03/08/2018 03:57 PM, Christoph Hellwig wrote:
>> -	u8			flags;
>>  	u16			status;
>> +	unsigned long flags;
> Please align the field name like the others, though

Yes, I will change this next version.

Thanks
Jianchao
