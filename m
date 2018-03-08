Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755854AbeCHMw0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755756AbeCHMwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:52:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295AD206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 8 Mar 2018 09:52:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf annotate: Handle s390 pc relative load and store
 instruction.
Message-ID: <20180308125220.GZ3701@kernel.org>
References: <20180308120913.14802-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308120913.14802-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 08, 2018 at 01:09:13PM +0100, Thomas Richter escreveu:
> S390 has several load and store instructions with target operand
> addressing relative to the program counter, for example lrl, lgrl,
> strl, stgrl.

Thanks, applied.

- Arnaldo
