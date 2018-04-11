Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeDKRVy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:21:54 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:32785 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeDKRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:21:52 -0400
X-Google-Smtp-Source: AIpwx49WduQmY2sbC4I7G2PeeV+9i+geocQLwqS31FLQPGfMyKwfut3n82Bm+aCnQ4vu8TBR3O7ooJ76FnR71l+K9NQ=
MIME-Version: 1.0
In-Reply-To: <CAEJqkgje5Q=FLXLr_nR0gUwPpEuzx=Ln1nucJQRDXWW_0Byg=w@mail.gmail.com>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com> <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com> <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com> <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com> <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com> <CAEJqkgje5Q=FLXLr_nR0gUwPpEuzx=Ln1nucJQRDXWW_0Byg=w@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Apr 2018 19:21:20 +0200
Message-ID: <CAEJqkgg8Sk54LEA7eokG1u=Npr-cn-7cCgqnhE9xXoktvhwMcw@mail.gmail.com>
Subject: Re: AMD graphics performance regression in 4.15 and later
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        alexander.deucher@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3BHLx2V004935

2018-04-11 16:26 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
> 2018-04-11 11:37 GMT+02:00 Christian König <christian.koenig@amd.com>:
>> Am 11.04.2018 um 06:00 schrieb Gabriel C:

...
>>
>> Please test Alex's amd-staging-drm-next branch from
>> git://people.freedesktop.org/~agd5f/linux.
>
> I'm on it just the connection to freedesktop.org is slow as hell.
> Will take a while to get that branch with 62KiB/s :)
>

Testing done on that branch on commit 24110c70630998dc83da23cae910a9538f54ef64.

On default Plasma OpenGL 2.0 profiles things are still laggy but a lot better.
On OpenGL 3.1 things are working much better just minor gliches on
maximzing/minimizing windows.

Firefox is still broken , frames drops , video stops etc
Cromium-browser works fine
Otter-browser does not work at all
Qupzilla/Falkon has Firefox like issues too

Things I noticed while testing Firefox or Qupzilla..
Once these start acting up it does affect the whole Desktop,
for some secons scrolling lags , mouse is slow , etc.
Once these are closed the Desktop start working again after few seconds.


Do you want me to test any mesa/xorg-server/drivers git/branches too ?

If so just let me know.

Regards
