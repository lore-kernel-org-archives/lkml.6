Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A92C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4E32075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4E32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeIGUIv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:08:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:5374 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbeIGUIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:08:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 08:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="71172058"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2018 08:27:22 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 08:27:21 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.230]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.106]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 08:27:21 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] net: ethernet: i40e: fix build error
Thread-Topic: [PATCH v3 1/2] net: ethernet: i40e: fix build error
Thread-Index: AQHURpzA7MyI4tgZj0GeYoDpgGVJFqTk8MPw
Date:   Fri, 7 Sep 2018 15:27:21 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884C7B63C@ORSMSX115.amr.corp.intel.com>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-2-git-send-email-dongsheng.wang@hxt-semitech.com>
In-Reply-To: <1536319175-3660-2-git-send-email-dongsheng.wang@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2Q3NjQ4ZmEtOTYwOC00MmFhLWI1YmMtYzc3NmIzNzQ5YWY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVHBqMkFrSmpVdlFqNEs5aWsxeGZWU3ByQ3BZSURzNDRmejV3TUFPV3lwcWJRYm1WMFdZSmRJTXBQREM1c0dXSCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wang Dongsheng [mailto:dongsheng.wang@hxt-semitech.com]
> Sent: Friday, September 07, 2018 4:20 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov@cogentembedded.com
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem@davemloft.net; intel-
> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wang Dongsheng <dongsheng.wang@hxt-
> semitech.com>
> Subject: [PATCH v3 1/2] net: ethernet: i40e: fix build error
> 
> Remove "inline" from __i40e_add_stat_strings and move the function.
> 
> In file included from
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
> __i40e_add_stat_string:
> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
> function __i40e_add_stat_strings can never be inlined because it uses
> variable argument lists
>  static inline void __i40e_add_stat_strings(u8 **p, const struct
> 					    i40e_stats stats[],
> 
> Tested on: x86_64, make ARCH=i386
> 
> Modules section .text:
> i40e: 00019380 <__i40e_add_stat_strings>:
> i40evf: 00006b00 <__i40e_add_stat_strings>:
> 
> Buildin section .text:
> i40e: c351ca60 <__i40e_add_stat_strings>:
> i40evf: c354f2c0 <__i40e_add_stat_strings>:
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> ---
> V3: add static
> V2: Move function


Acked-by: Jacob Keller <jacob.e.keller@intel.com>


This patch fixes the build issue, and is fine with me.

Thanks,
Jake

> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++++++++++++
>  .../ethernet/intel/i40e/i40e_ethtool_stats.h  | 25 ++-----------------
>  2 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index d7d3974beca2..34121a72f2e7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1821,6 +1821,30 @@ static void i40e_get_ethtool_stats(struct net_device
> *netdev,
>  		  "ethtool stats count mismatch!");
>  }
> 
> +/**
> + * __i40e_add_stat_strings - copy stat strings into ethtool buffer
> + * @p: ethtool supplied buffer
> + * @stats: stat definitions array
> + * @size: size of the stats array
> + *
> + * Format and copy the strings described by stats into the buffer pointed at
> + * by p.
> + **/
> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +				    const unsigned int size, ...)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < size; i++) {
> +		va_list args;
> +
> +		va_start(args, size);
> +		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
> +		*p += ETH_GSTRING_LEN;
> +		va_end(args);
> +	}
> +}
> +
>  /**
>   * i40e_get_stat_strings - copy stat strings into supplied buffer
>   * @netdev: the netdev to collect strings for
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> index bba1cb0b658f..553b0d720839 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> @@ -181,29 +181,8 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring
> *ring)
>  	*data += size;
>  }
> 
> -/**
> - * __i40e_add_stat_strings - copy stat strings into ethtool buffer
> - * @p: ethtool supplied buffer
> - * @stats: stat definitions array
> - * @size: size of the stats array
> - *
> - * Format and copy the strings described by stats into the buffer pointed at
> - * by p.
> - **/
> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> -				    const unsigned int size, ...)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < size; i++) {
> -		va_list args;
> -
> -		va_start(args, size);
> -		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
> -		*p += ETH_GSTRING_LEN;
> -		va_end(args);
> -	}
> -}
> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +				    const unsigned int size, ...);
> 
>  /**
>   * 40e_add_stat_strings - copy stat strings into ethtool buffer
> --
> 2.18.0

