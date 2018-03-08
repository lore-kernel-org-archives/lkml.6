Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756117AbeCHQTW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:19:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756101AbeCHQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:19:20 -0500
Date: Thu, 8 Mar 2018 11:19:14 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xensource.com
Subject: [GIT PULL] (xen) stable/for-jens-4.15
Message-ID: <20180308161914.GN12029@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Please git pull the following branch for your for-linus branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.15

It has one simple fix for the multi-queue support not showing up after a block
device was detached/re-attached.

The patch was originally posted in Dec 22nd but with the Spectre/Meltdown
circus I forgot about it until now.

Thank you!
 
drivers/block/xen-blkfront.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

Bhavesh Davda (1):
      xen-blkfront: move negotiate_mq to cover all cases of new VBDs
