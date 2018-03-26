Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeCZMbq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:31:46 -0400
Received: from mail7.hitachi.co.jp ([133.145.228.42]:57925 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:31:44 -0400
From: =?utf-8?B?5LqA5LqV5LuB5b+XIC8gS0FNRUnvvIxISVRPU0hJ?=
        <hitoshi.kamei.xm@hitachi.com>
To: Ilya Dryomov <idryomov@gmail.com>
CC: Dongsheng Yang <dongsheng.yang@easystack.cn>,
        "sage@redhat.com" <sage@redhat.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags
 bit
Thread-Topic: [!!]Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags
 bit
Thread-Index: AQHTwonEUhXsyCvpRUulPb6EV3xvyKPc+DOAgAV87eA=
Date: Mon, 26 Mar 2018 12:31:14 +0000
Deferred-Delivery: Mon, 26 Mar 2018 12:30:55 +0000
Message-ID: <C8603108370B1949BF3CC7742DDE5D35B8B42988@GSJPTKYDCEMBX32.service.hitachi.net>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn>
 <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
 <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com>
 <CAOi1vP_7La=nCs71wG3=HbYLaxM3uBFytv8pjGJLuR_uuB0GLg@mail.gmail.com>
In-Reply-To: <CAOi1vP_7La=nCs71wG3=HbYLaxM3uBFytv8pjGJLuR_uuB0GLg@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2QCVn12029648

Hi Ilya,

I think your patch fully completes our purpose and I confirmed
that the kernel with the patch could work well by testing in my environment.

I added the notrim option to rbd map command in accordance with
your kernel rbd driver patch, and I pushed the patch to GitHub
(https://github.com/hitoshikamei/ceph/tree/rbdmap-notrim).

So, could you please merge your patch to the kernel? If your patch is merged,
then my patch can work, so I will send the Pull Request.

Regards,

-- 
Hitoshi Kamei
