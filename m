Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeBEQ6f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752743AbeBEQ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:58:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2382172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 5 Feb 2018 13:58:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf trace: Two trivial fixes
Message-ID: <20180205165824.GC25353@kernel.org>
References: <20180130053053.13214-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130053053.13214-1-ravi.bangoria@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 30, 2018 at 11:00:51AM +0530, Ravi Bangoria escreveu:
> Two independent fixes:
> First adds 'generated' directory into .gitignore
> Second fixes call-graph output with perf trace
> 
> Ravi Bangoria (2):
>   perf tools: Add trace/beauty/generated/ into .gitignore
>   perf trace: Fix call-graph output
> 

Thanks, applied both to perf/urgent.

- Arnaldo
