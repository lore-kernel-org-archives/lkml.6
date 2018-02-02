Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeBBNcQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:32:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34718 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbeBBNcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:32:08 -0500
To: Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        <v9fs-developer@lists.sourceforge.net>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Eduard Shishkin" <Eduard.Shishkin@huawei.com>,
        "Wangguoli (Andy)" <andy.wangguoli@huawei.com>
From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [V9fs-developer] [RFC] why set SB_NOATIME in v9fs_fill_super by
 default
Message-ID: <5A746839.9020602@huawei.com>
Date: Fri, 2 Feb 2018 21:31:37 +0800
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

Hi all,

I found v9fs always set SB_NOATIME into sb->s_flags in v9fs_fill_super,
even if user use mount option relatime, I am very curious about this
thing, can anyone tell me?

Thanks,
Yiwen Jiang.
