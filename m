Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeCNRbq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:31:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:11666 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeCNRbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:31:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,306,1517904000";
   d="scan'208";a="24661625"
Date: Wed, 14 Mar 2018 10:31:28 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Message-ID: <20180314173128.GH13724@tassilo.jf.intel.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
 <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
 <20180314131850.GA27335@kernel.org>
 <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
 <20180314154317.GG13724@tassilo.jf.intel.com>
 <20180314164236.GB5297@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314164236.GB5297@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Displaying these different types for s390 is important from my point of
> view.  Of course, I could create a mapping of TX_NC_TABORT/TX_NC_TEND
> to tx-commit/tx-abort.  The remaining events would still appear to be specific
> to the cpum_cf.

If you want more generic metrics you can just use the new json generic metrics /
metric group support in the eventlist. In fact if we did it today I wouldn't
add perf stat -T at all, but just use that.

-Andi
