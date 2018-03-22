Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeCVL6w convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:58:52 -0400
Received: from mail9.hitachi.co.jp ([133.145.228.44]:35058 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeCVL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:58:48 -0400
From: =?iso-2022-jp?B?GyRCNTUwZj9OO1YbKEIgLyBLQU1FSRskQiEkGyhCSElUT1NISQ==?=
        <hitoshi.kamei.xm@hitachi.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        "sage@redhat.com" <sage@redhat.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] rbd: add 'thick' sysfs rbd device attribute
Thread-Topic: [PATCH 2/2] rbd: add 'thick' sysfs rbd device attribute
Thread-Index: AQHTwF4/Gh/l3rLRqUaXqBmtQ+ETi6PcJmvg
Date: Thu, 22 Mar 2018 11:58:38 +0000
Deferred-Delivery: Thu, 22 Mar 2018 11:58:44 +0000
Message-ID: <C8603108370B1949BF3CC7742DDE5D35B8B39FFD@GSjpTKYDCembx31.service.hitachi.net>
References: <5AAFA69E.2050007@hitachi.com>
 <20180320151510.GA13059@infradead.org>
In-Reply-To: <20180320151510.GA13059@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.29.202]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The normal storage term would be fully provisioned, not 'thick'

The rbd command, which is user mode program, uses "thick-provision".
If the kernel rbd driver uses "fully provisioned", then the rbd command
should use "fully provisioned" too. 

What do you think, Jason?

Regards,

-- 
Hitoshi Kamei
