Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeBECay (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 21:30:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57796 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBECap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 21:30:45 -0500
Subject: Re: [PATCH 1/6] nvme-pci: move clearing host mem behind stopping
 queues
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180202184605.GJ24417@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <848639df-1a65-35fe-1c7d-d79cfe4ec581@oracle.com>
Date: Mon, 5 Feb 2018 10:30:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202184605.GJ24417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8795 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=482
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050030
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your kindly response and directive.

On 02/03/2018 02:46 AM, Keith Busch wrote:
> This one makes sense, though I would alter the change log to something
> like:
> 
>   This patch quiecses new IO prior to disabling device HMB access.
>   A controller using HMB may be relying on it to efficiently complete
>   IO commands
Yes, I will change it next version.

Sincerely
Jianchao
