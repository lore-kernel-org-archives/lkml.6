Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965471AbeEIQWS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:22:18 -0400
Received: from vern.gendns.com ([206.190.152.46]:48848 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965034AbeEIQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:22:17 -0400
Subject: Re: [PATCH] drm/tilcdc: Fix setting clock divider for omap-l138
To: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
References: <1521068325-15077-1-git-send-email-david@lechnology.com>
 <fe2866d2-6dd4-f6e4-ea0e-72d8a9334075@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <41cf7975-386b-dc9d-82fc-df70dad3d13d@lechnology.com>
Date: Wed, 9 May 2018 11:22:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fe2866d2-6dd4-f6e4-ea0e-72d8a9334075@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 04:05 AM, Jyri Sarha wrote:
> Thanks,
> I'll pick this for v4.18.

Ping. I don't see this in drm-misc-next yet.
