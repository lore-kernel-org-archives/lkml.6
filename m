Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935485AbeBLQP0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:15:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40810 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934937AbeBLQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:15:24 -0500
Date: Mon, 12 Feb 2018 11:15:16 -0500
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: syzbot <syzbot+a0564419941aaae3fe3c@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: suspicious RCU usage in rds_tcp_conn_alloc
Message-ID: <20180212161516.GC21125@oracle.com>
References: <001a11499df4ce6c2d056505e5c0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11499df4ce6c2d056505e5c0@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=540
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: WARNING: suspicious RCU usage in rds_loop_conn_alloc
