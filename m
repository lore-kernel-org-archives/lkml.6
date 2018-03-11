Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeCKRWT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 13:22:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932167AbeCKRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 13:22:17 -0400
Date: Sun, 11 Mar 2018 13:22:07 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][rds-next] rds: make functions rds_info_from_znotifier
 and rds_message_zcopy_from_user static
Message-ID: <20180311172207.GB7812@oracle.com>
References: <20180311170340.27696-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311170340.27696-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8829 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=502
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803110224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/11/18 18:03), Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Functions rds_info_from_znotifier and rds_message_zcopy_from_user are
> local to the source and do not need to be in global scope, so make them
> static.

the rds_message_zcopy_from_user warning was already flagged by  kbuild-robot
last week.  See
   https://www.spinics.net/lists/netdev/msg488041.html


 
