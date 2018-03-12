Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeCLPKq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeCLPKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:10:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043E6205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 12:10:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Make function perf_stat_evsel_id_init static
Message-ID: <20180312151041.GB23720@kernel.org>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 11:38:07AM +0100, Thomas Richter escreveu:
> Function perf_stat_evsel_id_init() has global linkage
> but is only used in util/stat.c. Make it static.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo
