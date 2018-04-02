Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeDBRjv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:39:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37345 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbeDBRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:39:50 -0400
X-Google-Smtp-Source: AIpwx48jr6lF0Qk8MthrDhxruHY8VZeTki3nraZffT6HTHhF0QnKiwCEDLWjnomqIx/HPgxeljZgrTVAkuvbl4vXKPA=
MIME-Version: 1.0
In-Reply-To: <2b8c0ab0-e7c4-89a3-5159-6912a4c18a47@amd.com>
References: <20180330160047.7368-1-colin.king@canonical.com> <2b8c0ab0-e7c4-89a3-5159-6912a4c18a47@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Apr 2018 13:39:48 -0400
Message-ID: <CADnq5_M_1yjyvkzu4M=NifWBMLV209ZYZ0cqFJuzuXKae27_ww@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" -> "Unsupported"
To: Harry Wentland <harry.wentland@amd.com>
Cc: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:47 AM, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2018-03-30 12:00 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in DRM_ERROR error message text
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Applied.  Thanks!

>
> Harry
>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index e42a28e3adc5..1df1c91b6ae5 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1521,7 +1521,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>               break;
>>  #endif
>>       default:
>> -             DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
>> +             DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>>               goto fail;
>>       }
>>
>> @@ -1715,7 +1715,7 @@ static int dm_early_init(void *handle)
>>               break;
>>  #endif
>>       default:
>> -             DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
>> +             DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>>               return -EINVAL;
>>       }
>>
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
