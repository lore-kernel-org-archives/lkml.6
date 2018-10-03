Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE44821473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE44821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeJDEU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:20:57 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:56032 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbeJDEU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:20:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 759E818076612;
        Wed,  3 Oct 2018 21:30:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spoon07_2407b30815303
X-Filterd-Recvd-Size: 3017
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Oct 2018 21:30:47 +0000 (UTC)
Message-ID: <223920513380c40710a833be02d86d8d6258cdab.camel@perches.com>
Subject: Re: [PATCH 2/3] staging: rtl8188eu: cleanup array declaration -
 style
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Oct 2018 14:30:46 -0700
In-Reply-To: <20181003204359.30676-2-straube.linux@gmail.com>
References: <20181003204359.30676-1-straube.linux@gmail.com>
         <20181003204359.30676-2-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 22:43 +0200, Michael Straube wrote:
> Cleanup array declaration to clear two 'line over 80 characters'
> checkpatch warnings and improve readability.
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
[]
> @@ -3836,24 +3836,20 @@ Following are the initialization functions for WiFi MLME
>  *****************************************************************************/
>  
>  static struct mlme_handler mlme_sta_tbl[] = {
> -	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
> -	{WIFI_ASSOCRSP,		"OnAssocRsp",	&OnAssocRsp},
> -	{WIFI_REASSOCREQ,	"OnReAssocReq",	&OnAssocReq},
> -	{WIFI_REASSOCRSP,	"OnReAssocRsp",	&OnAssocRsp},
> -	{WIFI_PROBEREQ,		"OnProbeReq",	&OnProbeReq},
> -	{WIFI_PROBERSP,		"OnProbeRsp",		&OnProbeRsp},
> -
> -	/*----------------------------------------------------------
> -					below 2 are reserved
> -	-----------------------------------------------------------*/
> -	{0,					"DoReserved",		&DoReserved},
> -	{0,					"DoReserved",		&DoReserved},
> -	{WIFI_BEACON,		"OnBeacon",		&OnBeacon},
> -	{WIFI_ATIM,			"OnATIM",		&OnAtim},
> -	{WIFI_DISASSOC,		"OnDisassoc",		&OnDisassoc},
> -	{WIFI_AUTH,			"OnAuth",		&OnAuthClient},
> -	{WIFI_DEAUTH,		"OnDeAuth",		&OnDeAuth},
> -	{WIFI_ACTION,		"OnAction",		&OnAction},
> +	{WIFI_ASSOCREQ,	  "OnAssocReq",	  &OnAssocReq},
> +	{WIFI_ASSOCRSP,	  "OnAssocRsp",	  &OnAssocRsp},
> +	{WIFI_REASSOCREQ, "OnReAssocReq", &OnAssocReq},
> +	{WIFI_REASSOCRSP, "OnReAssocRsp", &OnAssocRsp},
> +	{WIFI_PROBEREQ,	  "OnProbeReq",	  &OnProbeReq},
> +	{WIFI_PROBERSP,	  "OnProbeRsp",	  &OnProbeRsp},
> +	{0,		  "DoReserved",	  &DoReserved},
> +	{0,		  "DoReserved",	  &DoReserved},
> +	{WIFI_BEACON,	  "OnBeacon",	  &OnBeacon},
> +	{WIFI_ATIM,	  "OnATIM",	  &OnAtim},
> +	{WIFI_DISASSOC,	  "OnDisassoc",	  &OnDisassoc},
> +	{WIFI_AUTH,	  "OnAuth",	  &OnAuthClient},
> +	{WIFI_DEAUTH,	  "OnDeAuth",	  &OnDeAuth},
> +	{WIFI_ACTION,	  "OnAction",	  &OnAction},
>  };

Perhaps const here too, and as well, the struct
declaration could use const char * instead of char *



