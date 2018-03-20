Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeCTJ6d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:58:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35763 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeCTJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:58:28 -0400
X-Google-Smtp-Source: AG47ELuOKh8pd6yf2zDjPw50WX7+ZnLsrHlIlL9hStpP+3/hY9wrxChlo7xi8HON6jf92nxVLRrjykoq+iv1Hrj29A4=
MIME-Version: 1.0
In-Reply-To: <20180309121549.630-1-harry.pan@intel.com>
References: <20180309121549.630-1-harry.pan@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Mar 2018 10:58:27 +0100
X-Google-Sender-Auth: -6Nm4-0agc6k4daI3Cuu9LdfOPE
Message-ID: <CAJZ5v0iiALLPEO1CLQFNM6JyyVzS32napW4FQjt3PJCtP_Z2bA@mail.gmail.com>
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
To: Harry Pan <harry.pan@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>, Joe Konno <joe.konno@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 1:15 PM, Harry Pan <harry.pan@intel.com> wrote:
> Cannon Lake microarchitecture is similar to Kaby Lake in terms of
> RAPL, this patch enables CNL RAPL support.
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>

I have applied an analogous patch from Joe Konno that was posted earlier.

Thanks!


> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 35636e1d8a3d..295d8dcba48c 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1162,6 +1162,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         RAPL_CPU(INTEL_FAM6_SKYLAKE_X,          rapl_defaults_hsw_server),
>         RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,    rapl_defaults_core),
>         RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,   rapl_defaults_core),
> +       RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,  rapl_defaults_core),
>
>         RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,   rapl_defaults_byt),
>         RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,       rapl_defaults_cht),
> --
> 2.13.5
>
