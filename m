Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeCTRJF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:09:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43846 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeCTRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:09:03 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Joe Konno <joe.konno@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powercap / RAPL: add support for Cannon Lake
Date: Tue, 20 Mar 2018 18:09:31 +0100
Message-ID: <5948747.OLenF6MVTZ@aspire.rjw.lan>
In-Reply-To: <20180302183251.139493-1-joe.konno@linux.intel.com>
References: <20180302183251.139493-1-joe.konno@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 2, 2018 7:32:51 PM CET Joe Konno wrote:
> From: Joe Konno <joe.konno@intel.com>
> 
> RAPL MSRs and handling for Cannon Lake are similar to Sky Lake and Kaby
> Lake.
> 
> Signed-off-by: Joe Konno <joe.konno@intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 35636e1d8a3d..295d8dcba48c 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1162,6 +1162,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>  	RAPL_CPU(INTEL_FAM6_SKYLAKE_X,		rapl_defaults_hsw_server),
>  	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
>  	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
> +	RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,	rapl_defaults_core),
>  
>  	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
>  	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
> 

Applied, thanks!
