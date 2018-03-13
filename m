Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeCMDYB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 23:24:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:34531 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932294AbeCMDX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 23:23:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="23776822"
From: Andi Kleen <ak@linux.intel.com>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 20:23:42 -0700
In-Reply-To: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com> (Thomas
        Richter's message of "Mon, 12 Mar 2018 11:38:06 +0100")
Message-ID: <87tvtk64ld.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Richter <tmricht@linux.vnet.ibm.com> writes:

> Right now there is only hard coded support for x86.

That's not true. There is support for generic transaction events in perf.

As far as I can tell your events would map 1:1 to the generic tx-* events.

-Andi
