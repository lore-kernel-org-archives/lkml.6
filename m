Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeC3IzE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 04:55:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750831AbeC3IzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 04:55:02 -0400
To: Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        Greg Kurz <groug@kaod.org>, <aneesh.kumar@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <v9fs-developer@lists.sourceforge.net>,
        <qemu-devel@nongnu.org>
From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [RFC] About 9pfs support "O_DIRECT + aio"?
Message-ID: <5ABDFB24.1080207@huawei.com>
Date: Fri, 30 Mar 2018 16:53:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Currently, I found virtio-9p in VirtFS don't support "O_DIRECT + aio"
mode, both v9fs and qemu. So when user use "O_DIRECT + aio" mode and
increase iodepths, they can't get higher IOPS.

I want to know why v9fs don't implement this mode? And I will try to
implement this mode from now on.

Thanks,
Yiwen.
