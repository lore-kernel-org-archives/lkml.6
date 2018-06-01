Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeFAOMy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:12:54 -0400
Received: from ms.lwn.net ([45.79.88.28]:35318 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbeFAOMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:12:51 -0400
Date: Fri, 1 Jun 2018 08:12:48 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>
Cc: Alex Deucher <alexdeucher@gmail.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu: Add documentation for PRIME related
 code
Message-ID: <20180601081248.7b65edb2@lwn.net>
In-Reply-To: <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
References: <20180531161708.5894-1-michel@daenzer.net>
        <20180531161708.5894-3-michel@daenzer.net>
        <CADnq5_O5-m_=xqszq41eOAVaLTytHUHmtDaSc1MeEorZML6T5g@mail.gmail.com>
        <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2018 15:40:44 +0200
Michel Dänzer <michel@daenzer.net> wrote:

> Thanks. Is it okay to merge all of these via the amdgpu tree, or should
> I wait for an ack from Jon and/or core DRM maintainers for that?

I've been assuming they would go through a DRM tree, no need to wait for
me.

Thanks,

jon
