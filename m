Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbeCLGyo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:54:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50832 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCLGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:54:42 -0400
Subject: Re: [PATCH][rds-next] rds: remove redundant variable 'sg_off'
To: Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180311162756.26950-1-colin.king@canonical.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <cd3c782b-0d54-21e5-43e7-f2120bfb6348@oracle.com>
Date: Sun, 11 Mar 2018 23:54:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180311162756.26950-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8829 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=751
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803120081
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/18 9:27 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable sg_off is assigned a value but it is never read, hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> net/rds/message.c:373:2: warning: Value stored to 'sg_off' is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   net/rds/message.c | 2 --
>   1 file changed, 2 deletions(-)
> 
Thanks Colin !!

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
