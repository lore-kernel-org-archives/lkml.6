Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58A2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8F62075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8F62075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeGRQKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:10:01 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39605 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbeGRQKB (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 18 Jul 2018 12:10:01 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 17:31:34 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 16:31:06 +0100
Date:   Wed, 18 Jul 2018 17:31:04 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180718153104.agcsgaoc6lhihuvo@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <20180718152556.5rydmdt7wlgpr5uk@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718152556.5rydmdt7wlgpr5uk@suselix>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:25:56PM +0200, Andreas Herrmann wrote:

 ...

> Average mean for user/system/elapsed time and standard deviation for each

Oops, of course I meant arithmetic mean.

 ...
