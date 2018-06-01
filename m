Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeFANoV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:44:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37387 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFANoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:44:17 -0400
X-Google-Smtp-Source: ADUXVKIl7TsiGt7p8zcSR/UPesXPG/1WS8hsrD5gke7CoLIWvk3HfATQAjiqnrLSvZB+n708sYDyuaG1SvTbBU6clgA=
MIME-Version: 1.0
In-Reply-To: <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
References: <20180531161708.5894-1-michel@daenzer.net> <20180531161708.5894-3-michel@daenzer.net>
 <CADnq5_O5-m_=xqszq41eOAVaLTytHUHmtDaSc1MeEorZML6T5g@mail.gmail.com> <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Jun 2018 09:44:15 -0400
Message-ID: <CADnq5_M-kS58ScgOBVQG7Mxxepae9b9gqUdMdFgaPaaxQ4NkjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add documentation for PRIME related code
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51DiPbM004081

On Fri, Jun 1, 2018 at 9:40 AM, Michel Dänzer <michel@daenzer.net> wrote:
> On 2018-06-01 02:58 PM, Alex Deucher wrote:
>> On Thu, May 31, 2018 at 12:17 PM, Michel Dänzer <michel@daenzer.net> wrote:
>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>
>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>>
>> Series is:
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Thanks. Is it okay to merge all of these via the amdgpu tree, or should
> I wait for an ack from Jon and/or core DRM maintainers for that?

GPU documentation usually goes through the drm trees.  You might want
to push patch 1 (drm_mm.rst fix) via drm_misc, but the rest are can go
in via the amdgpu tree since they are amdgpu specific.

Alex
