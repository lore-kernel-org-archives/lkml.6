Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEBQyh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:54:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32925 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEBQyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:54:33 -0400
X-Google-Smtp-Source: AB8JxZraGTJXBk5TNEGvig68kiG/YB9X+HusiMwM8Lour+L0Gt6NPS9H1RfoP69ZV0tbH2WLz9+5Pw==
Subject: Re: Warning for driver i915 for 4.17.0-rcX
To: Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <a16d75eb-56ad-6b10-502b-b9f5174b6e21@lwfinger.net>
 <87o9hyd1ru.fsf@intel.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <4371fd28-49fb-f019-1fc3-f1318b9562fd@lwfinger.net>
Date: Wed, 2 May 2018 11:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87o9hyd1ru.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 01:12 AM, Jani Nikula wrote:
> On Mon, 30 Apr 2018, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> With kernel 4.17.0-rc3, I noted the following warning from driver i915.
>>
>> kernel: ------------[ cut here ]------------
>> kernel: Could not determine valid watermarks for inherited state
>> kernel: WARNING: CPU: 3 PID: 224 at drivers/gpu/drm/i915/intel_display.c:14584
>> intel_modeset_init+0x3be/0x1060 [i915]
> 
> Please try [1], see also the related bug [2].
> 
> BR,
> Jani.
> 
> [1] http://patchwork.freedesktop.org/patch/msgid/20180426163015.14232-1-ville.syrjala@linux.intel.com
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=105992

Thanks for your reply. Patch [1] above does fix my warning.

Larry
