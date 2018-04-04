Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeDDRSQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:18:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbeDDRSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:18:15 -0400
Date: Wed, 4 Apr 2018 18:18:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] tools: restore READ_ONCE() C++ compatibility
Message-ID: <20180404171805.kc3ldesmn2f2pjct@lakrids.cambridge.arm.com>
References: <20180404163445.16492-1-mark.rutland@arm.com>
 <7fb04d1a-79a9-0896-577b-193458e1cd48@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb04d1a-79a9-0896-577b-193458e1cd48@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:43:16PM +0530, Sandipan Das wrote:
> Hi Mark,
> 
> On 04/04/2018 10:04 PM, Mark Rutland wrote:
> > 
> > Zhijian, Sandipan, does this patch work for you?
> > 
> 
> Yes it does. Thanks for the fix.

Great! Can I take that as a Tested-by?

Thanks,
Mark.
