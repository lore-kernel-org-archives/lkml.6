Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532DC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623EA27ECE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623EA27ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965676AbeF2U51 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:57:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753354AbeF2U5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:57:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TKs0M0033537
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 16:57:25 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwujk9af5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 16:57:25 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 21:57:23 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 21:57:20 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TKvJKO21561450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 20:57:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5251F4C04E;
        Fri, 29 Jun 2018 21:57:06 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9F044C046;
        Fri, 29 Jun 2018 21:57:05 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jun 2018 21:57:05 +0100 (BST)
Date:   Fri, 29 Jun 2018 23:57:16 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arc/Kconfig: include mm/Kconfig inside "ARC system
 configuration"
References: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
 <4c84ef6c-fa71-8b74-826a-d81dac8c71e7@infradead.org>
 <20180629192838.GE4799@rapoport-lnx>
 <e18f80e1-fc59-9487-95eb-7cb6cda976c5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e18f80e1-fc59-9487-95eb-7cb6cda976c5@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18062920-0012-0000-0000-00000285176C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062920-0013-0000-0000-000020B6856E
Message-Id: <20180629205716.GG4799@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806290221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:28:59PM -0700, Randy Dunlap wrote:
> On 06/29/2018 12:28 PM, Mike Rapoport wrote:
> > Hi Randy, 
> > 
> > On Fri, Jun 29, 2018 at 09:34:55AM -0700, Randy Dunlap wrote:
> >> On 06/29/2018 06:42 AM, Mike Rapoport wrote:
> >>> Otherwise mm configuration options show up in the top level menu.
> >>>
> >>> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> >>
> >> Hi Mike,
> >>
> >> In which config tool does this matter?
> >>
> >> For xconfig, it seems to me that this patch hides the MM menu, whereas
> >> before this patch, the MM menu is easy to find (although it could
> >> use some kind of heading).
> > 
> > With xconfig the menu gets into the top right pane when you click on "ARC
> > architecture configuration", similar to what one gets on x86 with
> > "Processor type and features" or "Kernel features" on ARM.
> > 
> > With menuconfig it looks a bit more prominent, note that mm options are
> > between "ARC Architecture Configuration" and "Networking support":
> 
> I know.  I ran all 4 of menuconfig, nconfig, xconfig, and gconfig.
> 
> I would prefer to see Memory Management options have its own top-level
> menu, but that's a different patch.  Then menuconfig would look like this:
> 
> 
> 
> │ │        *** Compiler: arc-linux-gcc (GCC) 8.1.0 ***                  │ │  
>   │ │        General setup  --->                                          │ │  
>   │ │    [*] Enable loadable module support  --->                         │ │  
>   │ │    [*] Enable the block layer  --->                                 │ │  
>   │ │        ARC Architecture Configuration  --->                         │ │  
>   │ │        Memory Management options  --->                              │ │  
>   │ │    (11) Maximum zone order                                          │ │  
>   │ │    [*] Networking support  --->                                     │ │  
>   │ │        Device Drivers  --->                                         │ │  
>   │ │        Bus Support  ---> 
> 
> 
> but that "Maximum zone order" needs to be moved or taken care of somehow.

I think that would be something like this:

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index e81bcd271be7..44a20141639a 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -556,12 +556,14 @@ endmenu
 
 endmenu	 # "ARC Architecture Configuration"
 
+menu "Memory Management"
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	default "12" if ARC_HUGEPAGE_16M
 	default "11"
+endmenu # "Memory Management"
 
 source "net/Kconfig"
 source "drivers/Kconfig"
 
> 
> [snip]
> 
> > 
> > 
> > 
> >>>  	default "12" if ARC_HUGEPAGE_16M
> >>>  	default "11"
> >>>  
> >>> +endmenu	 # "ARC Architecture Configuration"
> >>> +
> >>>  source "net/Kconfig"
> >>>  source "drivers/Kconfig"
> 
> 
> thanks,
> -- 
> ~Randy
> 

-- 
Sincerely yours,
Mike.

