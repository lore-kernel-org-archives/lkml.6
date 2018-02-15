Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033549AbeBOOuH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032957AbeBOOuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:50:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD44217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 11:50:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Fix test case inet_pton to accept inlines.
Message-ID: <20180215145000.GA26423@kernel.org>
References: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 14, 2018 at 08:03:03AM +0100, Thomas Richter escreveu:
> Using Fedora 27 and latest Linux kernel the test case
> trace+probe_libc_inet_pton.sh fails again on s390.
> This time is the inlining of functions which does not match.
> After an update of the glibc (from 2.26-16 to 2.26-24)
> the output is different

Thanks, applied.

- Arnaldo
