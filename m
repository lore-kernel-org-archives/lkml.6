Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeFAN43 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:56:29 -0400
Received: from mail.netline.ch ([148.251.143.178]:32911 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeFAN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:56:25 -0400
Subject: Re: [PATCH 3/3] drm/amdgpu: Add documentation for PRIME related code
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180531161708.5894-1-michel@daenzer.net>
 <20180531161708.5894-3-michel@daenzer.net>
 <CADnq5_O5-m_=xqszq41eOAVaLTytHUHmtDaSc1MeEorZML6T5g@mail.gmail.com>
 <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
 <CADnq5_M-kS58ScgOBVQG7Mxxepae9b9gqUdMdFgaPaaxQ4NkjQ@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <494c2768-4ac8-7282-80dd-122add15b2bb@daenzer.net>
Date: Fri, 1 Jun 2018 15:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_M-kS58ScgOBVQG7Mxxepae9b9gqUdMdFgaPaaxQ4NkjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-01 03:44 PM, Alex Deucher wrote:
> On Fri, Jun 1, 2018 at 9:40 AM, Michel Dänzer <michel@daenzer.net> wrote:
>> On 2018-06-01 02:58 PM, Alex Deucher wrote:
>>> On Thu, May 31, 2018 at 12:17 PM, Michel Dänzer <michel@daenzer.net> wrote:
>>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>>
>>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>>>
>>> Series is:
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Thanks. Is it okay to merge all of these via the amdgpu tree, or should
>> I wait for an ack from Jon and/or core DRM maintainers for that?
> 
> GPU documentation usually goes through the drm trees.  You might want
> to push patch 1 (drm_mm.rst fix) via drm_misc, but the rest are can go
> in via the amdgpu tree since they are amdgpu specific.

I'd prefer merging all three patches together, since without patch 1,
patch 3 generates the warning below while generating documentation, and
the reference to the PRIME Buffer Sharing section doesn't work.

.../linux/Documentation/gpu/amdgpu.rst:2: WARNING: undefined label:
prime_buffer_sharing (if the link has no caption the label must precede
a section header)


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
