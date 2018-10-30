Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A1FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323FF2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiArynSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323FF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJaE3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeJaE3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:29:14 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2372080A;
        Tue, 30 Oct 2018 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540928066;
        bh=2Zs05wlmLciUTudtNyCe337d/XT1uNuskCUz0a9ltvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiArynSzmYFJKwcD3fOCed4ezYFEZ1c0YwcwFIrxEddqnNOdZ4xfxddcfhbg+B0jj
         HbS1qVEeTvED3S7sjAyPIEcA5/5MDNi5e2vrOiktui1BXL6XQnjymv2ilfGi2Rhh7p
         iupe7Ni9wNdlx6EQ8TZfeYiaZy41WJXVZIO5r0Kk=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3829D142C5F; Tue, 30 Oct 2018 16:34:23 -0300 (-03)
Date:   Tue, 30 Oct 2018 16:34:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: clean up inconsisent indentation
Message-ID: <20181030193423.GC4454@kernel.org>
References: <20181029233211.21475-1-colin.king@canonical.com>
 <20181030144444.GB23310@kernel.org>
 <20181030192531.2ormldhqj2qizy33@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030192531.2ormldhqj2qizy33@mwanda>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 30, 2018 at 10:25:31PM +0300, Dan Carpenter escreveu:
> On Tue, Oct 30, 2018 at 11:44:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Oct 29, 2018 at 11:32:11PM +0000, Colin King escreveu:
> > > From: Colin Ian King <colin.king@canonical.com>

> > > Replace a bunch of spaces with tab, cleans up indentation

> > I think we can live with the spaces as the 'git blame' information is
> > more valuable, i.e. who was that touched that line last?
 
> You can use "git blame -w" to ignore white space changes.  I add it
> whenever I run blame.

Great! I didn't knew that, will try and get this to be the default for
'git blame' in my machines.

Thanks,

- Arnaldo
