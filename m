Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeE1TuQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 15:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933626AbeE1TuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 15:50:12 -0400
Date: Mon, 28 May 2018 16:50:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf docu: Update section on cpu description
Message-ID: <20180528195009.GH25467@kernel.org>
References: <20180528074903.21781-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528074903.21781-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 28, 2018 at 09:49:03AM +0200, Thomas Richter escreveu:
> Fix the section HEADER_CPUDESC so the documentation
> matches code.  Swap the two members of struct nr_cpus.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

I have this one already in my perf/core branch:

https://git.kernel.org/acme/c/ec6fb1a1642c2

- Arnaldo
