Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033562AbeBOOu0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032957AbeBOOuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:50:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CBD217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 11:50:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/4] perf record: Provide detailed information on s390 CPU
Message-ID: <20180215145021.GA30974@kernel.org>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 13, 2018 at 04:14:16PM +0100, Thomas Richter escreveu:
> When perf record ... is setup to record data, the s390
> cpu information was a fixed string "IBM/S390".
> 
> Replace this string with one containing more information
> about the machine. The information included in the cpuid is
> a comma separated list:
>    manufacturer,type,model-capacity,model[,version,authorization]
> with

Thanks, applied 1-4

- Arnaldo
