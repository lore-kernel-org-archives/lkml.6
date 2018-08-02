Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D5CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56A02151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56A02151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeHBVFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:05:01 -0400
Received: from mail.us.es ([193.147.175.20]:38246 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbeHBVFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:05:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B67C6CE76C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 21:10:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A489FDA840
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 21:10:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 98D60DA7E9; Thu,  2 Aug 2018 21:10:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9C520DA786;
        Thu,  2 Aug 2018 21:10:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 02 Aug 2018 21:10:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 748CA4265A4E;
        Thu,  2 Aug 2018 21:10:19 +0200 (CEST)
Date:   Thu, 2 Aug 2018 21:12:28 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?iso-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: linux-next: Tree for Aug 2 (netfilter: tproxy)
Message-ID: <20180802191228.v4wblizz7v2qxxxy@salvia>
References: <20180802193111.346fdde9@canb.auug.org.au>
 <0185f82e-4bf5-6c6c-a131-ba2c0197c9a0@infradead.org>
 <20180802190557.sha6wer6gkdgrd6i@sch.bme.hu>
 <20180802191011.ibm2lknbzwm7zjoc@sch.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180802191011.ibm2lknbzwm7zjoc@sch.bme.hu>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:10:11PM +0200, Máté Eckl wrote:
> On Thu, Aug 02, 2018 at 09:05:57PM +0200, Máté Eckl wrote:
> > Hi Randy,
> > 
> > Thanks for reporting!
> > 
> > Please find the patch attached.
> 
> Sorry I made an error in the commit message... See the fix below.

Please, resubmit using git-send-mail so we make sure patchwork catches
this patch.

Cc'ing Randy when sending this to nf-devel, who has reported this,
that should sufficient unless he or Stephen say otherwise.

Thanks.
