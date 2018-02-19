Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbeBSUHS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:07:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54302 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbeBSUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:07:17 -0500
Date: Mon, 19 Feb 2018 15:06:37 -0500
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
Message-ID: <20180219200637.GJ11370@oracle.com>
References: <20180219181020.GA19154@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219181020.GA19154@embeddedgus>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=573
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802190248
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/19/18 12:10), Gustavo A. R. Silva wrote:
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Acked-by:  Sowmini Varadhan <sowmini.varadhan@oracle.com>
