Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935375AbeBLQPG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:15:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53744 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934937AbeBLQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:15:04 -0500
Date: Mon, 12 Feb 2018 11:14:47 -0500
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: syzbot <syzbot+f8af40b8331eed0c4ada@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: sleeping function called from invalid context at
 mm/slab.h:LINE (3)
Message-ID: <20180212161447.GB21125@oracle.com>
References: <001a113fd4489d4510056505ffb6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113fd4489d4510056505ffb6@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=464
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: WARNING: suspicious RCU usage in rds_loop_conn_alloc
