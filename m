Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeC0Q1P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:27:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41140 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC0Q1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:27:12 -0400
X-Google-Smtp-Source: AG47ELsjlmjUQWUbyC36YK4iY8H3ERXaVHkKZi0xx98wUc1HyCuXu7X/m+dZC6qgX3i4tY3/VK3du5ERIpuuBsPCJ6Y=
MIME-Version: 1.0
In-Reply-To: <5ABA127E.5080601@hitachi.com>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn>
 <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
 <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com>
 <CAOi1vP_7La=nCs71wG3=HbYLaxM3uBFytv8pjGJLuR_uuB0GLg@mail.gmail.com>
 <C8603108370B1949BF3CC7742DDE5D35B8B42988@GSJPTKYDCEMBX32.service.hitachi.net>
 <CAOi1vP_qFkDK00-_KJpbrnC3PbP371=R4wxBH8gk2s47qwfrhg@mail.gmail.com> <5ABA127E.5080601@hitachi.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 27 Mar 2018 18:27:10 +0200
Message-ID: <CAOi1vP_NjxvPOM+y6d1mU6jcsnQENqjBeOnjhHGwwhOaEuscAw@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
To: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>,
        "sage@redhat.com" <sage@redhat.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:44 AM, KAMEI Hitoshi
<hitoshi.kamei.xm@hitachi.com> wrote:
> Hi Ilya,
>
> Thank you for reviewing.
> I merged two patches into one patch and pushed the new patch to GitHub.
> And I opened the PR. Could you check the PR?
>
> And I forgot to mention in previous email that I modified your patch to
> apply the latest kernel because I couldn't apply your patch directly
> by using git am command due to a little bit problem, and I tested
> the kernel with the modified patch and rbd map command with notrim option.
>
> The code described below is the modified patch by my hand.

Right, my patch is based on ceph/ceph-client.git:testing which has
some unrelated rbd_init_disk() changes.

Thanks,

                Ilya
