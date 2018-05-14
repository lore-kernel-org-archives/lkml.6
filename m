Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeENFq6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:46:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38186 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeENFq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:46:57 -0400
Subject: Re: general protection fault in rds_ib_get_mr
To: Eric Biggers <ebiggers3@gmail.com>, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com
Cc: syzbot <syzbot+b51c77ef956678a65834@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <089e082ce58896ad350567ee4825@google.com>
 <20180513211058.GE677@sol.localdomain>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <27665604-6a26-36e2-3a58-9c8b3d9eab80@oracle.com>
Date: Sun, 13 May 2018 22:46:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513211058.GE677@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8892 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=812
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140061
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/18 2:10 PM, Eric Biggers wrote:
> On Wed, Mar 21, 2018 at 09:00:01AM -0700, syzbot wrote:

[...]


> Still reproducible on Linus' tree (commit 66e1c94db3cd4) and linux-next
> (next-20180511).  Here's a simplified reproducer:
> 
Thanks for the test case !!

Regards,
Santosh
