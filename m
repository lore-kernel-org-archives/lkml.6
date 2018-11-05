Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB984C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EDE2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWSPQhVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EDE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbeKFDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387515AbeKFDWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:22:47 -0500
Received: from jouet.infradead.org (unknown [189.40.101.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E8B2085A;
        Mon,  5 Nov 2018 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541440462;
        bh=eswb1uCRvWa3MZsoZMzhA4u9Dtsqcscae7w3ek3Jjfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWSPQhVCgHGkNgw6SfXvMWC7EvTmETnIqwEDyrkpJkgm/jtUQUpwkHlQvSaYW0Bt+
         EgrB5J1cMSugOxLQU+CeNqOBNWtJS8Ei7z6BcrDGwGe0qePk72N1ALzlpJEgnRHXBH
         E8h+rPA5WeblGlMiEdPq+rY5/SX8cnK4r960N8c4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id DAE01142D3F; Mon,  5 Nov 2018 14:54:12 -0300 (-03)
Date:   Mon, 5 Nov 2018 14:54:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf intel-pt: Add more information to debug log
Message-ID: <20181105175412.GB7077@kernel.org>
References: <20181105073505.8129-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105073505.8129-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 09:35:03AM +0200, Adrian Hunter escreveu:
> Hi
> 
> Here is a couple of small patches to add more information to the Intel PT
> debug log.
> 
> 
> Adrian Hunter (2):
>       perf intel-pt: Add more event information to debug log
>       perf intel-pt: Add MTC and CYC timestamps to debug log

Thanks, applied both patches.

- Arnaldo
