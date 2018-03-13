Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbeCMBr5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:47:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42592 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbeCMBr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:47:56 -0400
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
To: Keith Busch <keith.busch@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <CAHp75Vet0gt0RW4eu+TCE8qBSk2ymMKkG5=SuM9ytzO3-6Y+Mg@mail.gmail.com>
 <616adf0c-5023-0e66-cc59-504d52d76e44@oracle.com>
 <20180312185932.GH18494@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <77263447-ffdd-ebe4-9cf9-8f0b2d9b2503@oracle.com>
Date: Tue, 13 Mar 2018 09:47:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312185932.GH18494@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=814
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130022
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your precious time for testing and reviewing.
I will send out V3 next.

Sincerely
Jianchao

On 03/13/2018 02:59 AM, Keith Busch wrote:
> Hi Jianchao,
> 
> The patch tests fine on all hardware I had. I'd like to queue this up
> for the next 4.16-rc. Could you send a v3 with the cleanup changes Andy
> suggested and a changelog aligned with Ming's insights?
> 
> Thanks,
> Keith
> 
