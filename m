Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBBQDF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:03:05 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33976 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBBQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:02:58 -0500
X-Google-Smtp-Source: AH8x227SQPDp9G+nah+47pOgDeoaOmMvkz93tlXJKcR3H5Z1W+/wSFc615JuYlftxv3O2+xMP+lFk5Tt3MFiOFUGfts=
MIME-Version: 1.0
In-Reply-To: <5307dea1-61f6-2c7b-75db-4e1a0885de30@amd.com>
References: <20180202123232.477388-1-arnd@arndb.de> <5307dea1-61f6-2c7b-75db-4e1a0885de30@amd.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 17:02:57 +0100
X-Google-Sender-Auth: zhSGMkmcmsojdn_Y7OCOCqzcnwI
Message-ID: <CAK8P3a3WN6VdJuEt=0nvC-8FCiOAVo8R=aRso4=C-jwM4rdQPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix incompatible structure layouts
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 4:39 PM, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2018-02-02 07:31 AM, Arnd Bergmann wrote:
>> Building the amd display driver with link-time optimizations revealed a bug
>
> Curious how I'd go about building with link-time optimizations.

I got the idea from last week's LWN article on the topic, see
https://lwn.net/Articles/744507/. I needed the latest gcc version to
avoid some compiler bugs, and a few dozen kernel patches on top
to get a clean build in random configurations (posted them all today).

Most normal configurations probably work out of the box, but I have
not actually tried running any ;-)

       Arnd
