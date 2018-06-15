Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C8FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CF2208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CF2208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936436AbeFOTPJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:15:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:23522 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936269AbeFOTPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:15:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 12:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="57674614"
Received: from tzanussi-mobl2.amr.corp.intel.com (HELO [10.252.130.32]) ([10.252.130.32])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2018 12:15:05 -0700
Subject: Re: [PATCH] tracing: Fix some errors in histogram documentation
To:     Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, bigeasy@linutronix.de,
        mhiramat@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-rt-users@vger.kernel.org
References: <20180614224859.55864-1-joel@joelfernandes.org>
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
Message-ID: <3a84d411-a786-46c2-5192-cf21bc012879@linux.intel.com>
Date:   Fri, 15 Jun 2018 14:15:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614224859.55864-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 6/14/2018 5:48 PM, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Fix typos, inconsistencies in using quotes, incorrect section number,
> etc. in the trace histogram documentation.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

These all look good to me - thanks for fixing them up.

Tom

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
