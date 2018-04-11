Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDKFDO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:03:14 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38643 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeDKFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:03:12 -0400
X-Google-Smtp-Source: AIpwx4+gmqYvH8qUQA3cPyIJkWy6pQ5glknxo5ZaD+1t1t90vF3OzyjzCdFpqg3pIaqbv9UXeLNaPq+n8MR8nmeisAw=
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com> <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com> <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com> <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com> <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Apr 2018 07:02:40 +0200
Message-ID: <CAEJqkgjfhmjwYo74xivsfgvoPQUFh2dFeXFwtEKoN+DXG1riMg@mail.gmail.com>
Subject: Re: AMD graphics performance regression in 4.15 and later
To: christian.koenig@amd.com
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        alexander.deucher@amd.com, Felix.Kuehling@amd.com,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3B53Jqf010965

>2018-04-11 6:00 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
> 2018-04-09 11:42 GMT+02:00 Christian König <ckoenig.leichtzumerken@gmail.com>:
>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
...
> I can help testing code for 4.17/++ if you wish but that is *different* storry.
>

Quick tested an 4.16.0-11490-gb284d4d5a678 , amdgpu and radeon driver
are broken now in this one.

radeon tells:

...

[    6.337838] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
[    6.338214] radeon 0000:21:00.0: disabling GPU acceleration

...

And no way to start X .. flickering and hangs.

amdgpu hits an bug:

http://ftp.frugalware.org/pub/other/people/crazy/trace.txt


Do you have some git tree I can test from ?

Also if you need full , logs or any other infos just  let me know.

Regards
