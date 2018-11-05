Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A0BC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563D320825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL2BR4g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563D320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbeKFDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387724AbeKFDWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:22:47 -0500
Received: from jouet.infradead.org (unknown [189.40.101.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD83020827;
        Mon,  5 Nov 2018 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541440407;
        bh=NjON4f796Gh5j285sirDMp2HD0PXGVPz+GemCaf9Q18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vL2BR4g/anQEE8t33tAfhgDCt6KUMeQTDquH/D+o+mHXMp4nC2LEImTk7UtOp+ob5
         It73NHnLF4ugXGzpAuFJD5LKtOdtuczy2VEyVo6f+B+wQEjwtLoeBki6LDH7TcsRXg
         GDOIQjEnzn7/QzSVDFsArzwaV5pIoT1xD8VeBbkQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7BAE6142D3F; Mon,  5 Nov 2018 14:53:19 -0300 (-03)
Date:   Mon, 5 Nov 2018 14:53:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/4] perf scripts python: exported-sql-viewer.py
Message-ID: <20181105175319.GA7077@kernel.org>
References: <20181104151238.15947-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104151238.15947-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 04, 2018 at 05:12:34PM +0200, Adrian Hunter escreveu:
> Hi
> 
> Here is the libxed fix, the last 2 patches from last submission and another
> fix.
> 
> Changes in V2:

Thanks, applied the four patches.

- Arnaldo
