Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbeCGOgw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754528AbeCGOgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:36:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150AF2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 11:36:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] perf intel-pt: Some fixes and preparation for AUX
 area sampling
Message-ID: <20180307143647.GI3701@kernel.org>
References: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 04:02:20PM +0200, Adrian Hunter escreveu:
> Hi
> 
> Here are 4 fixes for Intel PT plus 5 more patches in preparation for
> supporting AUX area sampling.

Thanks, applied to acme/perf/core.

- Arnaldo
