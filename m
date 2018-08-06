Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC497C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C3821A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAQxWCLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C3821A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbeHFRTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeHFRTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:19:41 -0400
Received: from jouet.infradead.org (unknown [177.79.81.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3DC21A51;
        Mon,  6 Aug 2018 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568209;
        bh=r4Nugn1dOwPihDHA56x/pJ/8J3gR83rpEdyfXzFlMK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAQxWCLgs1ssnpvtui7w/+VnZSj4rvkhQFxrOlZthr0fp0S4Izo/HS6M8izDAG1fD
         UMAzQAOYF/NzTolFyGNUkQ+93m+HPbArvoKmkzHTDpDGIFfR4SodNEOvGD87/3kvEd
         dQk+FmSb6qiXyEQpuoxyPz6wdVpk1DyVqRzJQB2w=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0C565140A1C; Mon,  6 Aug 2018 12:10:07 -0300 (-03)
Date:   Mon, 6 Aug 2018 12:10:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 06/20] perf annotate: Rename hist to sym_hist in
 annotation__calc_percent
Message-ID: <20180806151006.GN7996@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 04, 2018 at 03:05:07PM +0200, Jiri Olsa escreveu:
> We will need to bring in 'struct hists' variable in this scope,
> so it's better we do this rename first.

Applied.
