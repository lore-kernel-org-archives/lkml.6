Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeBIHLf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:11:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45585 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750828AbeBIHLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:11:33 -0500
From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [V9fs-developer] [RFC] we should solve create-unlink-getattr idiom
To: Eric Van Hensbergen <ericvh@gmail.com>, Greg Kurz <groug@kaod.org>,
        <v9fs-developer@lists.sourceforge.net>, <qemu-devel@nongnu.org>
CC: <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Veaceslav Falico <veaceslav.falico@huawei.com>
Message-ID: <5A7D4976.6060407@huawei.com>
Date: Fri, 9 Feb 2018 15:10:46 +0800
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

Hi Eric and Greg,

I encountered the similar problem with create-unlink-getattr idiom.
I use the testcase that create-unlink-setattr idiom, and I see the
bug is reported at https://bugs.launchpad.net/qemu/+bug/1336794.
Then I also see you already fix the issue and push the patch to upstream.
https://github.com/ericvh/linux/commit/eaf70223eac094291169f5a6de580351890162a2
http://patchwork.ozlabs.org/patch/626194/

Unfortunately, the two patches are not merged into master, I don't know
the reason, so I suggest if the patche can be merged into master, and
it will solve the create-unlink-getattr idiom.

Thanks,
Yiwen
