Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeEPJtx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:49:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54100 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEPJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:49:51 -0400
Subject: Re: [PATCH] nvme-rdma: clear NVME_RDMA_Q_LIVE before free the queue
To: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1525420958-9537-1-git-send-email-jianchao.w.wang@oracle.com>
 <7096b02a-956a-6765-7839-227c154d8336@grimberg.me>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8bba6171-cfe8-3442-7b03-693e34dc096d@oracle.com>
Date: Wed, 16 May 2018 17:49:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7096b02a-956a-6765-7839-227c154d8336@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160099
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi

On 05/09/2018 11:06 PM, Sagi Grimberg wrote:
> The correct fix would be to add a tag for stop_queue and call
> nvme_rdma_stop_queue() in all the failure cases after
> nvme_rdma_start_queue.

Would you please look at the V2 in following link ?
http://lists.infradead.org/pipermail/linux-nvme/2018-May/017330.html

Thanks in advance
Jianchao
