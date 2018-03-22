Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbeCVL7n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:59:43 -0400
Received: from mail9.hitachi.co.jp ([133.145.228.44]:39914 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbeCVL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:59:42 -0400
From: =?utf-8?B?5LqA5LqV5LuB5b+XIC8gS0FNRUnvvIxISVRPU0hJ?=
        <hitoshi.kamei.xm@hitachi.com>
To: "dillaman@redhat.com" <dillaman@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
CC: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        "Ceph Development" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH 0/2] rbd: thick-provision image support
Thread-Topic: [!]Re: [PATCH 0/2] rbd: thick-provision image support
Thread-Index: AQHTwJstTIwmteaZT0Gs+F0W0M/bEKPcJiiQ
Date: Thu, 22 Mar 2018 11:59:38 +0000
Deferred-Delivery: Thu, 22 Mar 2018 11:59:35 +0000
Message-ID: <C8603108370B1949BF3CC7742DDE5D35B8B3A037@GSjpTKYDCembx31.service.hitachi.net>
References: <5AAFA661.60103@hitachi.com>
 <CAOi1vP8qz9GeP0Beypq1N8XFwzkPieEE1Qf6gJafPnngjNG86g@mail.gmail.com>
 <CA+aFP1AunD_KvE5JkFAzzEtu+D5dKS_nhEbyvS9COQM2PXuDCw@mail.gmail.com>
In-Reply-To: <CA+aFP1AunD_KvE5JkFAzzEtu+D5dKS_nhEbyvS9COQM2PXuDCw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.29.202]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MC0JXj019368

Hi Jason,

> However, given that's the intent of this change, why not name the
> option along the lines of "discard_disbled"?

Thank you for your comments.
I would like to change the name of sysfs file to "discard_disabled".
Also, I will add an option named discard_disabled to the rdb map command.

Regards,

-- 
Hitoshi Kamei
