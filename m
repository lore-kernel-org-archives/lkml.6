Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757464AbeD0AV4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:21:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42744 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbeD0AVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:21:51 -0400
Subject: Re: [PATCH] net/mlx5: report persistent netdev stats across
 ifdown/ifup commands
To: Saeed Mahameed <saeedm@dev.mellanox.co.il>
Cc: Eran Ben Elisha <eranbe@mellanox.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>, Matan Barak <matanb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
References: <1524775057-8012-1-git-send-email-qing.huang@oracle.com>
 <CALzJLG8=dnyLGRXamLR5-eYJ9Q8WCwKe44sHHZ57=1h_x0RCRA@mail.gmail.com>
 <5cd29779-fc70-930a-7060-ee3332c15558@oracle.com>
 <CALzJLG8atGxoJNQj4F6wR3kRg7jrj4oQi3O-1i0=UOo+3HPq0w@mail.gmail.com>
 <CALzJLG_ROqv1Kby1FbGXFSgB5My4Gj=3cubw=DEts_9_3V3=3A@mail.gmail.com>
From: Qing Huang <qing.huang@oracle.com>
Message-ID: <68e80592-6455-5b97-d44d-5609aca01f82@oracle.com>
Date: Thu, 26 Apr 2018 17:21:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALzJLG_ROqv1Kby1FbGXFSgB5My4Gj=3cubw=DEts_9_3V3=3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804270001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! Looks like Eran's patch will be available much sooner than v4.18 
release time frame (since v4.16 was just released).

We will wait. :-)


On 04/26/2018 04:43 PM, Saeed Mahameed wrote:
> Before you address my comments, it looks like Eran's work is
> converging and we will finalize the internal
> review next week, in which case submission will take 2-3 weeks from today.
>
> So i suggest to wait.
>
> please checkout:
> https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?h=testing/mlx5e-stats&id=15ffb7f87432d073e8ac0e6b895188d40fdda4d4
