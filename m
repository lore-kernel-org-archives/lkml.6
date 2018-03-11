Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeCKQs3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:48:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeCKQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:48:27 -0400
Date: Sun, 11 Mar 2018 12:48:14 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [rds-devel] [PATCH][rds-next] rds: remove redundant variable
 'sg_off'
Message-ID: <20180311164814.GA7812@oracle.com>
References: <20180311162756.26950-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311162756.26950-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8828 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=689
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803110216
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/11/18 17:27), Colin King wrote:
> Variable sg_off is assigned a value but it is never read, hence it is
> redundant and can be removed.
> 

Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
